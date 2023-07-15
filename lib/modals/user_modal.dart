// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:twitter_clone/constants/constants.dart';

@immutable
class UserModal {
  final String email;
  final String name;
  final List<String> followers;
  final List<String> followings;
  final String profilePicture;
  final String bannerPicture;
  final String uid;
  final String bio;
  final String isTwitterBlue;
  final DateTime dateOfJoin;
  final DateTime dateOfBirth;
  final String website;
  final AccountType accountType;
  final ProfileCategory profileCategory;
  final bool showProfileCategory;
  const UserModal({
    required this.email,
    required this.name,
    required this.followers,
    required this.followings,
    required this.profilePicture,
    required this.bannerPicture,
    required this.uid,
    required this.bio,
    required this.isTwitterBlue,
    required this.dateOfJoin,
    required this.dateOfBirth,
    required this.website,
    required this.accountType,
    required this.profileCategory,
    required this.showProfileCategory,
  });

  UserModal copyWith({
    String? email,
    String? name,
    List<String>? followers,
    List<String>? followings,
    String? profilePicture,
    String? bannerPicture,
    String? uid,
    String? bio,
    String? isTwitterBlue,
    DateTime? dateOfJoin,
    DateTime? dateOfBirth,
    String? website,
    AccountType? accountType,
    ProfileCategory? profileCategory,
    bool? showProfileCategory,
  }) {
    return UserModal(
      email: email ?? this.email,
      name: name ?? this.name,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      profilePicture: profilePicture ?? this.profilePicture,
      bannerPicture: bannerPicture ?? this.bannerPicture,
      uid: uid ?? this.uid,
      bio: bio ?? this.bio,
      isTwitterBlue: isTwitterBlue ?? this.isTwitterBlue,
      dateOfJoin: dateOfJoin ?? this.dateOfJoin,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      website: website ?? this.website,
      accountType: accountType ?? this.accountType,
      profileCategory: profileCategory ?? this.profileCategory,
      showProfileCategory: showProfileCategory ?? this.showProfileCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'followers': followers,
      'followings': followings,
      'profilePicture': profilePicture,
      'bannerPicture': bannerPicture,
      'uid': uid,
      'bio': bio,
      'isTwitterBlue': isTwitterBlue,
      'dateOfJoin': dateOfJoin.millisecondsSinceEpoch,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,
      'website': website,
      'accountType': accountType.toMap(),
      'profileCategory': profileCategory.toMap(),
      'showProfileCategory': showProfileCategory,
    };
  }

  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      email: map['email'] as String,
      name: map['name'] as String,
      followers: List<String>.from((map['followers'] as List<String>)),
      followings: List<String>.from((map['followings'] as List<String>)),
      profilePicture: map['profilePicture'] as String,
      bannerPicture: map['bannerPicture'] as String,
      uid: map['uid'] as String,
      bio: map['bio'] as String,
      isTwitterBlue: map['isTwitterBlue'] as String,
      dateOfJoin: DateTime.fromMillisecondsSinceEpoch(map['dateOfJoin'] as int),
      dateOfBirth:
          DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] as int),
      website: map['website'] as String,
      accountType: AccountTypeExtension.fromMap(
          map['accountType'] as Map<String, dynamic>),
      profileCategory: ProfileCategoryExtension.fromMap(
          map['profileCategory'] as Map<String, dynamic>),
      showProfileCategory: map['showProfileCategory'] as bool,
    );
  }

  @override
  String toString() {
    return 'UserModal(email: $email, name: $name, followers: $followers, followings: $followings, profilePicture: $profilePicture, bannerPicture: $bannerPicture, uid: $uid, bio: $bio, isTwitterBlue: $isTwitterBlue, dateOfJoin: $dateOfJoin, dateOfBirth: $dateOfBirth, website: $website, accountType: $accountType, profileCategory: $profileCategory, showProfileCategory: $showProfileCategory)';
  }

  @override
  bool operator ==(covariant UserModal other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.name == name &&
        listEquals(other.followers, followers) &&
        listEquals(other.followings, followings) &&
        other.profilePicture == profilePicture &&
        other.bannerPicture == bannerPicture &&
        other.uid == uid &&
        other.bio == bio &&
        other.isTwitterBlue == isTwitterBlue &&
        other.dateOfJoin == dateOfJoin &&
        other.dateOfBirth == dateOfBirth &&
        other.website == website &&
        other.accountType == accountType &&
        other.profileCategory == profileCategory &&
        other.showProfileCategory == showProfileCategory;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        followers.hashCode ^
        followings.hashCode ^
        profilePicture.hashCode ^
        bannerPicture.hashCode ^
        uid.hashCode ^
        bio.hashCode ^
        isTwitterBlue.hashCode ^
        dateOfJoin.hashCode ^
        dateOfBirth.hashCode ^
        website.hashCode ^
        accountType.hashCode ^
        profileCategory.hashCode ^
        showProfileCategory.hashCode;
  }
}
