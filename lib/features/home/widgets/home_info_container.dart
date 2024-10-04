import 'package:auto_size_text/auto_size_text.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class HomeInfoContainer extends StatelessWidget {
  const HomeInfoContainer({
    super.key,
    required this.dueDateTitle,
    required this.dueAmount,
    required this.debitTitle,
    required this.dueDate,
    required this.daysLeft,
    this.containerColor,
  });

  final String dueDateTitle;
  final double dueAmount;
  final String debitTitle;
  final String dueDate;
  final int daysLeft;
  final Color? containerColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // color: containerColor ?? AppColors.primaryGreen,
          gradient: AppColors.primaryGreen3D,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    dueDateTitle,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: 130,
                    child: AutoSizeText(
                      'R\$${dueAmount.toStringAsFixed(2)}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    debitTitle,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 25,
                    width: 130,
                    child: AutoSizeText(
                      dueDate,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              if (daysLeft > 0)
                Row(
                  children: [
                    Text(
                      '$daysLeft Days Left',
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
