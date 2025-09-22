class DeviceModel {
  final String id;
  final String deviceName;
  final String os;
  final String appVersion;
  final String ipAddress;
  final String createdAt;

  DeviceModel({
    required this.id,
    required this.deviceName,
    required this.os,
    required this.appVersion,
    required this.ipAddress,
    required this.createdAt,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json["id"].toString(),
      deviceName: json["device_name"].toString(),
      os: json["os"].toString(),
      appVersion: json["app_version"].toString(),
      ipAddress: json["ip_address"].toString(),
      createdAt: json["created_at"].toString(),
    );
  }
}
