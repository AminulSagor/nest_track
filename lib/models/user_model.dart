// models/user_model.dart
class UserModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String profileImage;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['pro_path'] ?? '', // <- Fallback for null
    );
  }

}
