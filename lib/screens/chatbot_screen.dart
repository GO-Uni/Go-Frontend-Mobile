import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/theme/colors.dart';
import 'package:go_frontend_mobile/theme/text_styles.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Column(
        children: [
          Expanded(child: Container()),
          Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.mediumGray,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type here...",
                      border: InputBorder.none,
                      hintStyle: AppTextStyles.bodyRegular.copyWith(
                        color: AppColors.lightGray,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
