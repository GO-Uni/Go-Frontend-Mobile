import 'package:flutter/material.dart';
import 'services/routes.dart';
import 'theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GO',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'Inter',
        primaryColor: AppColors.primary,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.darkGray),
          bodyMedium: TextStyle(
            color: AppColors.mediumGray,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
