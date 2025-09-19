import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:podcast/data/api/panel/panel-admin-api.dart';
import 'package:podcast/data/models/courses-model.dart';
import 'package:podcast/data/models/user-model.dart';
import 'package:podcast/main.dart';

class PanelAdminController extends GetxController {
  RxList<UserModel> userList = <UserModel>[].obs;

  final PanelAdminApi _panelAdminApi = Get.find<PanelAdminApi>();
  @override
  void onInit() {
    super.onInit();

    GetUser();
  }

  RxList<CoursesModel> listCourse = <CoursesModel>[].obs;

  Future<bool> GetData() async {
    try {
      final response = await _panelAdminApi.AllCourseAdmin();
      print(response.body);
      print("------------------");
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
        print(response.body);
        return false;
      }
    } catch (e) {
      Get.snackbar("Exception", "$e");
      print(e);
      return false;
    }
  }

  Future<bool> GetUser() async {
    try {
      final response = await _panelAdminApi.GetUsers();

      if (response.statusCode == 200) {
        final usersJson = response.body['users'] as List;
        print(usersJson);
        print("--------------------------------------");
        userList.clear();
        userList.addAll(usersJson.map((e) => UserModel.fromJson(e)));
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

  Future<bool> RemoveUsers(String phone) async {
    try {
      final response = await _panelAdminApi.DeleteUser(phone);

      if (response.statusCode == 200) {
        GetUser();
        Get.snackbar("موفق", "کاربر با موفقیت حذف شد");
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

  Future<bool> ChangeUsers(String phone) async {
    try {
      final response = await _panelAdminApi.ChangeUser(phone);

      if (response.statusCode == 200) {
        GetUser();
        Get.snackbar("موفق", "کاربر با موفقیت عوض شد");
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

  final title = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final discount = TextEditingController();
  final Dio dio = Dio();
  Rx<String?> selectedImagePath = Rx<String?>(null);

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

  Future<Response> createCourse(bool published) async {
    try {
      FormData formData = FormData.fromMap({
        "title": title.text,
        "description": description.text,
        "price": price.text,
        "discount": discount.text,
        "published": published == "true" ? "False" : "True",
        if (selectedImagePath.value != null)
          "media_file": await MultipartFile.fromFile(
            selectedImagePath.value!,
            filename: selectedImagePath.value!.split("/").last,
          ),
      });

      Response response = await dio.post("$ip/create_course", data: formData);
      print(response);
      print("---------------------");
      return response;
    } catch (e) {
      throw Exception("خطا در ایجاد دوره: $e");
    }
  }
}
