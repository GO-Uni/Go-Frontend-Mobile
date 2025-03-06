enum UserType { business, normal }

class UserModel {
  final String name;
  final String email;
  final UserType userType;
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
    required this.userType,
    this.businessName,
    this.ownerName,
    this.businessCategory,
    this.district,
    this.openingTime,
    this.closingTime,
    this.qtyBooking,
    this.subscriptionMethod,
  });
}
