import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/login_vo.dart';


part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "success")
  final bool success;

  @JsonKey(name: "data")
  final LoginVO? data;

  @JsonKey(name: "message")
  final String message;

  LoginResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
