import 'package:json_annotation/json_annotation.dart';
part 'login_vo.g.dart';

@JsonSerializable()
class LoginVO {
  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "code")
  final String? code;

  LoginVO({
     this.phone,
     this.code,
  });

  factory LoginVO.fromJson(Map<String, dynamic> json) =>
      _$LoginVOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginVOToJson(this);
}
