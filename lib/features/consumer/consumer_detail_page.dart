import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/utils/calculation.dart';
import 'package:emprestapro/common/widgets/description_value.dart';
import 'package:emprestapro/features/consumer/consumer_controller.dart';
import 'package:emprestapro/features/consumer/widgets/consumer_info_container.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsumerDetailPage extends StatefulWidget {
  final ConsumerModel consumer;

  const ConsumerDetailPage({
    super.key,
    required this.consumer,
  });

  @override
  State<ConsumerDetailPage> createState() => _ConsumerDetailPageState();
}

class _ConsumerDetailPageState extends State<ConsumerDetailPage> {
  final consumerController = locator.get<ConsumerController>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    consumerController.dispose();
    super.dispose();
  }

  void getData() async {
    await consumerController.getLoansByConsumer(widget.consumer);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.secoundaryBackground,
        elevation: 0,
        shadowColor: AppColors.secoundaryBackground,
        title: const Text(
          'Detalhes do Cliente',
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 280, bottom: 10),
              itemCount: consumerController.loans.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        NamedRoute.loanDetail,
                        arguments: consumerController.loans[index],
                      );
                    },
                    child: LoanContainer(
                      loan: consumerController.loans[index],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Colors.transparent,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(height: 16),
                ConsumerInfoContainer(
                  name: widget.consumer.name ?? 'Não informado',
                  phone: widget.consumer.phone,
                  email: widget.consumer.email,
                  pix: widget.consumer.pix,
                  status: widget.consumer.active == true ? 'Sim' : 'Não',
                  address: widget.consumer.address,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoanContainer extends StatelessWidget {
  final LoanModel loan;

  const LoanContainer({
    super.key,
    required this.loan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGreen3D,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        DescriptionValueRow(
                          descrtiption: 'Valor total',
                          value: 'R\$${loan.amount!.toStringAsFixed(2)}',
                        ),
                        DescriptionValueRow(
                          descrtiption: 'Juros',
                          value:
                              'R\$${Calculation.feesAmount(loan).toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        DescriptionValueRow(
                          descrtiption: 'Vencimento',
                          value: DateFormat('dd/MM/yyyy').format(loan.dueDate!),
                        ),
                        DescriptionValueRow(
                          descrtiption: 'Status',
                          value:
                              loan.concluded! ? 'Pago' : 'Pendente',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
