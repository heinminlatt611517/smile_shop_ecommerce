// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserVOAdapter extends TypeAdapter<UserVO> {
  @override
  final int typeId = 1;

  @override
  UserVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserVO(
      id: fields[0] as int?,
      name: fields[1] as String?,
      memberName: fields[2] as String?,
      paymentPassword: fields[3] as String?,
      endUserIp: fields[4] as String?,
      levelId: fields[5] as int?,
      level: fields[6] as String?,
      phone: fields[7] as String?,
      balance: fields[8] as String?,
      payRecommenderId: fields[9] as String?,
      sourceRecommender: fields[10] as String?,
      recommender: fields[11] as String?,
      recommenderId: fields[12] as String?,
      rechargeAmount: fields[13] as String?,
      rechargeAmountUnder: fields[14] as String?,
      withdrawAmount: fields[15] as String?,
      withdrawAmountUnder: fields[16] as String?,
      teamPerformance: fields[17] as String?,
      registrationTime: fields[18] as String?,
      activationTime: fields[19] as String?,
      registrationSourceId: fields[20] as String?,
      registrationSource: fields[21] as String?,
      stateId: fields[22] as int?,
      state: fields[23] as String?,
      isLimit: fields[24] as int?,
      profileName: fields[25] as String?,
      profile: fields[26] as String?,
      inviteCode: fields[27] as int?,
      createdAt: fields[28] as String?,
      updatedAt: fields[29] as String?,
      freeze: fields[30] as int?,
      userPhoto: fields[31] as String?,
      profileImage: fields[32] as String?,
      referCodeVO: fields[33] as ReferCodeVO?,
      promotionPoints: fields[34] as int?,
      showPopUp: fields[35] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserVO obj) {
    writer
      ..writeByte(36)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.memberName)
      ..writeByte(3)
      ..write(obj.paymentPassword)
      ..writeByte(4)
      ..write(obj.endUserIp)
      ..writeByte(5)
      ..write(obj.levelId)
      ..writeByte(6)
      ..write(obj.level)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.balance)
      ..writeByte(9)
      ..write(obj.payRecommenderId)
      ..writeByte(10)
      ..write(obj.sourceRecommender)
      ..writeByte(11)
      ..write(obj.recommender)
      ..writeByte(12)
      ..write(obj.recommenderId)
      ..writeByte(13)
      ..write(obj.rechargeAmount)
      ..writeByte(14)
      ..write(obj.rechargeAmountUnder)
      ..writeByte(15)
      ..write(obj.withdrawAmount)
      ..writeByte(16)
      ..write(obj.withdrawAmountUnder)
      ..writeByte(17)
      ..write(obj.teamPerformance)
      ..writeByte(18)
      ..write(obj.registrationTime)
      ..writeByte(19)
      ..write(obj.activationTime)
      ..writeByte(20)
      ..write(obj.registrationSourceId)
      ..writeByte(21)
      ..write(obj.registrationSource)
      ..writeByte(22)
      ..write(obj.stateId)
      ..writeByte(23)
      ..write(obj.state)
      ..writeByte(24)
      ..write(obj.isLimit)
      ..writeByte(25)
      ..write(obj.profileName)
      ..writeByte(26)
      ..write(obj.profile)
      ..writeByte(27)
      ..write(obj.inviteCode)
      ..writeByte(28)
      ..write(obj.createdAt)
      ..writeByte(29)
      ..write(obj.updatedAt)
      ..writeByte(30)
      ..write(obj.freeze)
      ..writeByte(31)
      ..write(obj.userPhoto)
      ..writeByte(32)
      ..write(obj.profileImage)
      ..writeByte(33)
      ..write(obj.referCodeVO)
      ..writeByte(34)
      ..write(obj.promotionPoints)
      ..writeByte(35)
      ..write(obj.showPopUp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      memberName: json['member_name'] as String?,
      paymentPassword: json['payment_password'] as String?,
      endUserIp: json['enduser_ip'] as String?,
      levelId: (json['level_id'] as num?)?.toInt(),
      level: json['level'] as String?,
      phone: json['phone'] as String?,
      balance: json['balance'] as String?,
      payRecommenderId: json['pay_recommender_id'] as String?,
      sourceRecommender: json['source_recommender'] as String?,
      recommender: json['recommender'] as String?,
      recommenderId: json['recommender_id'] as String?,
      rechargeAmount: json['recharge_amount'] as String?,
      rechargeAmountUnder: json['recharge_amount_under'] as String?,
      withdrawAmount: json['withdraw_amount'] as String?,
      withdrawAmountUnder: json['withdraw_amount_under'] as String?,
      teamPerformance: json['team_performance'] as String?,
      registrationTime: json['registeration_time'] as String?,
      activationTime: json['activation_time'] as String?,
      registrationSourceId: json['registration_source_id'] as String?,
      registrationSource: json['registration_source'] as String?,
      stateId: (json['state_id'] as num?)?.toInt(),
      state: json['state'] as String?,
      isLimit: (json['is_limit'] as num?)?.toInt(),
      profileName: json['profile_name'] as String?,
      profile: json['profile'] as String?,
      inviteCode: (json['invite_code'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      freeze: (json['freeze'] as num?)?.toInt(),
      userPhoto: json['user_photo'] as String?,
      profileImage: json['profile_image'] as String?,
      referCodeVO: json['refer_code'] == null
          ? null
          : ReferCodeVO.fromJson(json['refer_code'] as Map<String, dynamic>),
      promotionPoints: (json['promotion_points'] as num?)?.toInt(),
      showPopUp: (json['show_popup'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'member_name': instance.memberName,
      'payment_password': instance.paymentPassword,
      'enduser_ip': instance.endUserIp,
      'level_id': instance.levelId,
      'level': instance.level,
      'phone': instance.phone,
      'balance': instance.balance,
      'pay_recommender_id': instance.payRecommenderId,
      'source_recommender': instance.sourceRecommender,
      'recommender': instance.recommender,
      'recommender_id': instance.recommenderId,
      'recharge_amount': instance.rechargeAmount,
      'recharge_amount_under': instance.rechargeAmountUnder,
      'withdraw_amount': instance.withdrawAmount,
      'withdraw_amount_under': instance.withdrawAmountUnder,
      'team_performance': instance.teamPerformance,
      'registeration_time': instance.registrationTime,
      'activation_time': instance.activationTime,
      'registration_source_id': instance.registrationSourceId,
      'registration_source': instance.registrationSource,
      'state_id': instance.stateId,
      'state': instance.state,
      'is_limit': instance.isLimit,
      'profile_name': instance.profileName,
      'profile': instance.profile,
      'invite_code': instance.inviteCode,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'freeze': instance.freeze,
      'user_photo': instance.userPhoto,
      'profile_image': instance.profileImage,
      'refer_code': instance.referCodeVO,
      'promotion_points': instance.promotionPoints,
      'show_popup': instance.showPopUp,
    };
