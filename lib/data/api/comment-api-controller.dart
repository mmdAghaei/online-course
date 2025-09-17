import 'package:get/get.dart';
import 'package:podcast/data/api/comment-api.dart';

class CommentApiController extends GetxController {
  final CommentApi _commentApi = Get.find<CommentApi>();

  Future<bool> CreateComment(String CourseId, String Comment) async {
    try {
      final response = await _commentApi.CreateComment(CourseId, Comment);

      if (response.statusCode == 200) {
        Get.snackbar("پیام", response.body["message"]);
        
        return true;
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
