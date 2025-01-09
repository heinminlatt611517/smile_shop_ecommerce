// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignVo _$CampaignVoFromJson(Map<String, dynamic> json) => CampaignVo(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      userJoined: json['user_joined'] as bool?,
      joinedUsers: (json['joined_users'] as List<dynamic>?)
          ?.map((e) => UserVo.fromJson(e as Map<String, dynamic>))
          .toList(),
      product: json['product'] == null
          ? null
          : ProductVo.fromJson(json['product'] as Map<String, dynamic>),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CampaignVoToJson(CampaignVo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'price': instance.price,
      'description': instance.description,
      'user_joined': instance.userJoined,
      'joined_users': instance.joinedUsers,
      'product': instance.product,
    };

UserVo _$UserVoFromJson(Map<String, dynamic> json) => UserVo(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      userPhoto: json['user_photo'] as String?,
      profileImage: json['profile_image'] as String?,
    );

Map<String, dynamic> _$UserVoToJson(UserVo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'user_photo': instance.userPhoto,
      'profile_image': instance.profileImage,
    };

ProductVo _$ProductVoFromJson(Map<String, dynamic> json) => ProductVo(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      campaignId: (json['campaign_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductVoToJson(ProductVo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'campaign_id': instance.campaignId,
    };
