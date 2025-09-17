class NewsModel {
  String id;
  String title;
  String content;
  String? image;
  String created_at;

  NewsModel({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    required this.created_at,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'].toString(),
      title: json['title'].toString(),
      content: json['content'].toString(),
      image: json['image'].toString(),
      created_at: json['created_at'].toString(),
    );
  }
}
