import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class LoanContainer extends StatefulWidget {
  final String containerName;
  final double amount;
  final Color? amountColor;
  final String secondaryName;
  final Widget? secondaryWidget;
  final String? secondaryInformation;

  const LoanContainer({
    super.key,
    required this.containerName,
    required this.amount,
    this.amountColor,
    this.secondaryInformation,
    required this.secondaryName,
    this.secondaryWidget,
  });

  @override
  State<LoanContainer> createState() => _LoanContainerState();
}

class _LoanContainerState extends State<LoanContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150,
      decoration: const BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          top: 10,
          bottom: 10,
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.containerName,
                          style: const TextStyle(
                            color: AppColors.secoundaryBackground,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Vencimento',
                              // widget.containerName,
                              style: TextStyle(
                                color: AppColors.secoundaryBackground,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '16/09/2024',
                              // widget.containerName,
                              style: TextStyle(
                                color: AppColors.secoundaryBackground,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'R\$${widget.amount}',
                  style: TextStyle(
                    color: widget.amountColor ?? AppColors.primaryText,
                    fontSize: 32,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.secondaryName,
                  style: const TextStyle(
                    color: AppColors.secoundaryText,
                    fontSize: 14,
                  ),
                ),
                if (widget.secondaryWidget != null)
                  widget.secondaryWidget!
                else
                  Text(
                    widget.secondaryInformation!,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
