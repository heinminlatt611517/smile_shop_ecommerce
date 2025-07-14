import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/popup_data_vo.dart';

part 'home_popup_data_response.g.dart';

@JsonSerializable()
class HomePopupDataResponse {
  @JsonKey(name: "status")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final PopupDataVO? data;

  HomePopupDataResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory HomePopupDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomePopupDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomePopupDataResponseToJson(this);
}
