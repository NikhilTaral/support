// import 'package:equatable/equatable.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// import 'package:learning_ai_web/utils/models/profile_member_uuid.dart';

// part 'user_profile.freezed.dart';

// @freezed
// class UserProfile with _$UserProfile{
//   const factory UserProfile({
//     required String firstName,
//     required String lastName,
//   }) = _UserProfile;

//   factory UserProfile.fromJson(Map<String , Object?> json)
//   => _$UserProfileFromJson(json);
// }

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:support_bot_dashboard/utils/models/profile_member_uuid.dart';

part 'user_profile.g.dart';

@JsonSerializable(createToJson: false)
class UserProfile extends Equatable {
  @JsonKey(name: 'eXpMember', required: true)
  final ProfileMember? profileMember;
  @JsonKey(name: 'MemberFirstName', required: false)
  final String? firstName;
  @JsonKey(name: 'MemberCity', required: false)
  final String? city;
  @JsonKey(name: 'MemberEmail', required: true)
  final String? email;
  @JsonKey(name: 'MemberLastName', required: false)
  final String? lastName;
  @JsonKey(name: 'MemberMiddleName', required: false)
  final String? middleName;
  @JsonKey(name: 'MemberMobilePhone', required: false)
  final String? mobile;
  @JsonKey(name: 'MemberPostalCode', required: false)
  final String? postalCode;
  @JsonKey(name: 'MemberStateOrProvince', required: false)
  final String? stateOrProvince;
  @JsonKey(name: 'MemberNameSuffix', required: false)
  final String? suffix;
  @JsonKey(name: 'MemberCountry', required: false)
  final String? country;
  @JsonKey(name: 'SourceSystemMemberKey', required: false)
  final String? sourceSystemMemberKey;
  @JsonKey(name: 'MemberStatus', required: false)
  final String? memberStatus;
  @JsonKey(name: "TeamLead", required: false)
  final bool? teamLead;
  @JsonKey(name: "TeamName", required: false)
  final String? teamName;
  @JsonKey(name: "TeamType", required: false)
  final String? teamType;
  @JsonKey(name: 'eXpSystemKey', required: false)
  final num? eXpSystemKey;

  bool isTeamLead() {
    return profileMember?.isTeamLead ?? teamLead ?? false;
  }

  bool isMentor() {
    return profileMember?.isMentor ?? false;
  }

  bool is90DaysOverJoining() {
    DateTime ninetyDaysAgo = DateTime.now().subtract(Duration(days: 90));
    if (profileMember?.joinDate != null) {
      DateTime joinDate =
          DateTime.tryParse(profileMember?.joinDate ?? "") ?? DateTime.now();
      return joinDate.isAfter(ninetyDaysAgo) ||
          joinDate.isAtSameMomentAs(ninetyDaysAgo);
    }
    return false;
  }

  const UserProfile(
    this.profileMember,
    this.firstName,
    this.city,
    this.email,
    this.lastName,
    this.middleName,
    this.mobile,
    this.postalCode,
    this.stateOrProvince,
    this.suffix,
    this.country,
    this.sourceSystemMemberKey,
    this.memberStatus,
    this.teamLead,
    this.teamName,
    this.teamType,
    this.eXpSystemKey,
  );

  String? fullName() {
    var name = suffix ?? "";

    if (lastName?.isNotEmpty == true) {
      name = lastName! + " " + name;
    }

    if (middleName?.isNotEmpty == true) {
      name = middleName! + " " + name;
    }

    if (firstName?.isNotEmpty == true) {
      name = firstName! + " " + name;
    }

    return name;
  }

  String? get agentUuid {
    return profileMember?.uuid;
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  @override
  List<Object?> get props => [
        profileMember,
        firstName,
        city,
        email,
        lastName,
        middleName,
        mobile,
        postalCode,
        stateOrProvince,
        suffix,
        country,
        sourceSystemMemberKey,
        memberStatus,
        teamLead,
        teamName,
        teamType,
        eXpSystemKey,
      ];
}

