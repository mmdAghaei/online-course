import 'package:get/get_connect/connect.dart';
import 'package:podcast/main.dart';

class CoursesApi extends GetConnect {
  Future<Response> GetAllCourse(String phone) async {
    return post(
      "http://$ip:8000/all_courses",
      {"phone": phone},
      contentType: "application/x-www-form-urlencoded",
    );
  }

  Future<Response> GetDetailsCourse(String phone, String course_id) async {
    return post(
      "http://$ip:8000/course_details",
      {"phone": phone, "course_id": course_id},
      contentType: "application/x-www-form-urlencoded",
    );
  }
}
