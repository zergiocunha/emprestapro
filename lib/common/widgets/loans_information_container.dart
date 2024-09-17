import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class LoansInformationContainer extends StatefulWidget {
  final String containerName;
  final double amount;
  final Color? amountColor;
  final String secondaryName;
  final Widget? secondaryWidget;
  final String? secondaryInformation;

  const LoansInformationContainer({
    super.key,
    required this.containerName,
    required this.amount,
    this.amountColor,
    this.secondaryInformation,
    required this.secondaryName,
    this.secondaryWidget,
  });

  @override
  State<LoansInformationContainer> createState() =>
      _LoansInformationContainerState();
}

class _LoansInformationContainerState extends State<LoansInformationContainer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.secoundaryBackground,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 10,
                bottom: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.containerName,
                    style: const TextStyle(
                      color: AppColors.secoundaryText,
                      fontSize: 14,
                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
