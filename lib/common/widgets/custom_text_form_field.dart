import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Color? fillColor;
  final Color? inputTextColor;
  final TextEditingController? controller;
  final bool? obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final bool? isRichText; // Nova propriedade para determinar se é RichText

  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.fillColor,
    this.inputTextColor,
    this.controller,
    this.obscureText,
    this.validator,
    this.keyboardType,
    this.isRichText = false, // O padrão é false para campos normais
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
          inputFormatters: widget.keyboardType == TextInputType.number
              ? [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9.]'),
                  ),
                  CommaToDotInputFormatter(),
                ]
              : null,
          keyboardType: widget.isRichText == true
              ? TextInputType.multiline
              : widget.keyboardType, // Permitir múltiplas linhas
          controller: widget.controller,
          obscureText: widget.obscureText ?? false,
          validator: widget.validator,
          style: TextStyle(
              color: widget.inputTextColor ?? AppColors.primaryText),
          maxLines: widget.isRichText == true ? null : 1, // Expande o campo quando isRichText for true
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
            // Adiciona o ícone de calendário quando o tipo for datetime
            suffixIcon: widget.keyboardType == TextInputType.datetime
                ? IconButton(
                    icon: const Icon(Icons.calendar_today,
                        color: AppColors.primaryText),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        setState(() {
                          widget.controller?.text = formattedDate;
                        });
                      }
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class CommaToDotInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(',', '.');
    return newValue.copyWith(text: newText);
  }
}
