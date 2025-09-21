import 'dart:io' show Platform, NetworkInterface, InternetAddressType;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

class DeviceInfoController extends GetxController {
  var ip = 'در حال دریافت...'.obs;
  var appVersion = 'در حال دریافت...'.obs;
  var deviceModel = 'در حال دریافت...'.obs;
  var os = 'در حال دریافت...'.obs;

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  Future<void> loadAll() async {
    await Future.wait([
      _getAppVersion(),
      _getDeviceModelAndOs(),
      _getIpAddress(),
    ]);
  }

  Future<void> _getAppVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      appVersion.value = '${info.version}+${info.buildNumber}';
    } catch (e) {
      appVersion.value = 'خطا در نسخه: $e';
    }
  }

  Future<void> _getDeviceModelAndOs() async {
    try {
      final deviceInfo = DeviceInfoPlugin();

      if (kIsWeb) {
        final web = await deviceInfo.webBrowserInfo;
        deviceModel.value = web.browserName.toString();
        os.value = web.userAgent ?? 'نامشخص';
      } else if (Platform.isAndroid) {
        final android = await deviceInfo.androidInfo;
        deviceModel.value = '${android.manufacturer} ${android.model}';
        os.value =
            'Android ${android.version.release} (SDK ${android.version.sdkInt})';
      } else if (Platform.isIOS) {
        final ios = await deviceInfo.iosInfo;
        deviceModel.value =
            ios.utsname.machine ?? ios.name ?? 'Unknown iOS device';
        os.value = 'iOS ${ios.systemVersion}';
      } else if (Platform.isLinux) {
        final linux = await deviceInfo.linuxInfo;
        deviceModel.value = linux.name;
        os.value = linux.prettyName ?? 'Linux';
      } else if (Platform.isWindows) {
        final windows = await deviceInfo.windowsInfo;
        deviceModel.value = windows.computerName;
        os.value = 'Windows ${windows.displayVersion}';
      } else if (Platform.isMacOS) {
        final mac = await deviceInfo.macOsInfo;
        deviceModel.value = mac.model;
        os.value = 'macOS ${mac.osRelease}';
      } else {
        deviceModel.value = 'پلتفرم ناشناخته';
        os.value = 'نامشخص';
      }
    } catch (e) {
      deviceModel.value = 'خطا در مدل: $e';
      os.value = 'خطا در OS: $e';
    }
  }

  Future<void> _getIpAddress() async {
    try {
      final info = NetworkInfo();
      String? ipAddr = await info.getWifiIP();
      if (ipAddr != null && ipAddr.isNotEmpty) {
        ip.value = ipAddr;
        return;
      }

      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        includeLinkLocal: false,
      );

      String? found;
      for (final interface in interfaces) {
        for (final addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            found = addr.address;
            break;
          }
        }
        if (found != null) break;
      }

      ip.value = found ?? 'IP پیدا نشد';
    } catch (e) {
      ip.value = 'خطا در IP: $e';
    }
  }
}
