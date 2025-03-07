import 'package:flutter/material.dart';
//import 'package:go_frontend_mobile/theme/text_styles.dart';
import 'package:go_frontend_mobile/widgets/custom_text_field.dart';
import 'package:go_frontend_mobile/widgets/custom_button.dart';
import '../theme/colors.dart';
import '../widgets/profile_header.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    _toggleEditing();
  }

  void _logout() {}

  void _showChangePlanDialog() {}

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
              child: ProfileHeader(user: widget.user),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isEditing ? Icons.check : Icons.edit_note,
                          color: AppColors.darkGray,
                        ),
                        onPressed: _toggleEditing,
                      ),
                    ],
                  ),

                  if (widget.user.userType == UserType.business) ...[
                    CustomTextField(
                      label: "Business Name",
                      hintText:
                          widget.user.businessName ?? "Enter business name",
                      readOnly: !_isEditing,
                    ),
                    CustomTextField(
                      label: "Owner Name",
                      hintText: widget.user.ownerName ?? "Enter owner name",
                      readOnly: !_isEditing,
                    ),
                    CustomTextField(
                      label: "Business Category",
                      hintText:
                          widget.user.businessCategory ?? "Select category",
                      isDropdown: _isEditing,
                      readOnly: !_isEditing,
                    ),
                    CustomTextField(
                      label: "District",
                      hintText: widget.user.district ?? "Enter district",
                      readOnly: !_isEditing,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: "Opening",
                            hintText: widget.user.openingTime ?? "18:00 AM",
                            isDropdown: _isEditing,
                            readOnly: !_isEditing,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            label: "Closing",
                            hintText: widget.user.closingTime ?? "8:00 AM",
                            isDropdown: _isEditing,
                            readOnly: !_isEditing,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            label: "Qnty/Booking",
                            hintText:
                                widget.user.qtyBooking?.toString() ?? "123",
                            readOnly: !_isEditing,
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      label: "Subscription Method",
                      hintText: "Monthly",
                      subText: "\$14.99/monthly",
                      isSubscription: true,
                      readOnly: true,
                      onChangePlan: _showChangePlanDialog,
                    ),
                  ],

                  if (widget.user.userType == UserType.normal) ...[
                    CustomTextField(
                      label: "Name",
                      hintText: widget.user.name,
                      readOnly: !_isEditing,
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: Alignment.center,
                child: CustomButton(
                  text: _isEditing ? "Save" : "Logout",
                  onPressed: _isEditing ? _saveChanges : _logout,
                  width: 160,
                ),
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
