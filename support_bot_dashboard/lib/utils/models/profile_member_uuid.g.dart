// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_member_uuid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileMember _$ProfileMemberFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['Uuid'],
  );
  return ProfileMember(
    json['Uuid'] as String,
    mentorProgramEnrolled: json['MentorProgramEnrolled'] as String?,
    isMentor: json['IsMentor'] as bool?,
    managingBroker: json['ManagingBroker'] as bool?,
    designatedManagingBroker: json['DesignatedManagingBroker'] as bool?,
    marketingCenterEmail: json['MarketingCenterEmail'] as String?,
    memberSecondaryEmail: json['MemberSecondaryEmail'] as String?,
    agentStatesDMB: json['AgentStatesDMB'] as String?,
    agentStatesMB: json['AgentStatesMB'] as String?,
    joinDate: json['JoinDate'] as String?,
    isCommericalAgent: json['IsCommercialAgent'] as bool?,
    isReferral: json['IsReferral'] as bool?,
    isLuxuryMember: json['IsLuxuryMember'] as bool?,
    isTeamLead: json['TeamLead'] as bool?,
    teamName: json['TeamName'] as String?,
    birthday: json['Birthday'] as String?,
    anniversaryDate: json['AnniversaryDate'] as String?,
  );
}
