import 'package:flutter/material.dart';
import 'services/routes.dart';
import 'theme/colors.dart';
import 'theme/text_styles.dart';

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
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
