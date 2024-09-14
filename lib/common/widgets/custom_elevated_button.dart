import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButtom extends StatelessWidget {
  final String label;
  final Color? backgroundColor;

  const CustomElevatedButtom({
    super.key,
    required this.label,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryGreen,
        minimumSize: const Size(120, 50),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.primaryText,
        ),
      ),
    );
  }
}
