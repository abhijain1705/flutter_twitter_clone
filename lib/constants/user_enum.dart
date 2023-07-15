enum AccountType { business, personal }

extension AccountTypeExtension on AccountType {
  String toShortString() {
    return toString().split('.').last;
  }

  Map<String, dynamic> toMap() {
    return {
      'accountType': toShortString(),
    };
  }

  static AccountType fromMap(Map<String, dynamic> map) {
    final String accountTypeString = map['accountType'];
    return AccountType.values.firstWhere(
      (type) => type.toShortString() == accountTypeString,
      orElse: () => AccountType.personal, // Provide a default value if needed
    );
  }
}

enum ProfileCategory {
  entertainmentRecreation,
  eventVenue,
  danceNightClub,
  automotive,
  aviation,
  marine,
  beautyCosmeticPersonalCare,
  commercialIndustrial,
  education,
  financialServices,
  restaurant,
  hotelLodging,
  homeGarden,
  professionalServices,
  advertisingMarketingAgency,
  lawyerLawFirm,
  mediaNewsCompany,
  medicalHealth,
  nonGovernmentalNonprofitOrganization,
  realEstate,
  scienceTechnology,
  shoppingRetail,
  fashionCompany,
  sportsFitnessRecreation,
  travelTransportation,
  other,
  mediaPersonality,
  socialMediaInfluencer,
  musician,
  journalist,
  entrepreneur,
  mobileApplication,
  community,
}

extension ProfileCategoryExtension on ProfileCategory {
  String toShortString() {
    return toString().split('.').last;
  }

  Map<String, dynamic> toMap() {
    return {
      'profileCategory': toShortString(),
    };
  }

  static ProfileCategory fromMap(Map<String, dynamic> map) {
    final String categoryString = map['profileCategory'];
    return ProfileCategory.values.firstWhere(
      (category) => category.toShortString() == categoryString,
      orElse: () => ProfileCategory
          .entertainmentRecreation, // Provide a default value if needed
    );
  }
}
