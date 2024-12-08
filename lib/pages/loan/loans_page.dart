// ignore_for_file: constant_pattern_never_matches_value_type

import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/enums/loan_filter.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/extensions/loan_filter_ext.dart';
import 'package:emprestapro/common/models/consumer_model.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/utils/calculation.dart';
import 'package:emprestapro/common/utils/validator.dart';
import 'package:emprestapro/common/widgets/custom_circular_button.dart';
import 'package:emprestapro/common/widgets/custom_elevated_button.dart';
import 'package:emprestapro/common/widgets/custom_modal_bottom_sheet.dart';
import 'package:emprestapro/pages/loan/loan_controller.dart';
import 'package:emprestapro/pages/loan/widgets/evolution_container.dart';
import 'package:emprestapro/pages/loan/widgets/loan_container.dart';
import 'package:emprestapro/pages/loan/widgets/loans_information_container.dart';
import 'package:emprestapro/pages/home/home_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';

class LoansPage extends StatefulWidget {
  const LoansPage({super.key});

  @override
  State<LoansPage> createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage>
    with SingleTickerProviderStateMixin, CustomModalSheetMixin {
  final _homeController = locator.get<HomeController>();
  final _loanController = locator.get<LoanController>();
  LoanFilter? selectedFilter = locator.get<HomeController>().filterOnlyOverdue
      ? LoanFilter.values[2]
      : LoanFilter.values[1];

  bool? confirmDelete = false;

  @override
  void initState() {
    super.initState();
  }

  double evolutionCalc(double amountCredit, double amountDividend) {
    return (amountCredit == 0 && amountDividend == 0)
        ? 0
        : (amountDividend / amountCredit) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final List<LoanModel> loans = _homeController.loans;
    final List<ConsumerModel> consumers = _homeController.consumers;

    List<LoanModel> filteredLoans = loans.where((loan) {
      switch (selectedFilter) {
        case LoanFilter.all:
          _homeController.setFilterOnlyOverdue(false);
          return true;
        case LoanFilter.concluded:
          _homeController.setFilterOnlyOverdue(false);
          return loan.concluded == true;
        case LoanFilter.notConcluded:
          _homeController.setFilterOnlyOverdue(false);
          return loan.concluded == false;
        case LoanFilter.overdue:
          _homeController.setFilterOnlyOverdue(false);
          return loan.dueDate != null &&
              Validator.isDueTodayOrPast(loan.dueDate!, loan.concluded!);
        default:
          _homeController.setFilterOnlyOverdue(false);
          return true;
      }
    }).toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secoundaryBackground,
        elevation: 0,
        shadowColor: AppColors.secoundaryBackground,
        title: const Text(
          'Empréstimos',
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: DropdownButton<LoanFilter>(
              icon: const Icon(Icons.filter_list, color: AppColors.primaryText),
              value: selectedFilter,
              dropdownColor: AppColors.secoundaryBackground,
              items: LoanFilter.values
                  .map<DropdownMenuItem<LoanFilter>>((LoanFilter value) {
                return DropdownMenuItem<LoanFilter>(
                  value: value,
                  child: Text(
                    value.description,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (LoanFilter? newValue) {
                setState(() {
                  selectedFilter = newValue;
                });
              },
            ),
          )
        ],
        centerTitle: false,
      ),
      body: StreamBuilder<HomeController>(
        stream: null,
        builder: (context, snapshot) {
          return Stack(
            children: [
              Positioned.fill(
                bottom: 50,
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 160, bottom: 10),
                  itemCount: filteredLoans.length,
                  itemBuilder: (BuildContext context, int index) {
                    String consumerId = filteredLoans[index].consumerId ?? '';
                    ConsumerModel consumerName = consumers.firstWhere(
                      (consumer) => consumer.uid == consumerId,
                      orElse: () => ConsumerModel(name: 'Desconhecido'),
                    );
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Dismissible(
                        dismissThresholds: const {
                          DismissDirection.endToStart: 0.5
                        },
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          if (confirmDelete!) {
                            await _loanController.deleteLoanAndTransactions(
                              loan: filteredLoans[index],
                            );
                            setState(() {});
                          }
                        },
                        confirmDismiss: (direction) async {
                          confirmDelete = await showCustomModalBottomSheet(
                            context: context,
                            content:
                                'Deseja realmente excluir este empréstimo?',
                            actions: [
                              Flexible(
                                child: CustomElevatedButton(
                                  backgroundColor:
                                      AppColors.secoundaryBackground,
                                  label: 'Cancelar',
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Flexible(
                                child: CustomElevatedButton(
                                  label: 'Confirmar',
                                  backgroundColor: AppColors.primaryRed,
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
                        key: UniqueKey(),
                        background: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryRed,
                                AppColors.secondaryRed,
                                Colors.transparent,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 0.5, 1.0],
                            ),
                          ),
                          constraints: const BoxConstraints(minHeight: 10),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: consumerName.phone == null
                            ? Container()
                            : LoanContainer(
                                consumerName: consumerName.name ?? '',
                                amount: filteredLoans[index].amount ?? 0,
                                historicAmount:
                                    filteredLoans[index].initialAmount ?? 0,
                                fees: Calculation.feesAmount(
                                    filteredLoans[index]),
                                secondaryName: 'secondaryName',
                                dueDate: filteredLoans[index].dueDate!,
                                imageUrl: consumerName.photoURL ?? '',
                                concluded: filteredLoans[index].concluded!,
                                phoneNumber: consumerName.phone!,
                                onPressed: () async {
                                  await Navigator.pushNamed(
                                    context,
                                    NamedRoute.loanDetail,
                                    arguments: filteredLoans[index],
                                  );
                                }),
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
                    Column(
                      children: [
                        LoansInformationContainers(
                          historicCredit: Calculation.totalBorrowed(
                              loans: filteredLoans, historic: true),
                          lastLoanDate: filteredLoans.isNotEmpty
                              ? Calculation.nextToDueDate(filteredLoans)!
                              : null,
                          amountDividend: Calculation.minimumFeesToReceive(
                              loans: filteredLoans),
                          credit:
                              Calculation.totalBorrowed(loans: filteredLoans),
                          evolutionInitial: evolutionCalc(
                            Calculation.totalBorrowed(loans: filteredLoans),
                            Calculation.minimumFeesToReceive(
                                loans: filteredLoans),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: CustomCircularButton(
                  icon: Icons.add,
                  label: 'Adicionar Empréstimo',
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      NamedRoute.addLoan,
                    );
                    setState(() {});
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

class LoansInformationContainers extends StatelessWidget {
  const LoansInformationContainers({
    super.key,
    required this.historicCredit,
    this.lastLoanDate,
    required this.amountDividend,
    required this.credit,
    required this.evolutionInitial,
  });

  final double historicCredit;
  final double amountDividend;
  final double credit;
  final DateTime? lastLoanDate;
  final double evolutionInitial;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LoansInformationContainer(
            containerName: 'Crédito Histórico',
            amount: historicCredit,
            secondaryName: 'Crédito em Mercado',
            secondaryInformation: 'R\$${credit.toStringAsFixed(2)}'),
        LoansInformationContainer(
          containerName: 'Dividendo',
          amount: amountDividend,
          amountColor: amountDividend >= 0
              ? AppColors.primaryGreen
              : AppColors.primaryRed,
          secondaryName: 'Evolução',
          secondaryWidget: EvolutionContainer(
            value: evolutionInitial,
          ),
        ),
      ],
    );
  }
}
