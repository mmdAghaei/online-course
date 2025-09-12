import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditCourseController extends GetxController {
  final isLogin = true.obs;

  void setLogin() => isLogin.value = true;
  void setRegister() => isLogin.value = false;
  void toggle() => isLogin.value = !isLogin.value;
}

class ImageController extends GetxController {
  Rx<String?> selectedImagePath = Rx<String?>(null);

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }
}