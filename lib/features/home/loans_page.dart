import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/widgets/evolution_container.dart';
import 'package:emprestapro/common/widgets/loan_container.dart';
import 'package:emprestapro/common/widgets/loans_information_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoansPage extends StatefulWidget {
  const LoansPage({super.key});

  @override
  State<LoansPage> createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double amountCredit = 12583;
    const double amountDividend = 1885.45;
    const double evolution = (amountDividend / amountCredit) * 100;
    final DateTime lastLoanDate = DateTime.now();
    final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G'];

    return Scaffold(
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
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LoanContainer(
                    debtorName: 'José do Egito',
                    amount: amountCredit,
                    secondaryName: 'secondaryName',
                    dueDate: lastLoanDate,
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
                  amountCredit: amountCredit,
                  lastLoanDate: lastLoanDate,
                  amountDividend: amountCredit,
                  evolution: evolution,
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
          amountColor:
              amountCredit > 0 ? AppColors.primaryGreen : AppColors.primaryRed,
          secondaryName: 'Evolução',
          secondaryWidget: EvolutionContainer(
            value: evolution,
          ),
        ),
      ],
    );
  }
}
