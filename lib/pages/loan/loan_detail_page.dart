import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/models/transaction_model.dart';
import 'package:emprestapro/common/utils/calculation.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_modal_bottom_sheet.dart';
import 'package:emprestapro/pages/loan/widgets/loans_information_container.dart';
import 'package:emprestapro/pages/transaction/transaction_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:emprestapro/pages/home/home_controller.dart';

class LoanDetailPage extends StatefulWidget {
  final LoanModel loan;

  const LoanDetailPage({super.key, required this.loan});

  @override
  State<LoanDetailPage> createState() => _LoanDetailPageState();
}

class _LoanDetailPageState extends State<LoanDetailPage>
    with CustomModalSheetMixin {
  final _transactionController = locator.get<TransactionController>();
  final _homeController = locator.get<HomeController>();
  bool? confirmDelete = false;
  List<TransactionModel> transactions = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    _transactionController.dispose();
    super.dispose();
  }

  void getData() async {
    if (mounted) {
      setState(() {
        transactions = _homeController.transactons
            .where((transaction) => transaction.loanId == widget.loan.uid)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                NamedRoute.addLoan,
                arguments: widget.loan,
              );
            },
            child: const Icon(
              Icons.edit,
              color: AppColors.primaryText,
              size: 30,
            ),
          ),
          const SizedBox(width: 20),
        ],
        backgroundColor: AppColors.secoundaryBackground,
        elevation: 0,
        shadowColor: AppColors.secoundaryBackground,
        title: const Text(
          'Detalhes do Empréstimo',
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LoanSummary(
              loan: widget.loan,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 10),
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Dismissible(
                    key: UniqueKey(),
                    dismissThresholds: const {DismissDirection.endToStart: 0.5},
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      if (confirmDelete!) {
                        _transactionController.deleteTransaction(
                          transactionModel: transactions[index],
                        );
                        setState(() {});
                      }
                    },
                    confirmDismiss: (direction) async {
                      confirmDelete = await showCustomModalBottomSheet(
                        context: context,
                        content: 'Confirm delete transaction',
                        actions: [
                          Flexible(
                            child: CustomElevatedButton(
                              label: 'Cancel',
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Flexible(
                            child: CustomElevatedButton(
                              label: 'Confirm',
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
                    child: TransactionContainer(
                      loan: widget.loan,
                      transaction: transactions[index],
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
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                NamedRoute.addTransaction,
                arguments: {'loan': widget.loan},
              ).then((success) {
                if (success == true) {
                  Navigator.pop(context);
                  _homeController.jumpToHomePage();
                }
              });
            },
            icon: const Icon(Icons.add),
            label: const Text('Adicionar Transação'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: AppColors.primaryText,
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class LoanSummary extends StatelessWidget {
  final LoanModel loan;

  const LoanSummary({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LoansInformationContainer(
          containerName: 'Crédito',
          amount: loan.amount!,
          secondaryName: 'Data de Vencimento',
          secondaryInformation: DateFormat('dd/MM/yyyy').format(loan.dueDate!),
        ),
        LoansInformationContainer(
          containerName: 'Juros',
          amount: Calculation.feesAmount(loan),
          amountColor: AppColors.primaryGreen,
          secondaryName: 'Status',
          secondaryInformation: loan.concluded! ? 'Pago' : 'Pendente',
        ),
      ],
    );
  }
}

class TransactionContainer extends StatelessWidget {
  final TransactionModel transaction;
  final LoanModel loan;

  const TransactionContainer({
    super.key,
    required this.transaction,
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
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data: ${DateFormat('dd/MM/yyyy').format(transaction.transactionTime!)}',
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Valor: R\$${transaction.amount!.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    NamedRoute.addTransaction,
                    arguments: {
                      'loan': loan,
                      'transaction': transaction,
                    },
                  );
                },
                child: const Icon(
                  Icons.edit,
                  color: AppColors.primaryText,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
