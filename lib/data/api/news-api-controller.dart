import 'package:get/get.dart';
import 'package:podcast/data/api/news-api.dart';
import 'package:podcast/data/models/news-model.dart';

class NewsApiController extends GetxController {
  RxList<NewsModel> newsList = <NewsModel>[].obs;

  final NewsApi _newsApi = Get.find<NewsApi>();
  @override
  void onInit() {
    super.onInit();
    GetData();
  }

  Future<bool> GetData() async {
    try {
      final response = await _newsApi.GetAllNews();

      if (response.statusCode == 200) {
        final newsJson = response.body['news'] as List;

        newsList.clear();

        newsList.addAll(
          newsJson
              .map((e) => NewsModel.fromJson(Map<String, dynamic>.from(e)))
              .toList(),
        );

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
      Get.snackbar("Exception", "$e");
      print(e);
      return false;
    }
  }
}
