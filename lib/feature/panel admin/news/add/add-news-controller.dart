import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddNewsController extends GetxController {
  final Dio dio = Dio();
  final title = TextEditingController();
  final description = TextEditingController();
  Rx<String?> selectedImagePath = Rx<String?>(null);

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }
}
