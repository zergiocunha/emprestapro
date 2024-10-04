import 'package:auto_size_text/auto_size_text.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class AlertContiner extends StatelessWidget {
  const AlertContiner({
    super.key,
    required this.alertCount,
    required this.alertDescription,
  });

  final int alertCount;
  final String alertDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        // color: AppColors.secoundaryRed,
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
                  const Text(
                    'Ver',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                SizedBox(
                  width: 340,
                  child: AutoSizeText(
                    alertDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}