// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModal {
  final String ownerName;
  final String shopName;
  final String shopAddress;
  final String pinCode;
  final String profilePicture;
  final String cardPicture;
  final String document;
  final String mobileNumber;
  final DateTime dateOfJoin;
  UserModal({
    required this.ownerName,
    required this.shopName,
    required this.shopAddress,
    required this.pinCode,
    required this.profilePicture,
    required this.cardPicture,
    required this.document,
    required this.mobileNumber,
    required this.dateOfJoin,
  });

  UserModal copyWith({
    String? ownerName,
    String? shopName,
    String? shopAddress,
    String? pinCode,
    String? profilePicture,
    String? cardPicture,
    String? document,
    String? mobileNumber,
    DateTime? dateOfJoin,
  }) {
    return UserModal(
      ownerName: ownerName ?? this.ownerName,
      shopName: shopName ?? this.shopName,
      shopAddress: shopAddress ?? this.shopAddress,
      pinCode: pinCode ?? this.pinCode,
      profilePicture: profilePicture ?? this.profilePicture,
      cardPicture: cardPicture ?? this.cardPicture,
      document: document ?? this.document,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      dateOfJoin: dateOfJoin ?? this.dateOfJoin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ownerName': ownerName,
      'shopName': shopName,
      'shopAddress': shopAddress,
      'pinCode': pinCode,
      'profilePicture': profilePicture,
      'cardPicture': cardPicture,
      'document': document,
      'mobileNumber': mobileNumber,
      'dateOfJoin': dateOfJoin.millisecondsSinceEpoch,
    };
  }

  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      ownerName: map['ownerName'] as String,
      shopName: map['shopName'] as String,
      shopAddress: map['shopAddress'] as String,
      pinCode: map['pinCode'] as String,
      profilePicture: map['profilePicture'] as String,
      cardPicture: map['cardPicture'] as String,
      document: map['document'] as String,
      mobileNumber: map['mobileNumber'] as String,
      dateOfJoin: DateTime.fromMillisecondsSinceEpoch(map['dateOfJoin'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModal.fromJson(String source) => UserModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModal(ownerName: $ownerName, shopName: $shopName, shopAddress: $shopAddress, pinCode: $pinCode, profilePicture: $profilePicture, cardPicture: $cardPicture, document: $document, mobileNumber: $mobileNumber, dateOfJoin: $dateOfJoin)';
  }

  @override
  bool operator ==(covariant UserModal other) {
    if (identical(this, other)) return true;
  
    return 
      other.ownerName == ownerName &&
      other.shopName == shopName &&
      other.shopAddress == shopAddress &&
      other.pinCode == pinCode &&
      other.profilePicture == profilePicture &&
      other.cardPicture == cardPicture &&
      other.document == document &&
      other.mobileNumber == mobileNumber &&
      other.dateOfJoin == dateOfJoin;
  }

  @override
  int get hashCode {
    return ownerName.hashCode ^
      shopName.hashCode ^
      shopAddress.hashCode ^
      pinCode.hashCode ^
      profilePicture.hashCode ^
      cardPicture.hashCode ^
      document.hashCode ^
      mobileNumber.hashCode ^
      dateOfJoin.hashCode;
  }
}
