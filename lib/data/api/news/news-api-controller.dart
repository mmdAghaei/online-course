import 'package:get/get.dart';
import 'package:podcast/data/api/news/news-api.dart';
import 'package:podcast/data/models/news-model.dart';
import 'package:podcast/feature/enter/enter-screen.dart';
import 'package:podcast/main.dart';

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
        print(newsJson);
        newsList.clear();

        newsList.addAll(newsJson.map((e) => NewsModel.fromJson(e)).toList());

        return true;
      }  else if (response.statusCode == 403) {
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
