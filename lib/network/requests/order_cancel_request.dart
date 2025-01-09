import 'package:json_annotation/json_annotation.dart';

part 'order_cancel_request.g.dart';

@JsonSerializable()
class OrderCancelRequest {
  @JsonKey(name: "order_no")
  String? orderNo;

  OrderCancelRequest(this.orderNo);

  factory OrderCancelRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderCancelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCancelRequestToJson(this);
}
