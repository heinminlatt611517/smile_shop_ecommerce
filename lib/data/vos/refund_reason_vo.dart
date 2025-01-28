import 'package:json_annotation/json_annotation.dart';
part 'refund_reason_vo.g.dart';

@JsonSerializable()
class RefundReasonVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  RefundReasonVO({
    this.id,
    this.name
  });

  factory RefundReasonVO.fromJson(Map<String, dynamic> json) =>
      _$RefundReasonVOFromJson(json);

  Map<String, dynamic> toJson() => _$RefundReasonVOToJson(this);
}
