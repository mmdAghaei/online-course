import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:podcast/data/models/device-model.dart';
import 'package:podcast/feature/enter/enter-screen.dart';
import 'package:podcast/main.dart';

class DeviceListApi extends GetConnect {
  Future<Response> DeviceList() async {
    return post(
      "$ip/device_list",
      {},
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }

  Future<Response> RemoveDeviceList(String id) async {
    return post(
      "$ip/remove_active_session",
      {"id": id},
      contentType: "application/x-www-form-urlencoded",
      headers: {"Authorization": "Bearer " + box.read("userData")["token"]},
    );
  }
}

class DeviceListApiController extends GetxController {
  final RxList<DeviceModel> deviceList = <DeviceModel>[].obs;
  final DeviceListApi _deviceListApi = Get.find<DeviceListApi>();
  @override
  void onInit() {
    super.onInit();

    GetDeviceList();
  }

  Future<bool> RemoveDeviceList(String id) async {
    try {
      final response = await _deviceListApi.RemoveDeviceList(id);
      GetDeviceList();
      if (response.statusCode == 200) {
        Get.snackbar("موفق", "با موفقیت خروج گردید");
        return true;
      } else if (response.statusCode == 403) {
        Get.snackbar("خطا", "دوباره وارد شوید!");
        box.remove("userData");
        Get.to(EnterScreen());
        return false;
      } else if (response.statusCode == 403) {
        Get.snackbar("خطا", "دوباره وارد شوید!");
        box.remove("userData");
        Get.to(EnterScreen());
        return false;
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
      print(e);
      return false;
    }
  }

  Future<bool> GetDeviceList() async {
    try {
      final response = await _deviceListApi.DeviceList();
      if (response.statusCode == 200) {
        final courseJson = response.body['devices'] as List;
        deviceList.clear();

        deviceList.addAll(
          courseJson.map((e) => DeviceModel.fromJson(e)).toList(),
        );

        return true;
      } else if (response.statusCode == 403) {
        Get.snackbar("خطا", "دوباره وارد شوید!");
        box.remove("userData");
        Get.to(EnterScreen());
        return false;
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
      print(e);
      return false;
    }
  }
}
