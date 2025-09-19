import 'package:podcast/data/models/course-section-model.dart';

class CoursesModel {
  final String id;
  final String title;
  final String description;
  final String buyStatus;
  final String price;
  final String finalPrice;
  final String? image;
  final String? sectionCount;
  final String? seen;
  final String? disCount;
  final String? save;
  final List<CourseSectionModel>? sections;

  CoursesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.buyStatus,
    required this.price,
    required this.finalPrice,
    this.image,
    this.sectionCount,
    this.seen,
    this.disCount,
    this.sections,
    this.save,
  });

  factory CoursesModel.fromJson(Map<String, dynamic> json) {
    String buyStatusText;
    if (json['buy_status'] == "not_buy") {
      buyStatusText = "خریداری نشده";
    } else if (json['buy_status'] == "buy") {
      buyStatusText = "خریداری شده";
    } else if (json["buy_status"] == "free") {
      buyStatusText = "رایگان";
    } else {
      buyStatusText = json["buy_status"].toString();
    }

    return CoursesModel(
      save: json["save"].toString(),
      id: json['id'].toString(),
      disCount: json['discount']?.toString(),
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      image: json['media_url'],
      buyStatus: buyStatusText,
      finalPrice: json['final_price']?.toString() ?? "0",
      price: json['price']?.toString() ?? "0",
      sectionCount: json['section_count']?.toString(),
      seen: json['seen']?.toString(),
      sections: json['sections'] != null
          ? (json['sections'] as List)
                .map((e) => CourseSectionModel.fromJson(e))
                .toList()
          : null,
    );
  }
}
