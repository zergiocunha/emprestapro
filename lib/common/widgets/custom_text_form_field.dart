import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class CutomTextFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;

  const CutomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
  });

  @override
  State<CutomTextFormField> createState() => _CutomTextFormFieldState();
}

class _CutomTextFormFieldState extends State<CutomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: const TextStyle(color: AppColors.secoundaryText),
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: AppColors.secoundaryText),
              filled: true,
              fillColor: AppColors.secoundaryBackground,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}
