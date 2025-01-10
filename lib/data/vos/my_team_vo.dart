import 'package:json_annotation/json_annotation.dart';

part 'my_team_vo.g.dart';

@JsonSerializable()
class MyTeamVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "user_photo")
  final String? userPhoto;

  @JsonKey(name: "profile_image")
  final String? profileImage;

  MyTeamVO({
    this.id,
    this.name,
    this.phone,
    this.userPhoto,
    this.profileImage,
  });

  factory MyTeamVO.fromJson(Map<String, dynamic> json) =>
      _$MyTeamVOFromJson(json);

  Map<String, dynamic> toJson() => _$MyTeamVOToJson(this);
}
