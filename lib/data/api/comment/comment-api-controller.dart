import 'package:get/get.dart';
import 'package:podcast/data/api/comment/comment-api.dart';
import 'package:podcast/feature/enter/enter-screen.dart';
import 'package:podcast/main.dart';

class CommentApiController extends GetxController {
  final CommentApi _commentApi = Get.find<CommentApi>();

  Future<bool> CreateComment(String CourseId, String Comment) async {
    try {
      final response = await _commentApi.CreateComment(CourseId, Comment);

      if (response.statusCode == 200) {
        Get.snackbar("پیام", response.body["message"]);

        return true;
      } else if (response.statusCode == 403) {
        Get.snackbar("خطا", "دوباره وارد شوید!");
        box.remove("userData");
        Get.to(EnterScreen());
        return false;
      } else {
        Get.snackbar(
          "خطا",
          "اتصال اینترنت را چک کنید",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> CreateReply(
    String CourseId,
    String Comment,
    String Commentid,
  ) async {
    try {
      final response = await _commentApi.CreateReply(
        CourseId,
        Comment,
        Commentid,
      );

      if (response.statusCode == 200) {
        Get.snackbar("پیام", response.body["message"]);

        return true;
      } else if (response.statusCode == 403) {
        Get.snackbar("خطا", "دوباره وارد شوید!");
        box.remove("userData");
        Get.to(EnterScreen());
        return false;
      } else {
        Get.snackbar(
          "خطا",
          "اتصال اینترنت را چک کنید",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
