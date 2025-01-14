// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignHistoryResponse _$CampaignHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    CampaignHistoryResponse(
      statusCode: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CampaignDataVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CampaignHistoryResponseToJson(
        CampaignHistoryResponse instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

CampaignDataVO _$CampaignDataVOFromJson(Map<String, dynamic> json) =>
    CampaignDataVO(
      id: (json['id'] as num?)?.toInt(),
      enduserId: (json['enduser_id'] as num?)?.toInt(),
      orderNo: json['order_no'] as String?,
      subtotal: json['subtotal'] as String?,
      paymentType: json['payment_type'] as String?,
      paymentStatus: json['payment_status'] as String?,
      userType: json['user_type'] as String?,
      enduserAddressId: (json['enduser_address_id'] as num?)?.toInt(),
      deliveryStatus: json['delivery_status'] as String?,
      isCampaign: (json['is_campaign'] as num?)?.toInt(),
      campaignProduct: json['campaign_product'] == null
          ? null
          : CampaignProductVO.fromJson(
              json['campaign_product'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : AddressVO.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CampaignDataVOToJson(CampaignDataVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enduser_id': instance.enduserId,
      'order_no': instance.orderNo,
      'subtotal': instance.subtotal,
      'payment_type': instance.paymentType,
      'payment_status': instance.paymentStatus,
      'user_type': instance.userType,
      'enduser_address_id': instance.enduserAddressId,
      'delivery_status': instance.deliveryStatus,
      'is_campaign': instance.isCampaign,
      'campaign_product': instance.campaignProduct,
      'address': instance.address,
    };

CampaignProductVO _$CampaignProductVOFromJson(Map<String, dynamic> json) =>
    CampaignProductVO(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      price: json['price'] as String?,
      product: json['product'] == null
          ? null
          : CampaignSubProductVO.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CampaignProductVOToJson(CampaignProductVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'price': instance.price,
      'product': instance.product,
    };

CampaignSubProductVO _$ProductVOFromJson(Map<String, dynamic> json) => CampaignSubProductVO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      show: (json['show'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      image: json['image'] as String?,
      campaignId: json['campaign_id'] as String?,
    );

Map<String, dynamic> _$ProductVOToJson(CampaignSubProductVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'show': instance.show,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'image': instance.image,
      'campaign_id': instance.campaignId,
    };

AddressVO _$AddressVOFromJson(Map<String, dynamic> json) => AddressVO(
      id: (json['id'] as num?)?.toInt(),
      enduserId: (json['enduser_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      townshipId: (json['township_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddressVOToJson(AddressVO instance) => <String, dynamic>{
      'id': instance.id,
      'enduser_id': instance.enduserId,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'category_id': instance.categoryId,
      'township_id': instance.townshipId,
    };
