import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

Future<void> popup({
  required BuildContext context,
  required String title,
  required String message,
  Color? buttonColor,
  Color? backgroundColor,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: backgroundColor ??
            AppColors.secoundaryBackground, // Cor de fundo do AlertDialog
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordas arredondadas
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.primaryText, // Cor do texto do título
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: AppColors.primaryText, // Cor do texto do conteúdo
            fontSize: 16,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor ?? AppColors.primaryGreen, // Cor do botão
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bordas do botão
              ),
            ),
            child: const Text(
              'Ok',
              style: TextStyle(
                color: AppColors.secoundaryBackground, // Cor do texto do botão
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    },
  );
}
