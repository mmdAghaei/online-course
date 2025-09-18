import 'package:get/get.dart';
import 'package:podcast/data/api/courses-api.dart';
import 'package:podcast/data/models/courses-model.dart';
import 'package:podcast/main.dart';

class CourseApiController extends GetxController {
  final CoursesApi _coursesApi = Get.find<CoursesApi>();
  final statusSave = false.obs;
  RxList<CoursesModel> listSaveCourse = <CoursesModel>[].obs;
  RxList<CoursesModel> listBuyCourse = <CoursesModel>[].obs;

  RxList<CoursesModel> listCourse = <CoursesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    GetData();

    GetMyCourse();
  }

  void saveStatus(bool state) {
    statusSave.value = state;
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
      // Get.snackbar("Exception", "$e");
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
      // Get.snackbar("Exception", "$e");
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
      Get.snackbar("Exception", "$e");
      print(e);
      return false;
    }
  }
}
