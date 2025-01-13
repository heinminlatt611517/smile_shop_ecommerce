import 'package:json_annotation/json_annotation.dart';

part 'order_status_request.g.dart';

@JsonSerializable()
class OrderStatusRequest {
  @JsonKey(name: "order_no")
  String? orderNo;

  OrderStatusRequest(this.orderNo);

  factory OrderStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusRequestToJson(this);
}
