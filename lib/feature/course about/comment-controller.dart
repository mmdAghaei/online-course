import 'package:get/get.dart';
import 'package:podcast/feature/course%20about/comment-widget.dart';

class CommentsController extends GetxController {
  final RxList<Comment> comments = <Comment>[].obs;

  final List<String> allUsers = ['علی', 'مینا', 'ادمین', 'سارا', 'رضا'];

  @override
  void onInit() {
    super.onInit();
    comments.addAll([
      Comment(
        id: 'c1',
        author: 'علی',
        timeString: '2 روز پیش',
        message: 'آقا ما 70 درصد برنامه رو زدیم پولمون چی شد؟',
        replies: [
          Reply(
            author: 'ادمین',
            replyTo: 'علی',
            message: 'سلام، بررسی می‌کنم.',
          ),
        ],
      ),
      Comment(
        id: 'c2',
        author: 'مینا',
        timeString: '1 روز پیش',
        message: 'لطفا آپدیت بزنید.',
      ),
    ]);
  }

  void toggleExpand(Comment c) => c.expanded.value = !c.expanded.value;

  void addReply(String commentId, Reply reply) {
    final c = comments.firstWhere((c) => c.id == commentId);
    c.replies.add(reply);
    c.expanded.value = true; // بعد از ارسال باز شود
  }

  void addComment(Comment comment) => comments.insert(0, comment);
}
