import 'package:json_annotation/json_annotation.dart';
part 'login_vo.g.dart';

@JsonSerializable()
class LoginVO {
  @JsonKey(name: "token")
  final String? token;

  @JsonKey(name: "name")
  final String? name;

  LoginVO({
     this.token,
     this.name,
  });

  factory LoginVO.fromJson(Map<String, dynamic> json) =>
      _$LoginVOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginVOToJson(this);
}
