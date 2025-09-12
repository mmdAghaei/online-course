import 'package:get/get.dart';
import 'package:podcast/data/models/courses-model.dart';

class MyCourseController extends GetxController {
  final isBuy = true.obs;

  RxList<CoursesModel> buyCourses = <CoursesModel>[].obs;
  RxList<CoursesModel> saveCourses = <CoursesModel>[].obs;

  void setLogin() => isBuy.value = true;
  void setRegister() => isBuy.value = false;
  void toggle() => isBuy.value = !isBuy.value;
}
