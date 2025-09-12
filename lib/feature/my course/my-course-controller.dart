import 'package:get/get.dart';

class MyCourseController extends GetxController {
  final isLogin = true.obs;

  void setLogin() => isLogin.value = true;
  void setRegister() => isLogin.value = false;
  void toggle() => isLogin.value = !isLogin.value;
}
