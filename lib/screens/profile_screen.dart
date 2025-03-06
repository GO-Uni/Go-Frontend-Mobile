import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/widgets/custom_text_field.dart';
import '../theme/colors.dart';
import '../widgets/profile_header.dart';
import '../models/user_model.dart';

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
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: ProfileHeader(user: user),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit_note,
                          color: AppColors.darkGray,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),

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
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      label: "Subscription Method",
                      hintText: "Monthly",
                      subText: "\$14.99/monthly",
                      isSubscription: true,
                    ),
                  ],

                  if (user.userType == UserType.normal) ...[
                    CustomTextField(label: "Name", hintText: user.name),
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

final UserModel businessUser = UserModel(
  name: "Hanna",
  email: "hanan@gmail.com",
  userType: UserType.business,
  businessName: "3Draze",
  ownerName: "John Doe",
  businessCategory: "Clothing",
  district: "Lebanon",
  openingTime: "8:00 AM",
  closingTime: "8:00 PM",
  qtyBooking: 125,
  subscriptionMethod: "Monthly",
);

final UserModel normalUser = UserModel(
  name: "Hanan",
  email: "hanan@gmail.com",
  userType: UserType.normal,
);
