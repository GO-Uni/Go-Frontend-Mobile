enum UserType { business, normal }

class UserModel {
  final String name;
  final String email;
  final int roleId;
  final String? businessName;
  final String? ownerName;
  final String? businessCategory;
  final String? district;
  final String? openingTime;
  final String? closingTime;
  final int? counterBooking;
  final String? subscriptionMethod;

  const UserModel({
    required this.name,
    required this.email,
    required this.roleId,
    this.businessName,
    this.ownerName,
    this.businessCategory,
    this.district,
    this.openingTime,
    this.closingTime,
    this.counterBooking,
    this.subscriptionMethod,
  });

  UserModel copyWith({
    String? name,
    String? email,
    int? roleId,
    String? businessName,
    String? ownerName,
    String? businessCategory,
    String? district,
    String? openingTime,
    String? closingTime,
    int? counterBooking,
    String? subscriptionMethod,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      roleId: roleId ?? this.roleId,
      businessName: businessName ?? this.businessName,
      ownerName: ownerName ?? this.ownerName,
      businessCategory: businessCategory ?? this.businessCategory,
      district: district ?? this.district,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      counterBooking: counterBooking ?? this.counterBooking,
      subscriptionMethod: subscriptionMethod ?? this.subscriptionMethod,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? "Unknown",
      email: json['email'] ?? "No Email",
      roleId: json['role_id'] ?? 2,
      businessName: json['business_name'] as String?,
      ownerName: json['owner_name'] as String?,
      businessCategory: json['business_category'] as String?,
      district: json['district'] as String?,
      openingTime: json['opening_time'] as String?,
      closingTime: json['closing_time'] as String?,
      counterBooking:
          json['qty_booking'] != null
              ? int.tryParse(json['qty_booking'].toString())
              : null,
      subscriptionMethod: json['subscription_method'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "role_id": roleId,
      "business_name": businessName,
      "owner_name": ownerName,
      "business_category": businessCategory,
      "district": district,
      "opening_time": openingTime,
      "closing_time": closingTime,
      "qty_booking": counterBooking,
      "subscription_method": subscriptionMethod,
    };
  }
}
