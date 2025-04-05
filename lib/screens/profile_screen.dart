import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/profile_provider.dart';
import 'package:go_frontend_mobile/services/routes.dart';
import 'package:go_frontend_mobile/widgets/discover_dialog.dart';
import 'package:provider/provider.dart';
import 'package:go_frontend_mobile/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:go_frontend_mobile/widgets/custom_text_field.dart';
import 'package:go_frontend_mobile/widgets/custom_button.dart';
import '../theme/colors.dart';
import '../widgets/profile_header.dart';
import '../widgets/time_dropdown_field.dart';
import '../widgets/custom_dropdown_field.dart';
import 'package:go_frontend_mobile/providers/category_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;

  late TextEditingController _nameController;
  late TextEditingController _businessNameController;
  late TextEditingController _districtController;
  late TextEditingController _openingHourController;
  late TextEditingController _closingHourController;
  late TextEditingController _counterBookingController;

  String _selectedCategoryId = "";

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).user;

    _nameController = TextEditingController(text: user?.name ?? "");
    _businessNameController = TextEditingController(
      text: user?.businessName ?? "",
    );
    _districtController = TextEditingController(text: user?.district ?? "");
    _counterBookingController = TextEditingController(
      text: user?.counterBooking?.toString() ?? "",
    );
    _openingHourController = TextEditingController(text: user?.openingHour);
    _closingHourController = TextEditingController(text: user?.closingHour);
    _counterBookingController = TextEditingController(
      text: user?.counterBooking?.toString() ?? "",
    );
    _selectedCategoryId = user?.businessCategoryId ?? "";
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

  bool _dialogShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final isGuest = context.read<AuthProvider>().isGuest;

    if (isGuest && !_dialogShown) {
      _dialogShown = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          showDialog(context: context, builder: (_) => const DiscoverDialog());
        }
      });
    }
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
      onUpdate: (user) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.updateUser(user);
      },
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
      setState(() {
        _isEditing = false;
      });

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
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    final user = profileProvider.user;

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

                        List<DropdownMenuItem<String>> dropdownItems =
                            categoryProvider.categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: category['id'].toString(),
                                child: Text(category['name'] ?? ''),
                              );
                            }).toList();

                        if (!_isEditing) {
                          var selectedCategory = categoryProvider.categories
                              .firstWhere(
                                (cat) =>
                                    cat['id'].toString() == _selectedCategoryId,
                                orElse: () => {'name': ''},
                              );
                          String displayCategoryName =
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
                              setState(() {
                                _selectedCategoryId = value!;
                              });
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
