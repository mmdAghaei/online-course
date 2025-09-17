class UserModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String userType;
  final String createdAt;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.userType,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json["first_name"].toString(),
      lastName: json["last_name"].toString(),
      phone: json["phone"].toString(),
      userType: json["user_type"].toString(),
      createdAt: json["created_at"].toString(),
    );
  }
}
