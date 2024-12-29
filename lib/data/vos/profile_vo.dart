import 'package:json_annotation/json_annotation.dart';


part 'profile_vo.g.dart';

@JsonSerializable()
class ProfileVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'member_name')
  final String? memberName;

  @JsonKey(name: 'payment_password')
  final String? paymentPassword;

  @JsonKey(name: 'enduser_ip')
  final String? enduserIp;

  @JsonKey(name: 'level_id')
  final int? levelId;

  @JsonKey(name: 'level')
  final String? level;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'balance')
  final String? balance;

  @JsonKey(name: 'pay_recommender_id')
  final int? payRecommenderId;

  @JsonKey(name: 'source_recommender')
  final String? sourceRecommender;

  @JsonKey(name: 'recommender')
  final String? recommender;

  @JsonKey(name: 'recommender_id')
  final int? recommenderId;

  @JsonKey(name: 'recharge_amount')
  final String? rechargeAmount;

  @JsonKey(name: 'recharge_amount_under')
  final String? rechargeAmountUnder;

  @JsonKey(name: 'withdraw_amount')
  final String? withdrawAmount;

  @JsonKey(name: 'withdraw_amount_under')
  final String? withdrawAmountUnder;

  @JsonKey(name: 'team_performance')
  final String? teamPerformance;

  @JsonKey(name: 'registeration_time')
  final String? registrationTime;

  @JsonKey(name: 'activation_time')
  final String? activationTime;

  @JsonKey(name: 'registration_source_id')
  final int? registrationSourceId;

  @JsonKey(name: 'registration_source')
  final String? registrationSource;

  @JsonKey(name: 'state_id')
  final int? stateId;

  @JsonKey(name: 'state')
  final String? state;

  @JsonKey(name: 'is_limit')
  final int? isLimit;

  @JsonKey(name: 'profile_name')
  final String? profileName;

  @JsonKey(name: 'profile')
  final String? profile;

  @JsonKey(name: 'invite_code')
  final String? inviteCode;

  @JsonKey(name: 'is_head')
  final int? isHead;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'freeze')
  final int? freeze;

  @JsonKey(name: 'user_photo')
  final String? userPhoto;

  @JsonKey(name: 'profile_image')
  final String? profileImage;

  ProfileVO({
    this.id,
    this.name,
    this.memberName,
    this.paymentPassword,
    this.enduserIp,
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
    this.isHead,
    this.createdAt,
    this.updatedAt,
    this.freeze,
    this.userPhoto,
    this.profileImage,
  });

  factory ProfileVO.fromJson(Map<String, dynamic> json) => _$ProfileVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileVOToJson(this);
}
