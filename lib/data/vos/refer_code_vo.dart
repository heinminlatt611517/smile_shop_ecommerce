import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'refer_code_vo.g.dart';

@HiveType(typeId: kHiveReferVO, adapterName: kAdapterReferVO)
@JsonSerializable()
class ReferCodeVO {
  @JsonKey(name: "id")
  @HiveField(0)
  final int? id;

  @JsonKey(name: "code")
  @HiveField(1)
  final String? code;

  @JsonKey(name: "user_id")
  @HiveField(2)
  final int? userId;

  ReferCodeVO({
    this.id,
    this.code,
    this.userId
  });

  factory ReferCodeVO.fromJson(Map<String, dynamic> json) =>
      _$ReferCodeVOFromJson(json);

  Map<String, dynamic> toJson() => _$ReferCodeVOToJson(this);
}
