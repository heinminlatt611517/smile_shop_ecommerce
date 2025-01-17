import 'package:json_annotation/json_annotation.dart';
part 'popup_data_vo.g.dart';

@JsonSerializable()
class PopupDataVO {
  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "message")
  final String? message;

  PopupDataVO({
   this.title,
    this.message
  });

  factory PopupDataVO.fromJson(Map<String, dynamic> json) =>
      _$PopupDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$PopupDataVOToJson(this);
}
