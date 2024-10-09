import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class CustomDropdownButtonFormField<T> extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Color? fillColor;
  final Color? inputTextColor;
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  const CustomDropdownButtonFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.fillColor,
    this.inputTextColor,
    this.items,
    this.value,
    this.onChanged,
    this.validator,
  });

  @override
  State<CustomDropdownButtonFormField<T>> createState() => _CustomDropdownButtonFormFieldState<T>();
}

class _CustomDropdownButtonFormFieldState<T> extends State<CustomDropdownButtonFormField<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<T>(
          value: widget.value,
          items: widget.items,
          onChanged: widget.onChanged,
          validator: widget.validator,
          style: TextStyle(color: widget.inputTextColor ?? AppColors.primaryText),
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: AppColors.secoundaryText),
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
          dropdownColor: widget.fillColor ?? AppColors.secoundaryBackground,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.secoundaryText),
        ),
      ],
    );
  }
}
