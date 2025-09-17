import 'dart:convert';

import 'package:get/get.dart';
import 'package:podcast/data/api/courses-api.dart';
import 'package:podcast/data/api/home-api.dart';
import 'package:podcast/data/models/course-section-model.dart';
import 'package:podcast/data/models/courses-model.dart';
import 'package:podcast/data/models/news-model.dart';
import 'package:podcast/feature/course%20about/comment-controller.dart';
import 'package:podcast/feature/enter/enter-screen.dart';
import 'package:podcast/main.dart';

class HomeApiController extends GetxController {
  final HomeApi _homeApi = Get.find<HomeApi>();
  final CoursesApi _courseApi = Get.find<CoursesApi>();

  RxList<NewsModel> listNews = <NewsModel>[].obs;
  RxList<CoursesModel> listCourse = <CoursesModel>[].obs;
  RxList<CourseSectionModel> listCourseSesson = <CourseSectionModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    GetData();
  }

  Future<CoursesModel> CourseDetails(String code) async {
    try {
      final response = await _courseApi.CourseDetails(code);

      if (response.statusCode == 200) {
        final courseJson = response.body as Map<String, dynamic>;
        final courseSecconJson =
            (response.body["sections"] as List?) ?? <dynamic>[];
        final commentJson = (response.body["comments"] as List?) ?? <dynamic>[];

        CoursesModel c = CoursesModel.fromJson(courseJson);
        listCourseSesson.clear();
        listCourseSesson.addAll(
          courseSecconJson.map((e) => CourseSectionModel.fromJson(e)).toList(),
        );

        final CommentsController commentsCtrl = Get.put(CommentsController());

        commentsCtrl.setCommentsFromJson(commentJson);

        return c;
      } else {
        Get.snackbar(
          "خطا",
          "اتصال اینترنت را چک کنید",
          snackPosition: SnackPosition.BOTTOM,
        );
        return CoursesModel.fromJson({});
      }
    } catch (e) {
      Get.snackbar("Exception", "$e");
      print(e);
      return CoursesModel.fromJson({});
    }
  }

  Future<bool> GetData() async {
    try {
      final response = await _homeApi.GetCourseAndNews();
      print(response.body);
      print("----------------");
      if (response.statusCode == 404) {
        Get.snackbar("", "کاربر یافت نشد لطفا دوباره وارد شوید");
        box.remove("userData");
        Get.to(EnterScreen());
        return false;
      } else if (response.statusCode == 200) {
        final newsJson = response.body['announcements'] as List;
        final courseJson = response.body['courses'] as List;
        final userType = response.body["user_type"];
        if (userType.toString() == "admin") {
          Map<String, dynamic> myMap = box.read('userData');
          myMap["user_type"] = "admin";
          box.write("userData", myMap);
        } else {
          Map<String, dynamic> myMap = box.read('userData');
          myMap["user_type"] = "user";
          box.write("userData", myMap);
        }
        listNews.clear();
        listCourse.clear();

        listNews.addAll(newsJson.map((e) => NewsModel.fromJson(e)).toList());
        listCourse.addAll(
          courseJson.map((e) => CoursesModel.fromJson(e)).toList(),
        );
        box.write("listCourse", listCourse);
        box.write("listNews", listNews);

        return true;
      } else {
        Get.snackbar(
          "خطا",
          "اتصال اینترنت را چک کنید",
          snackPosition: SnackPosition.BOTTOM,
        );
        print(response.body);
        return false;
      }
    } catch (e) {
      Get.snackbar("Exception", "$e");
      print(e);
      return false;
    }
  }
}
