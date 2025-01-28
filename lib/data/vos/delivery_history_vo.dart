import 'package:json_annotation/json_annotation.dart';
part 'delivery_history_vo.g.dart';

@JsonSerializable()
class DeliveryHistoryVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "order_id")
  final String? orderId;

  @JsonKey(name: "delivery_date")
  final String? deliveryDate;

  @JsonKey(name: "delivery_status")
  final String? deliveryStatus;

  @JsonKey(name: "comment")
  final String? comment;

  DeliveryHistoryVO({
    this.id,
    this.orderId,
    this.deliveryDate,
    this.deliveryStatus,
    this.comment,
  });

  factory DeliveryHistoryVO.fromJson(Map<String, dynamic> json) =>
      _$DeliveryHistoryVOFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryHistoryVOToJson(this);
}
