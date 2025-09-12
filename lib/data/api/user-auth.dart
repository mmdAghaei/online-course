import 'package:get/get_connect/connect.dart';
import 'package:get/get.dart';
import 'package:podcast/main.dart';

class UserAuthApi extends GetConnect {
  Future<Response> signUp({
    required String firstName,
    required String lastName,
    required String password,
    required String phone,
  }) {
    return post("http://$ip:8000/sign_up", {
      "first_name": firstName.toLowerCase(),
      "last_name": lastName.toLowerCase(),
      "password": password,
      "phone": phone.toLowerCase(),
    }, contentType: "application/x-www-form-urlencoded");
  }

  Future<Response> login({required String phone, required String password}) {
    return post(
      "http://$ip:8000/user_login",
      {"phone": phone, "password": password},
      contentType: "application/x-www-form-urlencoded",
    );
  }

  Future<Response> verifyEmail({
    required String code,
    required String username,
  }) {
    return post(
      "http://$ip:8000/verify_email",
      {"code": code.toLowerCase(), "phone": username.toLowerCase()},
      contentType: "application/x-www-form-urlencoded",
    );
  }
}
