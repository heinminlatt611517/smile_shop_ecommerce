import 'package:json_annotation/json_annotation.dart';

part 'checkIn_request.g.dart';

@JsonSerializable()
class CheckInRequest {
  @JsonKey(name: "day")
  int? day;

  CheckInRequest(this.day);

  factory CheckInRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInRequestToJson(this);
}
