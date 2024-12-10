import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/persistence/hive_constants.dart';
import '../../data/vos/user_vo.dart';

part 'login_response.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeIdLoginResponse, adapterName: kAdapterNameLoginResponse)
class LoginResponse {
  @JsonKey(name: "status")
  @HiveField(0)
  final int? status;

  @JsonKey(name: "message")
  @HiveField(1)
  final String? message;

  @JsonKey(name: "access_token")
  @HiveField(2)
  final String? accessToken;

  @JsonKey(name: "expires_in")
  @HiveField(3)
  final dynamic expire;

  @JsonKey(name: "refresh_token")
  @HiveField(4)
  final String? refreshToken;

  @JsonKey(name: "data")
  @HiveField(5)
  final UserVO? data;

  LoginResponse(
      {this.status,
      this.message,
      this.data,
      this.accessToken,
      this.expire,
      this.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
