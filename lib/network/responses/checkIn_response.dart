import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/checkIn_vo.dart';

part 'checkIn_response.g.dart';

@JsonSerializable()
class CheckInResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final CheckInVO? checkInVO;

  CheckInResponse(
      {this.status,
        this.message,
        this.checkInVO,
      });

  factory CheckInResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInResponseToJson(this);
}
