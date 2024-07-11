import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_member_uuid.g.dart';

@JsonSerializable(createToJson: false)
class ProfileMember extends Equatable {
  @JsonKey(name: 'Uuid', required: true)
  final String uuid;
  @JsonKey(name: 'MentorProgramEnrolled', required: false)
  final String? mentorProgramEnrolled;
  @JsonKey(name: 'IsMentor', required: false)
  final bool? isMentor;
  @JsonKey(name: "ManagingBroker", required: false)
  final bool? managingBroker;
  @JsonKey(name: "DesignatedManagingBroker", required: false)
  final bool? designatedManagingBroker;
  @JsonKey(name: "MarketingCenterEmail", required: false)
  final String? marketingCenterEmail;
  @JsonKey(name: "MemberSecondaryEmail", required: false)
  final String? memberSecondaryEmail;
  @JsonKey(name: "AgentStatesDMB", required: false)
  final String? agentStatesDMB;
  @JsonKey(name: "AgentStatesMB", required: false)
  final String? agentStatesMB;
  @JsonKey(name: "JoinDate", required: false)
  final String? joinDate;
  @JsonKey(name: "IsCommercialAgent", required: false)
  final bool? isCommericalAgent;
  @JsonKey(name: "IsReferral", required: false)
  final bool? isReferral;
  @JsonKey(name: "IsLuxuryMember", required: false)
  final bool? isLuxuryMember;
  @JsonKey(name: "TeamLead", required: false)
  final bool? isTeamLead;
  @JsonKey(name: "TeamName", required: false)
  final String? teamName;
  @JsonKey(name: "Birthday", required: false)
  final String? birthday;
  @JsonKey(name: "AnniversaryDate", required: false)
  final String? anniversaryDate;

  bool get isMentee {
    if (mentorProgramEnrolled == "None" || mentorProgramEnrolled == null) {
      return false;
    } else {
      return true;
    }
  }

  bool get isBroker {
    return managingBroker == true || designatedManagingBroker == true;
  }

  const ProfileMember(this.uuid,
      {this.mentorProgramEnrolled,
      this.isMentor,
      this.managingBroker,
      this.designatedManagingBroker,
      this.marketingCenterEmail,
      this.memberSecondaryEmail,
      this.agentStatesDMB,
      this.agentStatesMB,
      this.joinDate,
      this.isCommericalAgent,
      this.isReferral,
      this.isLuxuryMember,
      this.isTeamLead,
      this.teamName,
      this.birthday,
      this.anniversaryDate});

  factory ProfileMember.fromJson(Map<String, dynamic> json) =>
      _$ProfileMemberFromJson(json);

  @override
  List<Object?> get props => [
        uuid,
      ];
}
