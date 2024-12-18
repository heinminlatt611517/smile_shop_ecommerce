import 'package:json_annotation/json_annotation.dart';
import '../../data/vos/township_data_vo.dart';

part 'township_response.g.dart';

@JsonSerializable()
class TownshipResponse {
  @JsonKey(name: "status")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final TownshipDataVO? townshipDataVO;

  TownshipResponse(
      {this.status,
      this.message,
      this.townshipDataVO,
      });

  factory TownshipResponse.fromJson(Map<String, dynamic> json) =>
      _$TownshipResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TownshipResponseToJson(this);
}
