import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/refer_code_vo.dart';
import 'package:smile_shop/persistence/hive_constants.dart';
part 'user_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeUserVO, adapterName: kAdapterNameUserVO)
class UserVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  final int? id;

  @JsonKey(name: 'name')
  @HiveField(1)
  final String? name;

  @JsonKey(name: 'member_name')
  @HiveField(2)
  final String? memberName;

  @JsonKey(name: 'payment_password')
  @HiveField(3)
  final String? paymentPassword;

  @JsonKey(name: 'enduser_ip')
  @HiveField(4)
  final String? endUserIp;

  @JsonKey(name: 'level_id')
  @HiveField(5)
  final int? levelId;

  @JsonKey(name: 'level')
  @HiveField(6)
  final String? level;

  @JsonKey(name: 'phone')
  @HiveField(7)
  final String? phone;

  @JsonKey(name: 'balance')
  @HiveField(8)
  final String? balance;

  @JsonKey(name: 'pay_recommender_id')
  @HiveField(9)
  final String? payRecommenderId;

  @JsonKey(name: 'source_recommender')
  @HiveField(10)
  final String? sourceRecommender;

  @JsonKey(name: 'recommender')
  @HiveField(11)
  final String? recommender;

  @JsonKey(name: 'recommender_id')
  @HiveField(12)
  final String? recommenderId;

  @JsonKey(name: 'recharge_amount')
  @HiveField(13)
  final String? rechargeAmount;

  @JsonKey(name: 'recharge_amount_under')
  @HiveField(14)
  final String? rechargeAmountUnder;

  @JsonKey(name: 'withdraw_amount')
  @HiveField(15)
  final String? withdrawAmount;

  @JsonKey(name: 'withdraw_amount_under')
  @HiveField(16)
  final String? withdrawAmountUnder;

  @JsonKey(name: 'team_performance')
  @HiveField(17)
  final String? teamPerformance;

  @JsonKey(name: 'registeration_time')
  @HiveField(18)
  final String? registrationTime;

  @JsonKey(name: 'activation_time')
  @HiveField(19)
  final String? activationTime;

  @JsonKey(name: 'registration_source_id')
  @HiveField(20)
  final String? registrationSourceId;

  @JsonKey(name: 'registration_source')
  @HiveField(21)
  final String? registrationSource;

  @JsonKey(name: 'state_id')
  @HiveField(22)
  final int? stateId;

  @JsonKey(name: 'state')
  @HiveField(23)
  final String? state;

  @JsonKey(name: 'is_limit')
  @HiveField(24)
  final int? isLimit;

  @JsonKey(name: 'profile_name')
  @HiveField(25)
  final String? profileName;

  @JsonKey(name: 'profile')
  @HiveField(26)
  final String? profile;

  @JsonKey(name: 'invite_code')
  @HiveField(27)
  final int? inviteCode;

  @JsonKey(name: 'created_at')
  @HiveField(28)
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  @HiveField(29)
  final String? updatedAt;

  @JsonKey(name: 'freeze')
  @HiveField(30)
  final int? freeze;

  @JsonKey(name: 'user_photo')
  @HiveField(31)
  final String? userPhoto;

  @JsonKey(name: 'profile_image')
  @HiveField(32)
  final String? profileImage;

  @JsonKey(name: 'refer_code')
  @HiveField(33)
  final ReferCodeVO? referCodeVO;

  @JsonKey(name: 'promotion_points')
  @HiveField(34)
  final int? promotionPoints;


  UserVO({
    this.id,
    this.name,
    this.memberName,
    this.paymentPassword,
    this.endUserIp,
    this.levelId,
    this.level,
    this.phone,
    this.balance,
    this.payRecommenderId,
    this.sourceRecommender,
    this.recommender,
    this.recommenderId,
    this.rechargeAmount,
    this.rechargeAmountUnder,
    this.withdrawAmount,
    this.withdrawAmountUnder,
    this.teamPerformance,
    this.registrationTime,
    this.activationTime,
    this.registrationSourceId,
    this.registrationSource,
    this.stateId,
    this.state,
    this.isLimit,
    this.profileName,
    this.profile,
    this.inviteCode,
    this.createdAt,
    this.updatedAt,
    this.freeze,
    this.userPhoto,
    this.profileImage,
    this.referCodeVO,
    this.promotionPoints
  });

  factory UserVO.fromJson(Map<String, dynamic> json) =>
      _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
