import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/township_vo.dart';

part 'township_data_vo.g.dart';

@JsonSerializable()
class TownshipDataVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'townships')
  final List<TownshipVO>? townships;

  TownshipDataVO({this.id, this.name,this.townships});

  factory TownshipDataVO.fromJson(Map<String, dynamic> json) =>
      _$TownshipDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$TownshipDataVOToJson(this);
}
