import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required int id, required String email, required String username})
      : super(id: id, email: email, username: username);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
    };
  }
}
