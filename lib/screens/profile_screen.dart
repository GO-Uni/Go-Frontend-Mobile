import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/profile_header.dart';

enum UserType { business, normal }

class UserModel {
  final String name;
  final String email;
  final UserType userType;

  const UserModel({
    required this.name,
    required this.email,
    required this.userType,
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
              padding: const EdgeInsets.all(14),
              child: ProfileHeader(user: user),
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
  userType: UserType.normal,
);
