class PartModel {
  final String id;
  final String title;
  final String mediaFile;
  final String partStatus;
  PartModel({
    required this.id,
    required this.title,
    required this.mediaFile,
    required this.partStatus,
  });

  factory PartModel.fromJson(Map<String, dynamic> json) {
    return PartModel(
      id: json["id"].toString(),
      title: json["title"].toString(),
      mediaFile: json["media_file"].toString(),
      partStatus: json["part_status"].toString(),
    );
  }
}
