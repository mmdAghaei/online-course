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
    return post("$ip/sign_up", {
      "first_name": firstName.toLowerCase(),
      "last_name": lastName.toLowerCase(),
      "password": password,
      "phone": phone.toLowerCase(),
    }, contentType: "application/x-www-form-urlencoded");
  }

  Future<Response> login({
    required String phone,
    required String password,
    required String device_name,
    required String os,
    required String app_version,
    required String ip_address,
  }) {
    print("-----------------------------------------------------------");
    print(ip_address);
    print("-----------------------------------------------------------");
    return post("$ip/user_login", {
      "phone": phone,
      "password": password,
      "device_name": device_name,
      "os": os,
      "app_version": app_version,
      "ip": ip_address,
    }, contentType: "application/x-www-form-urlencoded");
  }

  Future<Response> verifyEmail({
    required String code,
    required String username,
    required String device_name,
    required String os,
    required String app_version,
    required String ip_address,
  }) {
    return post("$ip/verify_email", {
      "code": code.toLowerCase(),
      "phone": username.toLowerCase(),
      "device_name": device_name,
      "os": os,
      "app_version": app_version,
      "ip_address": ip_address,
    }, contentType: "application/x-www-form-urlencoded");
  }
}
