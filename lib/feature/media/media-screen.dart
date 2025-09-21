// lib/pages/media_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcast/data/api/media/media-controller.dart';

class MediaPage extends StatelessWidget {
  final String url;
  final String keyBase64;

  MediaPage({required this.url, required this.keyBase64});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController(url: url, base64Key: keyBase64));

    return Scaffold(
      appBar: AppBar(title: Text("Audio Player (AES-CFB)")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(value: controller.progress.value),
                SizedBox(height: 12),
                Text(
                  "دانلود و رمزگشایی... ${(controller.progress.value * 100).toStringAsFixed(0)}%",
                ),
              ],
            ),
          );
        }

        if (controller.player == null) {
          return Center(child: Text("خطا در آماده‌سازی صوت"));
        }

        // از stream های just_audio برای نمایش موقعیت و مدت استفاده می‌کنیم
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<Duration?>(
                stream: controller.player!.durationStream,
                builder: (context, snapshotDur) {
                  final duration = snapshotDur.data ?? Duration.zero;
                  return StreamBuilder<Duration>(
                    stream: controller.player!.positionStream,
                    builder: (context, snapshotPos) {
                      final position = snapshotPos.data ?? Duration.zero;
                      final max = duration.inMilliseconds > 0
                          ? duration.inMilliseconds.toDouble()
                          : 1.0;
                      final val = position.inMilliseconds.toDouble().clamp(
                        0,
                        max,
                      );
                      return Column(
                        children: [
                          Slider(
                            min: 0,
                            max: max,
                            value: val.toDouble(),
                            onChanged: (v) {
                              controller.seek(
                                Duration(milliseconds: v.toInt()),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_formatDuration(position)),
                              Text(_formatDuration(duration)),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 24),
              Obx(() {
                return IconButton(
                  iconSize: 56,
                  icon: Icon(
                    controller.isPlaying.value
                        ? Icons.pause_circle
                        : Icons.play_circle,
                  ),
                  onPressed: () => controller.togglePlayPause(),
                );
              }),
            ],
          ),
        );
      }),
    );
  }

  String _formatDuration(Duration d) {
    final twoDigits = (int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
