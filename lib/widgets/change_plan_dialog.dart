import 'package:flutter/material.dart';
import 'package:go_frontend_mobile/theme/text_styles.dart';
import 'package:go_frontend_mobile/widgets/signup_option_card.dart';
import 'package:go_frontend_mobile/theme/colors.dart';

class ChangePlanDialog extends StatefulWidget {
  final String currentPlan;
  final void Function(String selectedPlan) onSave;

  const ChangePlanDialog({
    super.key,
    required this.currentPlan,
    required this.onSave,
  });

  @override
  State<ChangePlanDialog> createState() => _ChangePlanDialogState();
}

class _ChangePlanDialogState extends State<ChangePlanDialog> {
  late String oppositePlan;
  String selectedPlan = "";

  @override
  void initState() {
    super.initState();
    oppositePlan = widget.currentPlan == "monthly" ? "yearly" : "monthly";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
          child: Container(color: Colors.transparent),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 180),
                  child: SignUpOptionCard(
                    title:
                        oppositePlan == "yearly"
                            ? "Yearly Plan"
                            : "Monthly Plan",
                    description:
                        oppositePlan == "yearly"
                            ? "Save more with our yearly subscription—enjoy uninterrupted access and exclusive discounts for a full year!"
                            : "Get access to all features with our monthly subscription—flexible and affordable, billed every month.",
                    actionText:
                        oppositePlan == "yearly"
                            ? "\$149.99/year"
                            : "\$14.99/month",
                    isSelected: selectedPlan == oppositePlan,
                    enableSelection: true,
                    onTap: () {
                      setState(() {
                        selectedPlan = oppositePlan;
                      });
                    },
                  ),
                ),
                if (selectedPlan.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        widget.onSave(selectedPlan);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
