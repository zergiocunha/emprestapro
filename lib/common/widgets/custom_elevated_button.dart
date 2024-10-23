import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String label;
  final Color? backgroundColor;
  final double? size;
  final VoidCallback? onPressed;
  final IconData? icon;

  const CustomElevatedButton({
    super.key,
    required this.label,
    this.backgroundColor,
    this.onPressed,
    this.size,
    this.icon,
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
        elevation: 5,
        shadowColor: AppColors.primaryGreen.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.hovered)) {
              return (widget.backgroundColor ?? AppColors.primaryGreen)
                  .withOpacity(0.8);
            }
            if (states.contains(WidgetState.pressed)) {
              return (widget.backgroundColor ?? AppColors.primaryGreen)
                  .withOpacity(0.6);
            }
            if (states.contains(WidgetState.disabled)) {
              return AppColors.primaryGreen.withOpacity(0.3);
            }
            return widget.backgroundColor ?? AppColors.primaryGreen;
          },
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Ajusta o tamanho do botão ao conteúdo
        children: [
          if (widget.icon != null) // Se o ícone foi passado, exibe
            Padding(
              padding: const EdgeInsets.only(right: 8.0), // Espaço entre ícone e texto
              child: Icon(
                widget.icon,
                color: AppColors.primaryText,
                size: 20,
              ),
            ),
          Text(
            widget.label,
            style: const TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
