import 'package:get/get.dart';
import 'package:podcast/data/api/course/section/section-api.dart';
import 'package:podcast/data/models/course-section-model.dart';
import 'package:podcast/data/models/part-model.dart';

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
      } else {
        Get.snackbar(
          "خطا",
          "اتصال اینترنت را چک کنید",
          snackPosition: SnackPosition.BOTTOM,
        );
        return CourseSectionModel.fromJson({});
      }
    } catch (e) {
      Get.snackbar("Exception", "$e");
      print(e);
      return CourseSectionModel.fromJson({});
    }
  }
}
