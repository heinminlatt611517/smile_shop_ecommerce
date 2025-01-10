import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/my_team_vo.dart';

part 'my_team_response.g.dart';

@JsonSerializable()
class MyTeamResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<MyTeamVO>? data;

  MyTeamResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory MyTeamResponse.fromJson(Map<String, dynamic> json) =>
      _$MyTeamResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyTeamResponseToJson(this);
}
