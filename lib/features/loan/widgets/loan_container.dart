import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/widgets/description_value.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanContainer extends StatefulWidget {
  final String consumerName;
  final double amount;
  final double fees;
  final Color? amountColor;
  final String secondaryName;
  final Widget? secondaryWidget;
  final DateTime dueDate;
  final String imageUrl;
  final bool? concluded;

  const LoanContainer({
    super.key,
    required this.consumerName,
    required this.amount,
    required this.fees,
    this.amountColor,
    required this.secondaryName,
    this.secondaryWidget,
    required this.dueDate,
    required this.imageUrl,
    this.concluded,
  });

  @override
  State<LoanContainer> createState() => _LoanContainerState();
}

class _LoanContainerState extends State<LoanContainer> {
  final String value = '16/09/2024';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: widget.concluded!
            ? AppColors.background3D
            : AppColors.primaryGreen3D,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.secoundaryBackground,
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: widget.imageUrl == ''
                  ? null
                  : CachedNetworkImageProvider(widget.imageUrl),
              child: widget.imageUrl == '' ? const Icon(Icons.person, size: 40,) : null,
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
                    widget.consumerName,
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
                  value: 'R\$${widget.fees.toStringAsFixed(2)}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
