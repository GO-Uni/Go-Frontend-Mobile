import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/providers/activity_provider.dart';
import 'package:go_frontend_mobile/providers/destination_provider.dart';
import 'package:go_frontend_mobile/providers/saved_provider.dart';
import 'package:provider/provider.dart';
import 'services/router.dart';
import 'theme/colors.dart';
import 'theme/text_styles.dart';
import 'providers/auth_provider.dart';
import 'providers/category_provider.dart';
import 'providers/profile_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider()..loadCategories(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProfileProvider>(
          create: (context) => ProfileProvider(),
          update: (context, authProvider, profileProvider) {
            if (authProvider.user != null) {
              profileProvider?.setUser(authProvider.user!);
            }
            return profileProvider!;
          },
        ),
        ChangeNotifierProvider(create: (_) => DestinationProvider()),
        ChangeNotifierProvider(create: (context) => ActivityProvider()),
        ChangeNotifierProvider(create: (context) => SavedProvider()),
      ],
      child: MaterialApp.router(
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
      ),
    );
  }
}
