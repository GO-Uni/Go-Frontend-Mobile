enum UserType { business, normal }

class UserModel {
  final String name;
  final String email;
  final int roleId;
  final String? businessName;
  final String? ownerName;
  final String? businessCategory;
  final String? businessCategoryId;
  final String? district;
  final String? openingHour;
  final String? closingHour;
  final int? counterBooking;
  final String? subscriptionMethod;
  final String? businessDescription;
  final int? userId;

  const UserModel({
    required this.name,
    required this.email,
    required this.roleId,
    this.businessName,
    this.ownerName,
    this.businessCategory,
    this.businessCategoryId,
    this.district,
    this.openingHour,
    this.closingHour,
    this.counterBooking,
    this.subscriptionMethod,
    this.businessDescription,
    required this.userId,
  });

  UserModel copyWith({
    String? name,
    String? email,
    int? roleId,
    String? businessName,
    String? ownerName,
    String? businessCategory,
    String? businessCategoryId,
    String? district,
    String? openingHour,
    String? closingHour,
    int? counterBooking,
    String? subscriptionMethod,
    String? businessDescription,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      roleId: roleId ?? this.roleId,
      userId: userId,
      businessName: businessName ?? this.businessName,
      ownerName: ownerName ?? this.ownerName,
      businessCategory: businessCategory ?? this.businessCategory,
      businessCategoryId: businessCategoryId ?? this.businessCategoryId,
      district: district ?? this.district,
      openingHour: openingHour ?? this.openingHour,
      closingHour: closingHour ?? this.closingHour,
      counterBooking: counterBooking ?? this.counterBooking,
      subscriptionMethod: subscriptionMethod ?? this.subscriptionMethod,
      businessDescription: businessDescription ?? this.businessDescription,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final businessProfile = json['business_profile'] ?? {};

    return UserModel(
      name: json['name'] ?? "Unknown",
      email: json['email'] ?? "No Email",
      roleId: json['role_id'] ?? 2,
      userId: json['id'],

      businessName: businessProfile['business_name'] as String?,
      ownerName: businessProfile['user_name'] as String?,
      businessCategory: businessProfile['category_name'] as String?,
      businessCategoryId: businessProfile['category_id']?.toString(),
      district: businessProfile['district'] as String?,
      openingHour: businessProfile['opening_hour'] as String?,
      closingHour: businessProfile['closing_hour'] as String?,
      businessDescription: businessProfile['description'] as String,
      counterBooking:
          businessProfile['counter_booking'] != null
              ? int.tryParse(businessProfile['counter_booking'].toString())
              : null,

      subscriptionMethod: json['subscription_method'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "role_id": roleId,
      "subscription_method": subscriptionMethod,
      "userId": userId,

      if (roleId == 3)
        "business_profile": {
          "business_name": businessName,
          "owner_name": ownerName,
          "category_id": businessCategoryId,
          "category_name": businessCategory,
          "district": district,
          "opening_hour": openingHour,
          "closing_hour": closingHour,
          "counter_booking": counterBooking,
          'business_description': businessDescription,
        },
    };
  }
}
