import '../../domain/entities/token.dart';

class TokenModel extends Token {
  TokenModel({required String token}) : super(token);

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(token: json['token']);
  }

  Map<String, dynamic> toJson() => {'token': token};
}
