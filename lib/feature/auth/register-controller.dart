import 'package:get/get.dart';

class AuthController extends GetxController {
  final isLogin = true.obs;

  void setLogin() => isLogin.value = true;
  void setRegister() => isLogin.value = false;
  void toggle() => isLogin.value = !isLogin.value;
}
