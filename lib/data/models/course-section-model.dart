import 'package:podcast/data/models/part-model.dart';

class CourseSectionModel {
  final String id;
  final String title;
  final String state;
  final String price;
  final String? partCount;
  final List<PartModel>? parts;
  CourseSectionModel({
    required this.id,
    required this.title,
    required this.state,
    required this.price,
    this.partCount,
    this.parts,
  });

  factory CourseSectionModel.fromJson(Map<String, dynamic> json) {
    return CourseSectionModel(
      id: json["id"].toString(),
      title: json["title"].toString(),
      state: json["price"].toString(),
      price: json["section_buy_status"].toString(),
      partCount: json["part_count"].toString(),
      parts:  json['parts'] != null
          ? (json['parts'] as List)
                .map((e) => PartModel.fromJson(e))
                .toList()
          : null
    );
  }
}
