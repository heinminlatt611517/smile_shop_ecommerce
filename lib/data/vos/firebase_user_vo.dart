import 'package:json_annotation/json_annotation.dart';

part 'firebase_user_vo.g.dart';

@JsonSerializable()
class FirebaseUserVo {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'role')
  String? role;
  FirebaseUserVo({
    this.id,
    this.name,
    this.phone,
    this.role,
  });

  factory FirebaseUserVo.fromJson(Map<String, dynamic> json) => _$FirebaseUserVoFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseUserVoToJson(this);
}
