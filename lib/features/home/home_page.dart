import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/features/home/home_controller.dart';
import 'package:emprestapro/features/home/widgets/alert_container.dart';
import 'package:emprestapro/features/home/widgets/home_app_bar.dart';
import 'package:emprestapro/features/home/widgets/home_info_container.dart';
import 'package:emprestapro/features/home/widgets/quick_service_container.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = locator.get<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String displayName = 'Sergio Cunha';
    const String lastReceiptDate = 'Aug 31, 2021';
    const String nextReceiptDate = 'Sep 20, 2024';
    const double loanReceived = 12450.00;
    const double loanReceivable = 3345.00;
    const int daysLeft = 4;
    const String photoUrl =
        'https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=';
    const int alertCount = 1;
    const String alertDescription =
        'We noticed a small charge that is out of character of this account, please review';
    const double amount = 25202.23;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        children: [
          const HomeAppBar(
            photoUrl: photoUrl,
            displayName: displayName,
            amount: amount,
          ),
          if (alertCount > 0)
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: AlertContiner(
                alertCount: alertCount,
                alertDescription: alertDescription,
              ),
            ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              children: [
                HomeInfoContainer(
                  dueDateTitle: 'Total Juros Recebido',
                  dueAmount: loanReceived,
                  debitTitle: 'Data do Último',
                  dueDate: lastReceiptDate,
                  daysLeft: 0,
                ),
                SizedBox(
                  width: 16,
                ),
                HomeInfoContainer(
                  dueDateTitle: 'Total Juros a Receber',
                  dueAmount: loanReceivable,
                  debitTitle: 'Data do Próximo',
                  dueDate: nextReceiptDate,
                  daysLeft: daysLeft,
                  containerColor: AppColors.secundaryGreen,
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
                          quickContainerIcon: Icons.account_balance_wallet,
                          quickContainerTitle1: 'Emrpréstimos',
                          onTap: (){},
                        ),
                        const SizedBox(width: 16),
                        QuickServiceContainer(
                          quickContainerIcon: Icons.add_circle_outline,
                          quickContainerTitle1: 'Novo',
                          onTap: (){},
                        ),
                        const SizedBox(width: 16),
                        QuickServiceContainer(
                          quickContainerIcon: Icons.show_chart,
                          quickContainerTitle1: 'Progresso',
                          onTap: (){},
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
                          quickContainerIcon: Icons.add_shopping_cart,
                          quickContainerTitle1: 'Nova',
                          onTap: (){},
                        ),
                        const SizedBox(width: 16),
                        QuickServiceContainer(
                          quickContainerIcon: Icons.receipt_long,
                          quickContainerTitle1: 'Histórico',
                          onTap: (){},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}