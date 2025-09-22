import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:fernet/fernet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class MediaController extends GetxController {
  final Dio _dio = Dio();
  final storage = GetStorage();

  // وضعیت‌ها
  final isDownloading = false.obs;
  final downloadProgress = 0.0.obs; // 0..1
  final status = ''.obs;
  final localPath = ''.obs;
  final isVideo = false.obs;

  // audio
  final AudioPlayer audioPlayer = AudioPlayer();
  final isPlaying = false.obs;
  final duration = Duration.zero.obs;
  final position = Duration.zero.obs;
  final playbackSpeed = 1.0.obs;

  // video
  VideoPlayerController? videoController;
  ChewieController? chewieController;

  // کلید فِرنِت (همان رشته ای که در پایتون استفاده شد)
  final String rawBase64Key = "eyK8ChqU3JXJic1kuT1saK43vObNgY+w/EdSGAiOkbc=";

  @override
  void onClose() {
    audioPlayer.dispose();
    videoController?.dispose();
    chewieController?.dispose();
    super.onClose();
  }

  // کمک: تولید یک کلید ذخیره‌سازی امن برای url
  String _storageKeyForUrl(String url) {
    final bytes = utf8.encode(url);
    return 'cached_' + base64Url.encode(bytes);
  }

  // بررسی کش
  Future<bool> hasCachedFor(String url) async {
    final key = _storageKeyForUrl(url);
    final data = storage.read<Map>(key);
    if (data == null) return false;
    final path = data['path'] as String?;
    final videoFlag = data['isVideo'] as bool? ?? false;
    if (path == null) return false;
    final f = File(path);
    final exists = await f.exists();
    if (exists) {
      localPath.value = path;
      isVideo.value = videoFlag;
      return true;
    } else {
      storage.remove(key);
      return false;
    }
  }

  // دانلود + رمزگشایی + آماده‌سازی پلیر
  Future<void> downloadAndDecrypt(
    String url, {
    required bool fileIsVideo,
  }) async {
    final key = _storageKeyForUrl(url);
    try {
      // اگر کش داریم، فقط init کن
      if (await hasCachedFor(url)) {
        status.value = 'loaded from cache';
        await _preparePlayer(File(localPath.value), fileIsVideo: isVideo.value);
        return;
      }

      isDownloading.value = true;
      downloadProgress.value = 0;
      status.value = 'downloading';

      final dir = await getTemporaryDirectory();
      final encFile = File(
        '${dir.path}/enc_${DateTime.now().millisecondsSinceEpoch}',
      );

      await _dio.download(
        url,
        encFile.path,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            downloadProgress.value = received / total;
          }
        },
      );

      status.value = 'decrypting';

      final encryptedBytes = await encFile.readAsBytes();

      // آماده‌سازی کلید: تبدیل base64 معمولی به urlsafe base64
      final keyBytes = base64.decode(rawBase64Key);
      final urlSafeKey = base64Url.encode(keyBytes);

      final fernet = Fernet(urlSafeKey);

      // decrypt (توجه: کل داده باید در حافظه باشد)
      final Uint8List decrypted = fernet.decrypt(encryptedBytes);

      final extension = fileIsVideo ? '.mp4' : '.mp3';
      final outFile = File(
        '${dir.path}/dec_${DateTime.now().millisecondsSinceEpoch}$extension',
      );

      await outFile.writeAsBytes(decrypted, flush: true);

      // ذخیره در GetStorage
      storage.write(key, {'path': outFile.path, 'isVideo': fileIsVideo});
      localPath.value = outFile.path;
      isVideo.value = fileIsVideo;

      status.value = 'ready';

      // آماده‌سازی پلیر
      await _preparePlayer(outFile, fileIsVideo: fileIsVideo);
    } catch (e, st) {
      status.value = 'error: $e';
      debugPrint('downloadAndDecrypt error: $e\n$st');
    } finally {
      isDownloading.value = false;
      downloadProgress.value = 0;
    }
  }

  Future<void> _preparePlayer(File file, {required bool fileIsVideo}) async {
    if (fileIsVideo) {
      await _initVideoPlayer(file);
    } else {
      await _initAudioPlayer(file);
    }
  }

  // ----- Audio -----
  Future<void> _initAudioPlayer(File file) async {
    try {
      await audioPlayer.setFilePath(file.path);
      duration.value = audioPlayer.duration ?? Duration.zero;

      audioPlayer.positionStream.listen((p) {
        position.value = p;
      });
      audioPlayer.playerStateStream.listen((state) {
        isPlaying.value = state.playing;
      });
    } catch (e) {
      debugPrint('audio init error: $e');
    }
  }

  void togglePlayPause() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
  }

  Future<void> seekAudio(Duration to) async {
    await audioPlayer.seek(to);
  }

  void setAudioSpeed(double s) {
    playbackSpeed.value = s;
    audioPlayer.setSpeed(s);
  }

  // ----- Video -----
  Future<void> _initVideoPlayer(File file) async {
    try {
      await videoController?.dispose();
      chewieController?.dispose();

      videoController = VideoPlayerController.file(file);
      await videoController!.initialize();

      chewieController = ChewieController(
        videoPlayerController: videoController!,
        autoPlay: false,
        looping: false,
        allowPlaybackSpeedChanging: true,
        allowedScreenSleep: false,
      );

      // اگر خواستی position/duration برای UI رو هم از videoController بذار
      // می‌توانی با Obx در UI اطلاعات را نمایش دهی.
    } catch (e) {
      debugPrint('video init error: $e');
    }
  }

  void setVideoSpeed(double s) {
    if (videoController != null) {
      videoController!.setPlaybackSpeed(s);
    }
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
    await audioPlayer.seek(Duration.zero);
  }

  Future<void> removeCacheForUrl(String url) async {
    final key = _storageKeyForUrl(url);
    final data = storage.read<Map>(key);
    if (data != null && data['path'] != null) {
      final f = File(data['path']);
      if (await f.exists()) await f.delete();
    }
    storage.remove(key);
  }
}
