import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast/feature/course%20about/comment-controller.dart';

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
}
class CommentCard extends StatelessWidget {
  final Comment comment;
  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

            // دکمه‌های زیر هر کامنت
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
                // باز کردن bottomSheet برای ریپلای (مثال دیگری از استفادهٔ GetX)
                TextButton.icon(
                  icon: const Icon(Icons.reply),
                  label: const Text('پاسخ'),
                  onPressed: () => _openReplySheet(context, comment),
                ),
              ],
            ),

            // نمایش پاسخ‌ها
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

  void _openReplySheet(BuildContext context, Comment comment) {
    final CommentsController ctrl = Get.find();
    final TextEditingController textController = TextEditingController();
    String selectedAuthor = ctrl.allUsers.first;
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
                    child: DropdownButtonFormField<String>(
                      value: selectedAuthor,
                      decoration: const InputDecoration(labelText: 'فرستنده'),
                      items: ctrl.allUsers
                          .map(
                            (u) => DropdownMenuItem(value: u, child: Text(u)),
                          )
                          .toList(),
                      onChanged: (v) => selectedAuthor = v ?? selectedAuthor,
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
                        if (text.isEmpty) return;
                        final reply = Reply(
                          author: selectedAuthor,
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
