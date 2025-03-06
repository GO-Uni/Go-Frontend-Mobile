import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/widgets/custom_text_field.dart';
import '../theme/colors.dart';
import '../widgets/profile_header.dart';

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

class ProfileScreen extends StatelessWidget {
  final UserModel user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: ProfileHeader(user: user),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  if (user.userType == UserType.business) ...[
                    CustomTextField(
                      label: "Business Name",
                      hintText: user.businessName ?? "Enter business name",
                    ),
                    CustomTextField(
                      label: "Owner Name",
                      hintText: user.ownerName ?? "Enter owner name",
                    ),
                    CustomTextField(
                      label: "Business Category",
                      hintText: user.businessCategory ?? "Select category",
                      isDropdown: true,
                    ),
                    CustomTextField(
                      label: "District",
                      hintText: user.district ?? "Enter district",
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: "Opening",
                            hintText: user.openingTime ?? "18:00 AM",
                            isDropdown: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            label: "Closing",
                            hintText: user.closingTime ?? "8:00 AM",
                            isDropdown: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            label: "Qnty/Booking",
                            hintText: user.qtyBooking?.toString() ?? "123",
                            isDropdown: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final UserModel defaultUser = UserModel(
  name: "Hanan",
  email: "hanan@email.com",
  userType: UserType.business,
);
