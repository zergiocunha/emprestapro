import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/utils/calculation.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_modal_bottom_sheet.dart';
import 'package:emprestapro/common/widgets/description_value.dart';
import 'package:emprestapro/features/consumer/consumer_controller.dart';
import 'package:emprestapro/features/consumer/widgets/consumer_info_container.dart';
import 'package:emprestapro/features/loan/loan_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsumerDetailsPage extends StatefulWidget {
  final ConsumerModel consumer;

  const ConsumerDetailsPage({
    super.key,
    required this.consumer,
  });

  @override
  State<ConsumerDetailsPage> createState() => _ConsumerDetailsPageState();
}

class _ConsumerDetailsPageState extends State<ConsumerDetailsPage>
    with CustomModalSheetMixin {
  final consumerController = locator.get<ConsumerController>();
  final loanController = locator.get<LoanController>();
  bool? confirmDelete = false;

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
              padding: const EdgeInsets.only(top: 330, bottom: 10),
              itemCount: consumerController.loans.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Dismissible(
                    key: UniqueKey(),
                    dismissThresholds: const {DismissDirection.endToStart: 0.5},
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      if (confirmDelete!) {
                        loanController.deleteLoanAndTransactions(
                            loan: consumerController.loans[index]);
                        setState(() {
                          consumerController.loans.removeAt(index);
                        });
                      }
                    },
                    confirmDismiss: (direction) async {
                      confirmDelete = await showCustomModalBottomSheet(
                        context: context,
                        content: 'Confirmar exclusão do empréstimo?',
                        actions: [
                          Flexible(
                            child: CustomElevatedButton(
                              label: 'Cancelar',
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Flexible(
                            child: CustomElevatedButton(
                              label: 'Confirmar',
                              onPressed: () {
                                if (mounted) {
                                  Navigator.pop(context, true);
                                }
                              },
                            ),
                          ),
                        ],
                      );

                      return confirmDelete;
                    },
                    child: LoanContainer(
                      loan: consumerController.loans[index],
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          NamedRoute.loanDetail,
                          arguments: consumerController.loans[index],
                        );
                      },
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
                  imageUrl: widget.consumer.photoURL ?? '',
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
  final VoidCallback? onTap;

  const LoanContainer({
    super.key,
    required this.loan,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                          DescriptionValueWidget(
                            descrtiption: 'Valor total',
                            value: 'R\$${loan.amount!.toStringAsFixed(2)}',
                          ),
                          DescriptionValueWidget(
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
                          DescriptionValueWidget(
                            descrtiption: 'Vencimento',
                            value:
                                DateFormat('dd/MM/yyyy').format(loan.dueDate!),
                          ),
                          DescriptionValueWidget(
                            descrtiption: 'Status',
                            value: loan.concluded! ? 'Pago' : 'Pendente',
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
      ),
    );
  }
}
