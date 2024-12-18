import 'package:json_annotation/json_annotation.dart';

part 'township_vo.g.dart';

@JsonSerializable()
class TownshipVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'state_id')
  final int? stateId;

  @JsonKey(name: 'name')
  final String? name;

  TownshipVO({this.id, this.stateId, this.name});

  factory TownshipVO.fromJson(Map<String, dynamic> json) =>
      _$TownshipVOFromJson(json);

  Map<String, dynamic> toJson() => _$TownshipVOToJson(this);
}
