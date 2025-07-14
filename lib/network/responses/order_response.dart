import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/order_vo.dart';

part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<OrderVO>? data;

  OrderResponse(
      {this.status,
        this.message,
        this.data,
      });

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
