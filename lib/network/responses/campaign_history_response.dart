import 'package:json_annotation/json_annotation.dart';

part 'campaign_history_response.g.dart';

@JsonSerializable()
class CampaignHistoryResponse {
  @JsonKey(name: "status_code")
  final int? statusCode;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<CampaignDataVO>? data;

  CampaignHistoryResponse({this.statusCode, this.message, this.data});

  factory CampaignHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CampaignHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignHistoryResponseToJson(this);
}

@JsonSerializable()
class CampaignDataVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "enduser_id")
  final int? enduserId;

  @JsonKey(name: "order_no")
  final String? orderNo;

  @JsonKey(name: "subtotal")
  final String? subtotal;

  @JsonKey(name: "payment_type")
  final String? paymentType;

  @JsonKey(name: "payment_status")
  final String? paymentStatus;

  @JsonKey(name: "user_type")
  final String? userType;

  @JsonKey(name: "enduser_address_id")
  final int? enduserAddressId;

  @JsonKey(name: "delivery_status")
  final String? deliveryStatus;

  @JsonKey(name: "is_campaign")
  final int? isCampaign;

  @JsonKey(name: "campaign_product")
  final CampaignProductVO? campaignProduct;

  @JsonKey(name: "address")
  final AddressVO? address;

  CampaignDataVO({
    this.id,
    this.enduserId,
    this.orderNo,
    this.subtotal,
    this.paymentType,
    this.paymentStatus,
    this.userType,
    this.enduserAddressId,
    this.deliveryStatus,
    this.isCampaign,
    this.campaignProduct,
    this.address,
  });

  factory CampaignDataVO.fromJson(Map<String, dynamic> json) =>
      _$CampaignDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignDataVOToJson(this);
}

@JsonSerializable()
class CampaignProductVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "product_id")
  final int? productId;

  @JsonKey(name: "price")
  final String? price;

  @JsonKey(name: "product")
  final CampaignSubProductVO? product;

  CampaignProductVO({this.id, this.productId, this.price, this.product});

  factory CampaignProductVO.fromJson(Map<String, dynamic> json) =>
      _$CampaignProductVOFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignProductVOToJson(this);
}

@JsonSerializable()
class CampaignSubProductVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "show")
  final int? show;

  @JsonKey(name: "created_at")
  final String? createdAt;

  @JsonKey(name: "updated_at")
  final String? updatedAt;

  @JsonKey(name: "image")
  final String? image;

  @JsonKey(name: "campaign_id")
  final String? campaignId;

  CampaignSubProductVO({
    this.id,
    this.name,
    this.show,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.campaignId,
  });

  factory CampaignSubProductVO.fromJson(Map<String, dynamic> json) =>
      _$ProductVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVOToJson(this);
}

@JsonSerializable()
class AddressVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "enduser_id")
  final int? enduserId;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "address")
  final String? address;

  @JsonKey(name: "category_id")
  final int? categoryId;

  @JsonKey(name: "township_id")
  final int? townshipId;

  AddressVO({
    this.id,
    this.enduserId,
    this.name,
    this.phone,
    this.address,
    this.categoryId,
    this.townshipId,
  });

  factory AddressVO.fromJson(Map<String, dynamic> json) =>
      _$AddressVOFromJson(json);

  Map<String, dynamic> toJson() => _$AddressVOToJson(this);
}
