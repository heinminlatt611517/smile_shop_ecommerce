import 'package:json_annotation/json_annotation.dart';

part 'pop_up_request.g.dart';

@JsonSerializable()
class PopupRequest {
  @JsonKey(name: "user_id")
  int? userId;

  PopupRequest(this.userId);

  factory PopupRequest.fromJson(Map<String, dynamic> json) =>
      _$PopupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PopupRequestToJson(this);
}
