import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class EvolutionContainer extends StatelessWidget {
  final double value;

  const EvolutionContainer({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        color: value > 0 ? AppColors.secundaryGreen : AppColors.secondaryRed,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 4,
          top: 2,
          bottom: 2,
        ),
        child: Row(
          children: [
            Text(
              '${value.toStringAsFixed(2)}%',
              style: TextStyle(
                color:
                    value > 0 ? AppColors.primaryGreen : AppColors.primaryRed,
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              value > 0 ? Icons.trending_up : Icons.trending_down,
              color: value > 0 ? AppColors.primaryGreen : AppColors.primaryRed,
            ),
          ],
        ),
      ),
    );
  }
}
