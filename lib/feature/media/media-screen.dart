import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/data/api/media/media.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends StatelessWidget {
  final String url;
  const PlayerPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final MediaController c = Get.put(MediaController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloader & Player'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.download),
                    label: const Text('Download & Play (Audio)'),
                    onPressed: () {
                      if (url.isNotEmpty) {
                        c.downloadAndDecrypt(url, fileIsVideo: false);
                      } else {
                        Get.snackbar('Error', 'Please enter URL');
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.video_library),
                    label: const Text('Download & Play (Video)'),
                    onPressed: () {
                      if (url.isNotEmpty) {
                        c.downloadAndDecrypt(url, fileIsVideo: true);
                      } else {
                        Get.snackbar('Error', 'Please enter URL');
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // وضعیت و پروگرس
            Obx(() {
              if (c.isDownloading.value) {
                return Column(
                  children: [
                    LinearProgressIndicator(value: c.downloadProgress.value),
                    const SizedBox(height: 8),
                    Text(
                      'Downloading ${(c.downloadProgress.value * 100).toStringAsFixed(1)}%',
                    ),
                  ],
                );
              }
              return Text('Status: ${c.status.value}');
            }),

            const SizedBox(height: 16),

            // نمایش پلیر بسته به نوع
            Obx(() {
              if (c.localPath.value.isEmpty) {
                return const Expanded(
                  child: Center(child: Text('No media loaded')),
                );
              }
              if (c.isVideo.value) {
                // Video UI
                if (c.videoController == null || c.chewieController == null) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return Expanded(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: c.videoController!.value.aspectRatio,
                        child: Chewie(controller: c.chewieController!),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Speed:'),
                          const SizedBox(width: 8),
                          DropdownButton<double>(
                            value: c.videoController!.value.playbackSpeed,
                            items: const [
                              DropdownMenuItem(value: 0.5, child: Text('0.5x')),
                              DropdownMenuItem(
                                value: 0.75,
                                child: Text('0.75x'),
                              ),
                              DropdownMenuItem(value: 1.0, child: Text('1.0x')),
                              DropdownMenuItem(
                                value: 1.25,
                                child: Text('1.25x'),
                              ),
                              DropdownMenuItem(value: 1.5, child: Text('1.5x')),
                              DropdownMenuItem(value: 2.0, child: Text('2.0x')),
                            ],
                            onChanged: (v) {
                              if (v != null) c.setVideoSpeed(v);
                            },
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.delete_forever),
                            onPressed: () {
                              // حذف کش
                              c.removeCacheForUrl(c.localPath.value);
                              c.localPath.value = '';
                              c.isVideo.value = false;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                // Audio UI
                final file = File(c.localPath.value);
                return Expanded(
                  child: Column(
                    children: [
                      const Icon(Icons.music_note, size: 80),
                      const SizedBox(height: 8),
                      Text('File: ${file.path.split('/').last}'),
                      const SizedBox(height: 12),
                      // اسلایدر موقعیت
                      Obx(() {
                        final dur = c.duration.value;
                        final pos = c.position.value;
                        final max = dur.inMilliseconds > 0
                            ? dur.inMilliseconds.toDouble()
                            : 1.0;
                        final val = pos.inMilliseconds.toDouble().clamp(
                          0.0,
                          max,
                        );
                        return Column(
                          children: [
                            Slider(
                              value: val,
                              min: 0,
                              max: max,
                              onChanged: (v) {
                                c.seekAudio(Duration(milliseconds: v.toInt()));
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_formatDuration(pos)),
                                Text(_formatDuration(dur)),
                              ],
                            ),
                          ],
                        );
                      }),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 36,
                            icon: const Icon(Icons.replay_10),
                            onPressed: () {
                              final newPos =
                                  c.position.value -
                                  const Duration(seconds: 10);
                              c.seekAudio(
                                newPos < Duration.zero ? Duration.zero : newPos,
                              );
                            },
                          ),
                          Obx(() {
                            return IconButton(
                              iconSize: 56,
                              icon: Icon(
                                c.isPlaying.value
                                    ? Icons.pause_circle
                                    : Icons.play_circle,
                              ),
                              onPressed: () {
                                c.togglePlayPause();
                              },
                            );
                          }),
                          IconButton(
                            iconSize: 36,
                            icon: const Icon(Icons.forward_10),
                            onPressed: () {
                              final newPos =
                                  c.position.value +
                                  const Duration(seconds: 10);
                              final dur = c.duration.value;
                              c.seekAudio(newPos > dur ? dur : newPos);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // سرعت پخش
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Speed:'),
                          const SizedBox(width: 8),
                          Obx(() {
                            return DropdownButton<double>(
                              value: c.playbackSpeed.value,
                              items: const [
                                DropdownMenuItem(
                                  value: 0.5,
                                  child: Text('0.5x'),
                                ),
                                DropdownMenuItem(
                                  value: 0.75,
                                  child: Text('0.75x'),
                                ),
                                DropdownMenuItem(
                                  value: 1.0,
                                  child: Text('1.0x'),
                                ),
                                DropdownMenuItem(
                                  value: 1.25,
                                  child: Text('1.25x'),
                                ),
                                DropdownMenuItem(
                                  value: 1.5,
                                  child: Text('1.5x'),
                                ),
                                DropdownMenuItem(
                                  value: 2.0,
                                  child: Text('2.0x'),
                                ),
                              ],
                              onChanged: (v) {
                                if (v != null) c.setAudioSpeed(v);
                              },
                            );
                          }),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              // حذف کش براساس URL غیرممکن است اینجا چون url نداریم؛
                              // اگر می‌خوای حذف کنی، از removeCacheForUrl با url اصلی استفاده کن
                              Get.snackbar(
                                'Info',
                                'To clear cache use removeCacheForUrl(url)',
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final twoDigits = (int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
