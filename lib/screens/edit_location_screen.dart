import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/profile_provider.dart';
import 'package:go_frontend_mobile/theme/colors.dart';
import 'package:go_frontend_mobile/theme/text_styles.dart';
import 'package:go_frontend_mobile/widgets/snackbar_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';

class EditLocationScreen extends StatefulWidget {
  const EditLocationScreen({super.key});

  @override
  State<EditLocationScreen> createState() => _EditLocationScreenState();
}

class _EditLocationScreenState extends State<EditLocationScreen> {
  LatLng? _selectedLocation;
  LatLng _initialCenter = const LatLng(33.8547, 35.8623); // default fallback

  @override
  void initState() {
    super.initState();

    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    final user = profileProvider.user;

    if (user != null && user.latitude != null && user.longitude != null) {
      final lat = double.tryParse(user.latitude.toString());
      final lng = double.tryParse(user.longitude.toString());

      if (lat != null && lng != null) {
        _initialCenter = LatLng(lat, lng);
        _selectedLocation = _initialCenter;
      }
    }
  }

  void _onMapTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  void _confirmSelection() async {
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    final user = profileProvider.user;

    if (user == null || _selectedLocation == null) {
      log("User or selected location is null. Exiting update.");
      return;
    }

    final lat = _selectedLocation!.latitude;
    final lng = _selectedLocation!.longitude;

    bool success = await profileProvider.updateProfile(
      latitude: lat,
      longitude: lng,
    );

    if (!mounted) return;

    if (success) {
      showCustomSnackBar(
        context: context,
        message: "Location updated successfully.",
        icon: Icons.check_circle_outline,
        backgroundColor: AppColors.primary,
      );

      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;
      Navigator.of(context).pop();
    } else {
      showCustomSnackBar(
        context: context,
        message: "Failed to update location. Please try again.",
        icon: Icons.error_outline,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (_) {},
            initialCameraPosition: CameraPosition(
              target: _initialCenter,
              zoom: 11,
            ),
            onTap: _onMapTap,
            markers:
                _selectedLocation == null
                    ? {}
                    : {
                      Marker(
                        markerId: const MarkerId("selected"),
                        position: _selectedLocation!,
                      ),
                    },
          ),

          Positioned(
            top: 5,
            left: 16,
            right: 16,
            child: Text(
              "Tap on the map to select your location",
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkGreen,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          if (_selectedLocation != null)
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black87 : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.15 * 255).round()),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selected Location:",
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Latitude: ${_selectedLocation!.latitude.toStringAsFixed(6)}",
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Longitude: ${_selectedLocation!.longitude.toStringAsFixed(6)}",
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 13),
                  CustomButton(
                    text: "Confirm your location",
                    width: 250,
                    onPressed: _confirmSelection,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
