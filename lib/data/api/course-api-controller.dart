import 'package:get/get.dart';
import 'package:podcast/data/api/courses-api.dart';
import 'package:podcast/data/models/courses-model.dart';
import 'package:podcast/main.dart';

class CourseApiController extends GetxController {
  final CoursesApi _coursesApi = Get.find<CoursesApi>();

  RxList<CoursesModel> listCourse = <CoursesModel>[
    CoursesModel(
      id: '1',
      title: 'آموزش مقدماتی فلاتر',
      description: 'یادگیری مبانی فلاتر از صفر.',
      buyStatus: 'رایگان',
      price: '100,000',
      finalPrice: '0',
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    GetData();
  }

  Future<bool> GetData() async {
    try {
      final response = await _coursesApi.GetAllCourse(
        box.read("userData")["phone"],
      );

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
