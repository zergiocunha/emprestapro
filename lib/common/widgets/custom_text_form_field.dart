import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Color? fillColor;
  final Color? inputTextColor;
  final TextEditingController? controller;
  final bool? obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.fillColor,
    this.inputTextColor,
    this.controller,
    this.obscureText,
    this.validator, this.keyboardType,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        validator: widget.validator,
        style: TextStyle(color: widget.inputTextColor ?? AppColors.primaryText),
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
                Radius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
