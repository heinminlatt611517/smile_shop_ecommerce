import 'package:json_annotation/json_annotation.dart';
part 'checkIn_vo.g.dart';

@JsonSerializable()
class CheckInVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "user_id")
  final int? userId;

  @JsonKey(name: "user_type")
  final String? userType;

  @JsonKey(name: "current_check_in_day")
  final int? currentCheckInDay;

  @JsonKey(name: "total_check_in_point")
  final int? totalCheckInPoint;

  CheckInVO({
    this.id,
    this.userId,
    this.userType,
    this.currentCheckInDay,
    this.totalCheckInPoint
  });


  factory CheckInVO.fromJson(Map<String, dynamic> json) =>
      _$CheckInVOFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInVOToJson(this);
}
