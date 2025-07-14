import 'package:json_annotation/json_annotation.dart';

part 'campaign_vo.g.dart';

@JsonSerializable()
class CampaignVo {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "product_id")
  final int? productId;

  @JsonKey(name: "price")
  final int? price;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: "user_joined")
  final bool? userJoined;

  @JsonKey(name: "joined_users")
  final List<UserVo>? joinedUsers;

  @JsonKey(name: "product")
  final CampaignProductVo? product;

  CampaignVo(
      {this.id,
      this.productId,
      this.price,
      this.userJoined,
      this.joinedUsers,
      this.product,
      this.description});

  factory CampaignVo.fromJson(Map<String, dynamic> json) =>
      _$CampaignVoFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignVoToJson(this);
}

@JsonSerializable()
class UserVo {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "user_photo")
  final String? userPhoto;

  @JsonKey(name: "profile_image")
  final String? profileImage;

  UserVo({
    this.id,
    this.name,
    this.phone,
    this.userPhoto,
    this.profileImage,
  });

  factory UserVo.fromJson(Map<String, dynamic> json) => _$UserVoFromJson(json);

  Map<String, dynamic> toJson() => _$UserVoToJson(this);
}

@JsonSerializable()
class CampaignProductVo {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "image")
  final String? image;

  @JsonKey(name: "campaign_id")
  final int? campaignId;

  CampaignProductVo({
    this.id,
    this.name,
    this.image,
    this.campaignId,
  });

  factory CampaignProductVo.fromJson(Map<String, dynamic> json) =>
      _$CampaignProductVoFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignProductVoToJson(this);
}
