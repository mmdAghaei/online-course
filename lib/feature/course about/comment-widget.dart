import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/data/api/comment-api-controller.dart';
import 'package:podcast/feature/course%20about/comment-controller.dart';
import 'package:podcast/main.dart';

class Reply {
  final String author;
  final String replyTo;
  final String message;
  final DateTime time;

  Reply({
    required this.author,
    required this.replyTo,
    required this.message,
    DateTime? time,
  }) : time = time ?? DateTime.now();

  factory Reply.fromJson(Map<String, dynamic> json, {String? defaultReplyTo}) {
    String author = '';
    if (json['user'] is String) {
      author = json['user'];
    } else if (json['user'] is Map) {
      author = json['user']['name']?.toString() ?? '';
    } else if (json['author'] != null) {
      author = json['author'].toString();
    }

    final message = (json['content'] ?? json['message'] ?? '').toString();

    DateTime parsedTime;
    final created = (json['created_at'] ?? json['time'] ?? '').toString();
    try {
      parsedTime = DateTime.parse(created);
    } catch (_) {
      parsedTime = DateTime.now();
    }

    final replyTo =
        (json['reply_to'] ?? json['replyTo'] ?? defaultReplyTo ?? '')
            .toString();

    return Reply(
      author: author,
      replyTo: replyTo,
      message: message,
      time: parsedTime,
    );
  }
}

class Comment {
  final String id;
  final String author;
  final String timeString;
  final String message;
  final RxList<Reply> replies;
  final RxBool expanded;

  Comment({
    required this.id,
    required this.author,
    required this.timeString,
    required this.message,
    List<Reply>? replies,
    bool expanded = false,
  }) : replies = (replies ?? <Reply>[]).obs,
       expanded = expanded.obs;

  factory Comment.fromJson(Map<String, dynamic> json) {
    final id = (json['id'] ?? json['comment_id'] ?? '').toString();
    String author = '';
    if (json['user'] is String)
      author = json['user'];
    else if (json['user'] is Map)
      author = json['user']['name']?.toString() ?? '';
    else if (json['author'] != null)
      author = json['author'].toString();

    final timeString = (json['created_at'] ?? json['time'] ?? '').toString();
    final message = (json['content'] ?? json['message'] ?? '').toString();

    final List<dynamic>? rawReplies =
        json['replay_list'] ?? json['reply_list'] ?? json['replies'];

    final parsedReplies = <Reply>[];
    if (rawReplies != null) {
      for (var r in rawReplies) {
        if (r is Map<String, dynamic>) {
          parsedReplies.add(Reply.fromJson(r, defaultReplyTo: author));
        } else if (r is Map) {
          parsedReplies.add(
            Reply.fromJson(
              Map<String, dynamic>.from(r),
              defaultReplyTo: author,
            ),
          );
        }
      }
    }

    return Comment(
      id: id,
      author: author,
      timeString: timeString,
      message: message,
      replies: parsedReplies,
      expanded: false,
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment comment;
  final String Courseid;
  const CommentCard({Key? key, required this.comment, required this.Courseid})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CommentApiController commentApiController = Get.find();
    final CommentsController ctrl = Get.find();
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Text(_initials(comment.author)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MessageBubble(
                        name: comment.author,
                        time: comment.timeString,
                        message: comment.message,
                        isUser: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => TextButton.icon(
                    icon: Icon(
                      comment.expanded.value
                          ? Icons.expand_less
                          : Icons.expand_more,
                    ),
                    label: Text('پاسخ‌ها (${comment.replies.length})'),
                    onPressed: () => ctrl.toggleExpand(comment),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  icon: const Icon(Icons.reply),
                  label: const Text('پاسخ'),
                  onPressed: () => _openReplySheet(
                    context,
                    comment,
                    commentApiController,
                    Courseid,
                  ),
                ),
              ],
            ),

            Obx(() {
              if (!comment.expanded.value) return const SizedBox.shrink();
              return Column(
                children: comment.replies
                    .map(
                      (r) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            const SizedBox(width: 40),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            r.author + ' → ' + r.replyTo,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          _shortTime(r.time),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(r.message),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _openReplySheet(
    BuildContext context,
    Comment comment,
    CommentApiController c,
    String courseid,
  ) {
    final TextEditingController textController = TextEditingController();
    String selectedReplyTo = comment.author;

    Get.bottomSheet(
      Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${box.read("userData")["first_name"]} ${box.read("userData")["last_name"]}",
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedReplyTo,
                      decoration: const InputDecoration(labelText: 'پاسخ به'),
                      items: _replyTargets(comment)
                          .map(
                            (u) => DropdownMenuItem(value: u, child: Text(u)),
                          )
                          .toList(),
                      onChanged: (v) => selectedReplyTo = v ?? selectedReplyTo,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                controller: textController,
                minLines: 1,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'متن پاسخ...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final text = textController.text.trim();
                        // print(Courseid);
                        // print(text);
                        // print(comment.id);
                        c.CreateReply(Courseid, text, comment.id);

                        if (text.isEmpty) return;
                        final reply = Reply(
                          author:
                              "${box.read("userData")["first_name"]} ${box.read("userData")["last_name"]}",
                          replyTo: selectedReplyTo,
                          message: text,
                        );
                        Get.find<CommentsController>().addReply(
                          comment.id,
                          reply,
                        );
                        Get.back();
                      },
                      child: const Text('ارسال'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  List<String> _replyTargets(Comment comment) {
    final set = <String>{};
    set.add(comment.author);
    for (var r in comment.replies) set.add(r.author);
    return set.toList();
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r"\s+"));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.characters.first;
    return '${parts.first.characters.first}${parts.last.characters.first}';
  }

  String _shortTime(DateTime t) {
    final now = DateTime.now();
    final diff = now.difference(t);
    if (diff.inMinutes < 1) return 'اکنون';
    if (diff.inHours < 1) return '${diff.inMinutes} دقیقه پیش';
    if (diff.inDays < 1) return '${diff.inHours} ساعت پیش';
    return '${diff.inDays} روز پیش';
  }
}

// MessageBubble ساده‌شده
class MessageBubble extends StatelessWidget {
  final String name;
  final String time;
  final String message;
  final bool isUser;

  const MessageBubble({
    Key? key,
    required this.name,
    required this.time,
    required this.message,
    required this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bubbleColor = Colors.white;
    final borderRadius = isUser
        ? const BorderRadius.only(
            topRight: Radius.circular(14),
            topLeft: Radius.circular(14),
            bottomLeft: Radius.circular(14),
            bottomRight: Radius.circular(6),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(14),
            topLeft: Radius.circular(14),
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(14),
          );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                time,
                style: const TextStyle(fontSize: 12, color: Color(0xffA7A7A7)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(message),
        ],
      ),
    );
  }
}
