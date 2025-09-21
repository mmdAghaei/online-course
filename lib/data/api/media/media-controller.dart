// lib/data/api/media/media-controller.dart
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/export.dart';
import 'package:just_audio/just_audio.dart';

class MediaController extends GetxController {
  final String url;
  final String base64Key;
  final box = GetStorage();

  MediaController({required this.url, required this.base64Key});

  var isLoading = true.obs;
  var progress = 0.0.obs;
  var isPlaying = false.obs;

  File? decryptedFile;
  AudioPlayer? player;

  @override
  void onInit() {
    super.onInit();
    _prepareMedia();
  }

  Future<void> _prepareMedia() async {
    isLoading.value = true;
    progress.value = 0.0;

    try {
      // استفاده از کش اگر وجود داشته باشه
      final cachedPath = box.read(url);
      if (cachedPath != null && !kIsWeb) {
        final f = File(cachedPath);
        if (await f.exists()) {
          decryptedFile = f;
          await _initPlayer(useFilePath: true);
          isLoading.value = false;
          progress.value = 1.0;
          return;
        } else {
          box.remove(url);
        }
      }

      // دانلود کامل فایل
      progress.value = 0.02;
      final resp = await http.get(Uri.parse(url));
      if (resp.statusCode != 200) throw Exception("HTTP ${resp.statusCode}");
      final allBytes = resp.bodyBytes;
      if (allBytes.length < 16) throw Exception("فایل نامعتبر: IV ناقص");
      progress.value = 0.06;

      // IV و ciphertext
      final iv = Uint8List.fromList(allBytes.sublist(0, 16));
      final cipherBytes = Uint8List.fromList(allBytes.sublist(16));
      final encLength = allBytes.length;
      print(
        "downloaded encrypted length: $encLength, cipherBytes: ${cipherBytes.length}",
      );

      // آماده‌سازی کلید
      final padded = base64Key.padRight((base64Key.length + 3) ~/ 4 * 4, '=');
      final keyBytes = base64.decode(padded);
      print("key length: ${keyBytes.length}");
      if (!(keyBytes.length == 16 ||
          keyBytes.length == 24 ||
          keyBytes.length == 32)) {
        throw Exception("طول کلید AES نامعتبر");
      }
      progress.value = 0.08;

      // اگر بخوایم روی موبایل/دسکتاپ فایل رمزنگاری‌شده رو روی دیسک بنویسیم و سپس چانک‌چانک رمزگشایی کنیم:
      final tempDir = await getTemporaryDirectory();
      final encFile = File(
        "${tempDir.path}/enc_${DateTime.now().millisecondsSinceEpoch}",
      );
      await encFile.writeAsBytes(allBytes, flush: true);
      progress.value = 0.12;

      // باز کردن raf و خواندن IV از فایل (ایمن)
      final raf = await encFile.open(mode: FileMode.read);
      try {
        final readIv = await raf.read(16);
        if (readIv.length != 16) throw Exception("IV ناقص پس از نوشتن فایل.");
        // ساخت cipher (CFB-8)
        final cipher = CFBBlockCipher(AESFastEngine(), 8);
        try {
          cipher.init(
            false,
            ParametersWithIV(
              KeyParameter(Uint8List.fromList(keyBytes)),
              readIv,
            ),
          );
        } on UnimplementedError catch (e) {
          print("engine.init not implemented: $e");
          throw Exception("موتور AES در این محیط پشتیبانی نمی‌شود.");
        }

        // فایل خروجی رمزگشایی‌شده
        final outFile = File(
          "${tempDir.path}/dec_${DateTime.now().millisecondsSinceEpoch}.mp3",
        );
        final sink = outFile.openWrite(mode: FileMode.write);

        // خواندن و پردازش در چانک‌ها
        final totalCipherBytes = await encFile.length() - 16;
        final chunkSize = 8192;
        int processed = 0;
        while (processed < totalCipherBytes) {
          final remaining = totalCipherBytes - processed;
          final toRead = remaining < chunkSize ? remaining : chunkSize;
          final chunk = await raf.read(toRead);
          if (chunk.isEmpty) break;
          final out = cipher.process(Uint8List.fromList(chunk));
          sink.add(out);
          processed += chunk.length;
          progress.value = 0.12 + 0.7 * (processed / totalCipherBytes);
        }
        await sink.flush();
        await sink.close();

        decryptedFile = outFile;
      } finally {
        await raf.close();
      }

      progress.value = 0.95;

      // ذخیره مسیر در کش (فقط موبایل/دسکتاپ)
      if (!kIsWeb && decryptedFile != null) box.write(url, decryptedFile!.path);

      // init پلیر (روی web از data URI استفاده می‌کنیم)
      await _initPlayer(useFilePath: !kIsWeb);

      progress.value = 1.0;
      isLoading.value = false;
    } catch (e, st) {
      print("خطا در رمزگشایی: $e\n$st");
      isLoading.value = false;
    }
  }

  Future<void> _initPlayer({bool useFilePath = true}) async {
    try {
      player ??= AudioPlayer();

      // همگام‌سازی وضعیت isPlaying با استریم پلیر
      player!.playingStream.listen(
        (playing) {
          isPlaying.value = playing;
        },
        onError: (e) {
          print("playingStream error: $e");
        },
      );

      player!.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          isPlaying.value = false;
          // اگر لازم بود ریست پوزیشن:
          player!.seek(Duration.zero);
        }
      });

      if (kIsWeb) {
        // وب: از data: URI استفاده می‌کنیم (ممکنه برای فایل‌های بزرگ حافظه زیادی مصرف کنه)
        final bytes = await decryptedFile!.readAsBytes();
        final b64 = base64Encode(bytes);
        final mime = 'audio/mpeg'; // اگر mp3 هست
        final dataUri = 'data:$mime;base64,$b64';
        print("setting web data URI (length ${b64.length})");
        await player!.setUrl(dataUri);
      } else {
        // موبایل/دسکتاپ: مسیر فایل محلی
        if (decryptedFile == null) throw Exception("فایل خروجی آماده نیست.");
        await player!.setFilePath(decryptedFile!.path);
      }

      // توجه: Auto-play نذاریم؛ کاربر با دکمه کنترل کنه.
      // در صورت نیاز autoplay:
      // await player!.play();
      // isPlaying.value = true;
    } catch (e, st) {
      print("initPlayer error: $e\n$st");
      rethrow;
    }
  }

  Future<void> togglePlayPause() async {
    try {
      if (player == null) {
        print("player is null in togglePlayPause");
        return;
      }
      if (player!.playing) {
        await player!.pause();
        // isPlaying توسط listening به‌روز میشه
      } else {
        await player!.play();
      }
    } catch (e) {
      print("togglePlayPause error: $e");
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await player?.seek(position);
    } catch (e) {
      print("seek error: $e");
    }
  }

  @override
  void onClose() {
    player?.dispose();
    super.onClose();
  }
}
