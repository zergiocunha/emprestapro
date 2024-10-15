import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/features/home/home_controller.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';

class AlertContiner extends StatelessWidget {
  const AlertContiner({
    super.key,
    required this.alertCount,
  });

  final int alertCount;

  @override
  Widget build(BuildContext context) {
  final homeController = locator.get<HomeController>();

    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.secondaryRed3D,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.notifications,
                            color: AppColors.primaryText,
                            size: 32,
                          ),
                          Text(
                            alertCount > 1 ? '$alertCount Alertas de Vencimento' : '$alertCount Alerta de Vencimento',
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      homeController.setFilterOnlyOverdue(true);
                      homeController.jumpToLoansPage();
                    },
                    child: const Text(
                      'Ver',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}