import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String label;
  final Color? backgroundColor;
  final double? size;
  final VoidCallback? onPressed;

  const CustomElevatedButton({
    super.key,
    required this.label,
    this.backgroundColor,
    this.onPressed,
    this.size,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.backgroundColor ?? AppColors.primaryGreen,
        minimumSize: Size(widget.size ?? 120, 50),
      ),
      child: Text(
        widget.label,
        style: const TextStyle(
          color: AppColors.primaryText,
        ),
      ),
    );
  }
}
