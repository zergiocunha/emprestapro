import 'package:auto_size_text/auto_size_text.dart';
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
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.background3D,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secoundaryBackground,
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 147,
                  height: 20,
                  child: AutoSizeText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    widget.containerName,
                    style: const TextStyle(
                      color: AppColors.secoundaryText,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  width: 147,
                  height: 32,
                  child: AutoSizeText(
                    'R\$${widget.amount.toStringAsFixed(2)}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: widget.amountColor ?? AppColors.primaryText,
                      fontSize: 32,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 20,
                  width: 147,
                  child: AutoSizeText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    widget.secondaryName,
                    style: const TextStyle(
                      color: AppColors.secoundaryText,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (widget.secondaryWidget != null)
                  widget.secondaryWidget!
                else
                  SizedBox(
                    height: 25,
                    width: 147,
                    child: AutoSizeText(
                      widget.secondaryInformation!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
