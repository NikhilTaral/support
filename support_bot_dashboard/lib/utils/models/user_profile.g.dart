// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['eXpMember', 'MemberEmail'],
  );
  return UserProfile(
    json['eXpMember'] == null
        ? null
        : ProfileMember.fromJson(json['eXpMember'] as Map<String, dynamic>),
    json['MemberFirstName'] as String?,
    json['MemberCity'] as String?,
    json['MemberEmail'] as String?,
    json['MemberLastName'] as String?,
    json['MemberMiddleName'] as String?,
    json['MemberMobilePhone'] as String?,
    json['MemberPostalCode'] as String?,
    json['MemberStateOrProvince'] as String?,
    json['MemberNameSuffix'] as String?,
    json['MemberCountry'] as String?,
    json['SourceSystemMemberKey'] as String?,
    json['MemberStatus'] as String?,
    json['TeamLead'] as bool?,
    json['TeamName'] as String?,
    json['TeamType'] as String?,
    json['eXpSystemKey'] as num?,
  );
}
