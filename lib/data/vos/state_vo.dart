import 'package:json_annotation/json_annotation.dart';

part 'state_vo.g.dart';

@JsonSerializable()
class StateVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  StateVO({this.id, this.name});

  factory StateVO.fromJson(Map<String, dynamic> json) =>
      _$StateVOFromJson(json);

  Map<String, dynamic> toJson() => _$StateVOToJson(this);
}