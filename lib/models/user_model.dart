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
  final int? qtyBooking;
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
    this.qtyBooking,
    this.subscriptionMethod,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? "Unknown",
      email: json['email'] ?? "No Email",
      roleId: json['role_id'] ?? 2,
      businessName: json['business_name'],
      ownerName: json['owner_name'],
      businessCategory: json['business_category'],
      district: json['district'],
      openingTime: json['opening_time'],
      closingTime: json['closing_time'],
      qtyBooking: json['qty_booking'],
      subscriptionMethod: json['subscription_method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "role_id": roleId,
      if (roleId == 3) ...{
        "business_name": businessName,
        "owner_name": ownerName,
        "business_category": businessCategory,
        "district": district,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "qty_booking": qtyBooking,
        "subscription_method": subscriptionMethod,
      },
    };
  }
}
