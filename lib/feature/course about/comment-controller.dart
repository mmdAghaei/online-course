// comment-controller.dart
import 'package:get/get.dart';
import 'package:podcast/main.dart';
import 'comment-widget.dart'; // مسیر فایل Comment و Reply

class CommentsController extends GetxController {
  final RxList<Comment> comments = <Comment>[].obs;


  @override
  void onInit() {
    super.onInit();
  }

  void toggleExpand(Comment c) => c.expanded.value = !c.expanded.value;

  void addReply(String commentId, Reply reply) {
    final c = comments.firstWhere(
      (c) => c.id == commentId,
      orElse: () => throw Exception('comment not found'),
    );
    c.replies.add(reply);
    c.expanded.value = true;
  }

  void addComment(Comment comment) => comments.insert(0, comment);

  void setCommentsFromJson(List<dynamic> rawComments) {
    comments.clear();
    final parsed = <Comment>[];
    for (var c in rawComments) {
      if (c is Map<String, dynamic>) {
        parsed.add(Comment.fromJson(c));
      } else if (c is Map) {
        parsed.add(Comment.fromJson(Map<String, dynamic>.from(c)));
      }
    }
    comments.addAll(parsed);
  }
}
