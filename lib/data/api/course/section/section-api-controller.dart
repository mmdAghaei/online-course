import 'package:get/get.dart';
import 'package:podcast/data/api/course/section/section-api.dart';
import 'package:podcast/data/models/course-section-model.dart';
import 'package:podcast/data/models/part-model.dart';
import 'package:podcast/feature/enter/enter-screen.dart';
import 'package:podcast/main.dart';

class SectionApiController extends GetxController {
  final SectionApi _sectionApi = Get.find<SectionApi>();

  final RxList<PartModel> partList = <PartModel>[].obs;
  Future<CourseSectionModel> SectionDetails(
    String section_id,
    String course_id,
  ) async {
    try {
      final response = await _sectionApi.SectionDetails(section_id, course_id);

      if (response.statusCode == 200) {
        print(response.body);
        print("--------------------------------------");

        final courseJson = response.body as Map<String, dynamic>;
        final courseSecconJson =
            (response.body["parts"] as List?) ?? <dynamic>[];

        CourseSectionModel c = CourseSectionModel.fromJson(courseJson);
        partList.clear();
        partList.addAll(
          courseSecconJson.map((e) => PartModel.fromJson(e)).toList(),
        );

        return c;
      } else if (response.statusCode == 403) {
        Get.snackbar("خطا", "دوباره وارد شوید!");
        box.remove("userData");
        Get.to(EnterScreen());
        return CourseSectionModel.fromJson({});
      } else {
        Get.snackbar(
          "خطا",
          "اتصال اینترنت را چک کنید",
          snackPosition: SnackPosition.BOTTOM,
        );
        return CourseSectionModel.fromJson({});
      }
    } catch (e) {
      print(e);
      return CourseSectionModel.fromJson({});
    }
  }
}
