import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/notification_vo.dart';

part 'notification_list_response.g.dart';

@JsonSerializable()
class NotificationListResponse {
  @JsonKey(name: "status_code")
  final int? statusCode;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<NotificationVO>? data;

  NotificationListResponse({this.statusCode, this.message, this.data});

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) => _$NotificationListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationListResponseToJson(this);
}
