import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/services/routes.dart';
import 'package:provider/provider.dart';
import 'package:go_frontend_mobile/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:go_frontend_mobile/widgets/custom_text_field.dart';
import 'package:go_frontend_mobile/widgets/custom_button.dart';
import '../theme/colors.dart';
import '../widgets/profile_header.dart';
import '../widgets/time_dropdown_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;

  late TextEditingController _nameController;
  late TextEditingController _businessNameController;
  late TextEditingController _ownerNameController;
  late TextEditingController _businessCategoryController;
  late TextEditingController _districtController;
  late TextEditingController _counterBookingController;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).user;

    _nameController = TextEditingController(text: user?.name ?? "");
    _businessNameController = TextEditingController(
      text: user?.businessName ?? "",
    );
    _ownerNameController = TextEditingController(text: user?.ownerName ?? "");
    _businessCategoryController = TextEditingController(
      text: user?.businessCategory ?? "",
    );
    _districtController = TextEditingController(text: user?.district ?? "");
    _counterBookingController = TextEditingController(
      text: user?.counterBooking?.toString() ?? "",
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _businessNameController.dispose();
    _ownerNameController.dispose();
    _businessCategoryController.dispose();
    _districtController.dispose();
    _counterBookingController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    _toggleEditing();
  }

  void _logout() {
    Provider.of<AuthProvider>(context, listen: false).logoutUser();
    context.go(ConfigRoutes.signUpOptions);
  }

  void _showChangePlanDialog() {}

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

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
                        iconSize: 28,
                      ),
                    ],
                  ),

                  if (user.roleId == 3) ...[
                    CustomTextField(
                      label: "Business Name",
                      hintText:
                          _isEditing
                              ? _businessNameController.text
                              : (user.businessName ?? "Enter business name"),
                      controller: _businessNameController,
                      readOnly: !_isEditing,
                    ),
                    CustomTextField(
                      label: "Owner Name",
                      hintText:
                          _isEditing
                              ? _ownerNameController.text
                              : (user.ownerName ?? "Enter owner name"),
                      controller: _ownerNameController,
                      readOnly: !_isEditing,
                    ),
                    CustomTextField(
                      label: "Business Category",
                      hintText:
                          _isEditing
                              ? _businessCategoryController.text
                              : (user.businessCategory ?? "Select category"),
                      controller: _businessCategoryController,
                      isDropdown: _isEditing,
                      readOnly: !_isEditing,
                    ),
                    CustomTextField(
                      label: "District",
                      hintText:
                          _isEditing
                              ? _districtController.text
                              : (user.district ?? "Enter district"),
                      controller: _districtController,
                      readOnly: !_isEditing,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Bookings",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: AppColors.darkGray,
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: TimeDropdownField(
                            label: "Opening",
                            selectedTime: user.openingTime ?? "08:00 AM",
                            isEditing: _isEditing,
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TimeDropdownField(
                            label: "Closing",
                            selectedTime: user.closingTime ?? "08:00 PM",
                            isEditing: _isEditing,
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            label: "Qnty/Booking",
                            hintText:
                                _isEditing
                                    ? _counterBookingController.text
                                    : (user.counterBooking?.toString() ??
                                        "123"),
                            controller: _counterBookingController,
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

                  if (user.roleId == 2) ...[
                    CustomTextField(
                      label: "Name",
                      hintText: _isEditing ? _nameController.text : user.name,

                      controller: _nameController,
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
