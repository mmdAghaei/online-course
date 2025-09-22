import 'package:get/get.dart';
import 'package:podcast/data/api/course/courses-api.dart';
import 'package:podcast/data/models/course-section-model.dart';
import 'package:podcast/data/models/courses-model.dart';
import 'package:podcast/feature/course%20about/comment-controller.dart';
import 'package:podcast/feature/enter/enter-screen.dart';
import 'package:podcast/main.dart';

class CourseApiController extends GetxController {
  final CoursesApi _coursesApi = Get.find<CoursesApi>();
  final statusSave = false.obs;
  RxList<CoursesModel> listSaveCourse = <CoursesModel>[].obs;
  RxList<CoursesModel> listBuyCourse = <CoursesModel>[].obs;

  RxList<CoursesModel> listCourse = <CoursesModel>[].obs;
  RxList<CourseSectionModel> listCourseSesson = <CourseSectionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    GetData();

    GetMyCourse();
  }

  void saveStatus(bool state) {
    statusSave.value = state;
  }

  Future<CoursesModel> CourseDetails(String code) async {
    try {
      final response = await _coursesApi.CourseDetails(code);

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
      } else if (response.statusCode == 403) {
        Get.snackbar("خطا", "دوباره وارد شوید!");
        box.remove("userData");
        Get.to(EnterScreen());
        return CoursesModel.fromJson({});
      } else {
        Get.snackbar(
          "خطا",
          "اتصال اینترنت را چک کنید",
          snackPosition: SnackPosition.BOTTOM,
        );
        return CoursesModel.fromJson({});
      }
    } catch (e) {
      print(e);
      return CoursesModel.fromJson({});
    }
  }

  Future<bool> GetMyCourse() async {
    try {
      final response = await _coursesApi.MyCourse();

      if (response.statusCode == 200) {
        final courseSaveJson = response.body['save'] as List;
        final courseBuyJson = response.body['buy'] as List;

        listBuyCourse.clear();
        listSaveCourse.clear();
        listBuyCourse.addAll(
          courseBuyJson.map((e) {
            final Map<String, dynamic> courseMap = Map<String, dynamic>.from(e);

            courseMap['buy_status'] = "";
            return CoursesModel.fromJson(courseMap);
          }).toList(),
        );
        listSaveCourse.addAll(
          courseSaveJson.map((e) => CoursesModel.fromJson(e)).toList(),
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
      //
      print(e);
      return false;
    }
  }

  Future<bool> SaveCourses(String id) async {
    try {
      final response = await _coursesApi.SaveCourse(id);

      if (response.statusCode == 200) {
        Get.snackbar("پیام", response.body["message"]);
        statusSave.value = !statusSave.value;
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
      //
      print(e);
      return false;
    }
  }

  Future<bool> GetData() async {
    try {
      final response = await _coursesApi.GetAllCourse();

      if (response.statusCode == 200) {
        final courseJson = response.body['all_course'] as List;

        listCourse.clear();

        listCourse.addAll(
          courseJson.map((e) => CoursesModel.fromJson(e)).toList(),
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
      print(e);
      return false;
    }
  }
}
