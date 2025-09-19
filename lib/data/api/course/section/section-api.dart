import 'package:get/get.dart';
import 'package:podcast/main.dart';

class SectionApi extends GetConnect {
  Future<Response> SectionDetails(String section_id, String course_id) async {
    return post(
      "$ip/section_details",
      {"section_id": section_id, "course_id": course_id},
      contentType: "application/x-www-form-urlencoded",
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }
}
