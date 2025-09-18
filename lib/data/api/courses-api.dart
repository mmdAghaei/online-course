import 'package:get/get_connect/connect.dart';
import 'package:podcast/main.dart';

class CoursesApi extends GetConnect {
  Future<Response> GetAllCourse() async {
    return post(
      "$ip/all_courses",
      {},
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }

  Future<Response> CourseDetails(String course_id) async {
    return post(
      "$ip/course_details",
      {"course_id": course_id},
      contentType: "application/x-www-form-urlencoded",
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }

  Future<Response> SaveCourse(String course_id) async {
    return post(
      "$ip/save_course",
      { "course_id": course_id},
      contentType: "application/x-www-form-urlencoded",
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }

  Future<Response> MyCourse() async {
    return post(
      "$ip/my_course",
      {},
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }
}
