import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:go_frontend_mobile/providers/profile_provider.dart';
import 'package:go_frontend_mobile/providers/auth_provider.dart';
import 'package:go_frontend_mobile/providers/category_provider.dart';
import 'package:go_frontend_mobile/services/routes.dart';

import 'package:go_frontend_mobile/widgets/discover_dialog.dart';
import 'package:go_frontend_mobile/widgets/custom_text_field.dart';
import 'package:go_frontend_mobile/widgets/custom_button.dart';
import 'package:go_frontend_mobile/widgets/profile_header.dart';
import 'package:go_frontend_mobile/widgets/time_dropdown_field.dart';
import 'package:go_frontend_mobile/widgets/custom_dropdown_field.dart';

import '../theme/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  bool _isGuest = false;
  bool _dialogShown = false;

  late TextEditingController _nameController;
  late TextEditingController _businessNameController;
  late TextEditingController _districtController;
  late TextEditingController _openingHourController;
  late TextEditingController _closingHourController;
  late TextEditingController _counterBookingController;

  String _selectedCategoryId = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    _isGuest = authProvider.isGuest;

    if (_isGuest) {
      _initControllersFromUser(null);
      _isLoading = false;
    } else {
      profileProvider.loadAuthenticatedUser().then((success) {
        if (success && mounted) {
          final user = profileProvider.user;
          _initControllersFromUser(user);
        }
        if (mounted) {
          setState(() => _isLoading = false);
        }
      });
    }
  }

  void _initControllersFromUser(user) {
    _nameController = TextEditingController(text: user?.name ?? "");
    _businessNameController = TextEditingController(
      text: user?.businessName ?? "",
    );
    _districtController = TextEditingController(text: user?.district ?? "");
    _openingHourController = TextEditingController(
      text: user?.openingHour ?? "",
    );
    _closingHourController = TextEditingController(
      text: user?.closingHour ?? "",
    );
    _counterBookingController = TextEditingController(
      text: user?.counterBooking?.toString() ?? "",
    );
    _selectedCategoryId = user?.businessCategoryId ?? "";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isGuest && !_dialogShown) {
      _dialogShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          showDialog(context: context, builder: (_) => const DiscoverDialog());
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _businessNameController.dispose();
    _districtController.dispose();
    _openingHourController.dispose();
    _closingHourController.dispose();
    _counterBookingController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() async {
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    final user = profileProvider.user;

    if (user == null) {
      log("User is null. Exiting update.");
      return;
    }

    final categoryProvider = Provider.of<CategoryProvider>(
      context,
      listen: false,
    );
    final selectedCategory = categoryProvider.categories.firstWhere(
      (cat) => cat['id'].toString() == _selectedCategoryId,
      orElse: () => {'name': ''},
    );
    final selectedCategoryName = selectedCategory['name'] ?? '';

    bool success = await profileProvider.updateProfile(
      name: _nameController.text.isNotEmpty ? _nameController.text : user.name,
      businessName:
          _businessNameController.text.isNotEmpty
              ? _businessNameController.text
              : user.businessName,
      district:
          _districtController.text.isNotEmpty
              ? _districtController.text
              : user.district,
      openingHour:
          _openingHourController.text.isNotEmpty
              ? _openingHourController.text
              : user.openingHour,
      closingHour:
          _closingHourController.text.isNotEmpty
              ? _closingHourController.text
              : user.closingHour,
      counterBooking:
          _counterBookingController.text.isNotEmpty
              ? int.tryParse(_counterBookingController.text)
              : user.counterBooking,
      categoryId:
          _selectedCategoryId.isNotEmpty
              ? int.tryParse(_selectedCategoryId)
              : int.tryParse(user.businessCategoryId ?? ''),
      categoryName: selectedCategoryName,
    );

    if (!mounted) return;

    if (success) {
      log("Profile updated successfully!");
      setState(() => _isEditing = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to update profile. Please try again."),
        ),
      );
    }
  }

  void _logout() {
    Provider.of<AuthProvider>(context, listen: false).logoutUser(context);
    context.go(ConfigRoutes.signUpOptions);
  }

  void _showChangePlanDialog() {}

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final user = profileProvider.user;

    if (_isGuest) {
      return const Scaffold(
        backgroundColor: AppColors.lightGreen,
        body: Center(child: SizedBox.shrink()),
      );
    }

    if (_isLoading || user == null) {
      return const Scaffold(
        backgroundColor: AppColors.lightGreen,
        body: Center(child: CircularProgressIndicator()),
      );
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
                      hintText: _businessNameController.text,
                      controller: _businessNameController,
                      readOnly: !_isEditing,
                    ),
                    CustomTextField(
                      label: "Owner Name",
                      hintText: _nameController.text,
                      controller: _nameController,
                      readOnly: !_isEditing,
                    ),

                    Consumer<CategoryProvider>(
                      builder: (context, categoryProvider, child) {
                        if (categoryProvider.isLoading) {
                          return const CircularProgressIndicator();
                        }

                        final dropdownItems =
                            categoryProvider.categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: category['id'].toString(),
                                child: Text(category['name'] ?? ''),
                              );
                            }).toList();

                        if (!_isEditing) {
                          final selectedCategory = categoryProvider.categories
                              .firstWhere(
                                (cat) =>
                                    cat['id'].toString() == _selectedCategoryId,
                                orElse: () => {'name': ''},
                              );
                          final displayCategoryName =
                              selectedCategory['name'] ?? '';
                          return CustomTextField(
                            label: "Business Category",
                            hintText: displayCategoryName,
                            readOnly: true,
                          );
                        } else {
                          return CustomDropdownField(
                            label: "Business Category",
                            hintText: "Select category",
                            items: dropdownItems,
                            value:
                                _selectedCategoryId.isNotEmpty
                                    ? _selectedCategoryId
                                    : null,
                            onChanged: (value) {
                              setState(() => _selectedCategoryId = value!);
                            },
                          );
                        }
                      },
                    ),
                    CustomTextField(
                      label: "District",
                      hintText: _districtController.text,
                      controller: _districtController,
                      readOnly: !_isEditing,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Bookings",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            color: AppColors.darkGray,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TimeDropdownField(
                            label: "Opening",
                            selectedTime: _openingHourController.text,
                            isEditing: _isEditing,
                            onChanged: (value) {
                              setState(() {
                                _openingHourController.text = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TimeDropdownField(
                            label: "Closing",
                            selectedTime: _closingHourController.text,
                            isEditing: _isEditing,
                            onChanged: (value) {
                              setState(() {
                                _closingHourController.text = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            label: "Qnty/Booking",
                            hintText: _counterBookingController.text,
                            controller: _counterBookingController,
                            readOnly: !_isEditing,
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      label: "Subscription Method",
                      hintText:
                          user.subscriptionMethod != null &&
                                  user.subscriptionMethod!.isNotEmpty
                              ? '${user.subscriptionMethod![0].toUpperCase()}${user.subscriptionMethod!.substring(1)}'
                              : "Unknown",
                      subText:
                          user.subscriptionPrice != null
                              ? "\$${(user.subscriptionPrice! / 100).toStringAsFixed(2)}/${user.subscriptionMethod}"
                              : "",
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
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Align(
                alignment: Alignment.center,
                child: CustomButton(
                  text: _isEditing ? "Save" : "Logout",
                  onPressed: _isEditing ? _saveChanges : _logout,
                  width: 160,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
