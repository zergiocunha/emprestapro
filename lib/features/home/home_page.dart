import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/widgets/evolution_container.dart';
import 'package:emprestapro/common/widgets/loan_container.dart';
import 'package:emprestapro/common/widgets/loans_information_container.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double amount = 12.402;
    final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G'];
    final List<int> colorCodes = <int>[600, 500, 100, 200, 300, 400, 50];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 45,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            const Text(
              'Empréstimos',
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LoansInformationContainer(
                  containerName: 'Crédito',
                  amount: 12.402,
                  secondaryName: 'Último',
                  secondaryInformation: '07/06/2024',
                ),
                const SizedBox(width: 16),
                LoansInformationContainer(
                  containerName: 'Dividendo',
                  amount: amount,
                  amountColor: amount > 0
                      ? AppColors.primaryGreen
                      : AppColors.primaryRed,
                  secondaryName: 'Evolução',
                  secondaryWidget: EvolutionContainer(
                    value: amount,
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                // padding: const EdgeInsets.only(),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return LoanContainer(
                    containerName: 'Nome',
                    amount: amount,
                    secondaryName: 'secondaryName',
                    secondaryInformation: 'informetion',
                  );
                  // return Container(
                  //   height: 50,
                  //   color: Colors.amber[colorCodes[index]],
                  //   child: Center(child: Text('Entry ${entries[index]}')),
                  // );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
