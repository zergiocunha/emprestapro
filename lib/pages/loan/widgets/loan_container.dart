import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/utils/data_manipulation.dart';
import 'package:emprestapro/common/utils/validator.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/description_value.dart';
import 'package:emprestapro/pages/home/home_controller.dart';
import 'package:emprestapro/pages/loan/loan_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanContainer extends StatefulWidget {
  final String consumerName;
  final double amount;
  final double historicAmount;
  final double fees;
  final Color? amountColor;
  final String secondaryName;
  final Widget? secondaryWidget;
  final DateTime dueDate;
  final String imageUrl;
  final bool? concluded;
  final String phoneNumber;
  final VoidCallback? onPressed;

  const LoanContainer({
    super.key,
    required this.consumerName,
    required this.amount,
    required this.historicAmount,
    required this.fees,
    this.amountColor,
    required this.secondaryName,
    this.secondaryWidget,
    required this.dueDate,
    required this.imageUrl,
    required this.phoneNumber,
    this.concluded,
    this.onPressed,
  });

  @override
  State<LoanContainer> createState() => _LoanContainerState();
}

class _LoanContainerState extends State<LoanContainer> {
  final _homeController = locator.get<HomeController>();
  final _loanController = locator.get<LoanController>();

  @override
  Widget build(BuildContext context) {
    bool isDueToday = Validator.isDueTodayOrPast(
      widget.dueDate,
      widget.concluded!,
    );

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGreen3D,
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
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: isDueToday ? 10 : 10,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 90,
                        child: AutoSizeText(
                          widget.consumerName,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: widget.imageUrl == ''
                            ? null
                            : CachedNetworkImageProvider(widget.imageUrl),
                        child: widget.imageUrl == ''
                            ? const Icon(
                                Icons.person,
                                size: 40,
                              )
                            : null,
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DescriptionValueWidget(
                        descrtiption: 'Valor',
                        value: 'R\$${widget.amount.toStringAsFixed(2)}',
                        descriptionSize: 100,
                      ),
                      const SizedBox(width: 10),
                      DescriptionValueWidget(
                        descrtiption: 'Valor Histórico',
                        value: 'R\$${widget.historicAmount.toStringAsFixed(2)}',
                        descriptionSize: 100,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DescriptionValueWidget(
                        descrtiption: 'Vencimento',
                        value: DateFormat('dd/MM/yyyy').format(widget.dueDate),
                        descriptionSize: 100,
                        valueColor: isDueToday ? AppColors.primaryRed : null,
                      ),
                      DescriptionValueWidget(
                        descrtiption: 'Juros',
                        value: 'R\$${widget.fees.toStringAsFixed(2)}',
                        descriptionSize: 100,
                      ),
                    ],
                  ),
                ],
              ),
              if (isDueToday) const SizedBox(height: 10),
              if (isDueToday)
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return CustomElevatedButton(
                      size: constraints.maxWidth,
                      icon: Icons.message,
                      label: 'Cobrar',
                      backgroundColor: AppColors.secoundaryBackground,
                      onPressed: () async {
                        await _loanController.sendMessage(
                          phoneNumber: widget.phoneNumber,
                          message: _homeController.creditorModel.message != null
                              ? DataManipulation.chargeMessage(
                                  consumerName: widget.consumerName,
                                  message:
                                      _homeController.creditorModel.message!,
                                )
                              : DataManipulation.defaultMessage(
                                  clientName: widget.consumerName,
                                  loanAmount: widget.amount,
                                  feeAmount: widget.fees,
                                  dueDate: DateFormat('dd/MM/yyyy')
                                      .format(widget.dueDate),
                                ),
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
