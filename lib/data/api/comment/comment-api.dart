import 'package:get/get_connect/connect.dart';
import 'package:podcast/main.dart';

class CommentApi extends GetConnect {
  Future<Response> CreateComment(String CourseId, String Comment) async {
    return post(
      "$ip/create_comments",
      {"course_id": CourseId, "content": Comment},
      contentType: "application/x-www-form-urlencoded",
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }

  Future<Response> CreateReply(
    String CourseId,
    String Comment,
    String Commentid,
  ) async {
    return post(
      "$ip/create_replay",
      {"course_id": CourseId, "comment_id": Commentid, "content": Comment},
      contentType: "application/x-www-form-urlencoded",
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }
}
