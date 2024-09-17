import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanContainer extends StatefulWidget {
  final String debtorName;
  final double amount;
  final Color? amountColor;
  final String secondaryName;
  final Widget? secondaryWidget;
  final DateTime dueDate;
  final String imageUrl;

  const LoanContainer({
    super.key,
    required this.debtorName,
    required this.amount,
    this.amountColor,
    required this.secondaryName,
    this.secondaryWidget,
    required this.dueDate,
    required this.imageUrl,
  });

  @override
  State<LoanContainer> createState() => _LoanContainerState();
}

class _LoanContainerState extends State<LoanContainer> {
  final String value = '16/09/2024';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(widget.imageUrl),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 25,
                  width: 120,
                  child: AutoSizeText(
                    widget.debtorName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                DescriptionValueRow(
                  descrtiption: 'Valor Total',
                  value: 'R\$${widget.amount.toStringAsFixed(2)}',
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DescriptionValueRow(
                  descrtiption: 'Vancimento',
                  value: DateFormat('dd/MM/yyyy').format(widget.dueDate),
                ),
                DescriptionValueRow(
                  descrtiption: 'Juros',
                  value: 'R\$${widget.amount.toStringAsFixed(2)}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptionValueRow extends StatelessWidget {
  const DescriptionValueRow({
    super.key,
    required this.descrtiption,
    required this.value,
  });

  final String descrtiption;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
              width: 120,
              child: AutoSizeText(
                descrtiption,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              height: 25,
              width: 120,
              child: AutoSizeText(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
