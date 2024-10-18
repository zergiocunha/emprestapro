import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/utils/calculation.dart';
import 'package:emprestapro/common/utils/data_manipulation.dart';
import 'package:emprestapro/pages/home/home_controller.dart';
import 'package:emprestapro/pages/home/widgets/alert_container.dart';
import 'package:emprestapro/pages/home/widgets/home_app_bar.dart';
import 'package:emprestapro/pages/home/widgets/home_info_container.dart';
import 'package:emprestapro/pages/home/widgets/quick_service_container.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = locator.get<HomeController>();

  Future<void> getDatas() async {
    await homeController.getUser();
    await homeController.getCreditor();
    await homeController.getLoansByCreditor();
    await homeController.getConsumersByCreditor();
    await homeController.getTransactionsByCreditor();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDatas();
  }

  @override
  Widget build(BuildContext context) {
    final nextToDueDate = homeController.loans.isNotEmpty
        ? Calculation.nextToDueDate(homeController.loans)
        : null;
    int alertCount = homeController.loans.isNotEmpty
        ? homeController.loans
            .where((x) =>
                (x.dueDate!.isBefore(DateTime.now()) ||
                    x.dueDate! == DateTime.now()) &&
                !x.concluded!)
            .toList()
            .length
        : 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 16),
            child: HomeAppBar(
              photoUrl: homeController.creditorModel.photoURL ?? '',
              displayName: homeController.creditorModel.name ?? '',
              amount: Calculation.totalBorrowed(homeController.loans),
            ),
          ),
          if (alertCount > 0)
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 16),
              child: AlertContiner(
                alertCount: alertCount,
              ),
            ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              children: [
                HomeInfoContainer(
                  dueDateTitle: 'Total Juros Recebido',
                  dueAmount: Calculation.sumTotalTransactionsAmount(
                      homeController.transactons)!,
                  debitTitle: 'Data do Último',
                  dueDate: homeController.transactons.isEmpty
                      ? ''
                      : DateFormat('dd/MM/yyyy').format(
                          DataManipulation.sortByDueDateDescending(
                            homeController.transactons,
                          ).first.transactionTime,
                        ),
                  daysLeft: 0,
                ),
                const SizedBox(
                  width: 16,
                ),
                HomeInfoContainer(
                  dueDateTitle: 'Juros Mínimo a Receber',
                  dueAmount:
                      Calculation.minimumFeesToReceive(homeController.loans),
                  debitTitle: 'Data do Próximo',
                  dueDate: nextToDueDate != null
                      ? DateFormat('dd/MM/yyyy').format(nextToDueDate)
                      : '',
                  daysLeft: nextToDueDate != null
                      ? nextToDueDate.difference(DateTime.now()).inDays
                      : 0,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secoundaryBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Serviços de Empréstimo',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuickServiceContainer(
                          quickContainerIcon: Icons.reorder,
                          quickContainerTitle1: 'Empréstimos',
                          onTap: () {
                            homeController.jumpToLoansPage();
                          },
                        ),
                        const SizedBox(width: 16),
                        QuickServiceContainer(
                          quickContainerIcon: Icons.show_chart,
                          quickContainerTitle1: 'Progresso',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secoundaryBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Serviços de Transação',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuickServiceContainer(
                          quickContainerIcon: Icons.receipt_long,
                          quickContainerTitle1: 'Histórico',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secoundaryBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Serviços de Cliente',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuickServiceContainer(
                          quickContainerIcon: Icons.people,
                          quickContainerTitle1: 'Clientes',
                          onTap: () {
                            homeController.jumpToConsumersPage();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
