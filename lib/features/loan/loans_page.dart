import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/common/utils/calculation.dart';
import 'package:emprestapro/common/widgets/evolution_container.dart';
import 'package:emprestapro/common/widgets/loan_container.dart';
import 'package:emprestapro/common/widgets/loans_information_container.dart';
import 'package:emprestapro/features/home/home_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoansPage extends StatefulWidget {
  const LoansPage({super.key});

  @override
  State<LoansPage> createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage>
    with SingleTickerProviderStateMixin {
  final _addLoanController = locator.get<HomeController>();

  @override
  void initState() {
    super.initState();
  }

  double evolutionCalc(double amountCredit, double amountDividend) {
    return (amountDividend / amountCredit) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final List<LoanModel> loans = _addLoanController.loans;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
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
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 160, bottom: 10),
              itemCount: loans.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LoanContainer(
                    consumerName: loans[index].consumerId ?? '',
                    amount: loans[index].amount ?? 0,
                    fees: Calculation.feesAmount(loans[index]),
                    secondaryName: 'secondaryName',
                    dueDate: loans[index].dueDate!,
                    imageUrl:
                        'https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=',
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
                LoansInformationContainers(
                  amountCredit: Calculation.totalBorrowed(loans),
                  lastLoanDate: Calculation.nextToDueDate(loans)!,
                  amountDividend: Calculation.minimumFeesToReceive(loans),
                  evolution: evolutionCalc(
                    Calculation.totalBorrowed(loans),
                    Calculation.minimumFeesToReceive(loans),
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

class LoansInformationContainers extends StatelessWidget {
  const LoansInformationContainers({
    super.key,
    required this.amountCredit,
    required this.lastLoanDate,
    required this.amountDividend,
    required this.evolution,
  });

  final double amountCredit;
  final double amountDividend;
  final DateTime lastLoanDate;
  final double evolution;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LoansInformationContainer(
          containerName: 'Crédito',
          amount: amountCredit,
          secondaryName: 'Último',
          secondaryInformation: DateFormat('dd/MM/yyyy').format(lastLoanDate),
        ),
        LoansInformationContainer(
          containerName: 'Dividendo',
          amount: amountDividend,
          amountColor: amountDividend >= 0
              ? AppColors.primaryGreen
              : AppColors.primaryRed,
          secondaryName: 'Evolução',
          secondaryWidget: EvolutionContainer(
            value: evolution,
          ),
        ),
      ],
    );
  }
}
