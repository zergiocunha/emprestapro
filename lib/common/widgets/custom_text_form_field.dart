import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class CutomTextFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Color? fillColor;

  const CutomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.fillColor,
  });

  @override
  State<CutomTextFormField> createState() => _CutomTextFormFieldState();
}

class _CutomTextFormFieldState extends State<CutomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: AppColors.secoundaryText),
            alignLabelWithHint: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: AppColors.secoundaryText),
            filled: true,
            fillColor: widget.fillColor ?? AppColors.secoundaryBackground,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
