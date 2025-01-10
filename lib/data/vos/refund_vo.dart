import 'package:json_annotation/json_annotation.dart';
part 'refund_vo.g.dart';

@JsonSerializable()
class RefundVO {
  @JsonKey(name: "image")
  final String? image;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "total")
  final int? total;

  @JsonKey(name: "status")
  final String? status;

  @JsonKey(name: "qty")
  final int? qty;

  RefundVO({
    this.image,
    this.name,
    this.total,
    this.status,
    this.qty
  });

  factory RefundVO.fromJson(Map<String, dynamic> json) =>
      _$RefundVOFromJson(json);

  Map<String, dynamic> toJson() => _$RefundVOToJson(this);
}
