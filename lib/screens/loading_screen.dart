import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/theme/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [CircularProgressIndicator(color: AppColors.primary)],
        ),
      ),
    );
  }
}
