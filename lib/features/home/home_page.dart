import 'package:cached_network_image/cached_network_image.dart';
import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/features/home/widgets/home_info_container.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const String displayName = 'Sergio Cunha';
    const String dueDateTitle = 'Payroll Due';
    const String debitTitle = 'Debit Date';
    const String dueDate = 'Aug 31, 2021';
    const double dueAmount = 122450.00;
    const int daysLeft = 4;
    const String photoUrl =
        'https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=';

    return Scaffold(
      backgroundColor: AppColors.secoundaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.secoundaryBackground,
        title: const Text(
          'Home',
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(
                            photoUrl,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Bem vindo, ',
                                    style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    displayName,
                                    style: TextStyle(
                                      color: AppColors.primaryGreen,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Os detalhes da sua conta estão abaixo',
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Total de Emprestado',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'R\$25202.23',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.normal,
                            fontSize: 32,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            const Row(
              children: [
                HomeInfoContainer(
                  dueDateTitle: dueDateTitle,
                  dueAmount: dueAmount,
                  debitTitle: debitTitle,
                  dueDate: dueDate,
                  daysLeft: daysLeft,
                ),
                SizedBox(
                  width: 16,
                ),
                HomeInfoContainer(
                  dueDateTitle: dueDateTitle,
                  dueAmount: dueAmount,
                  debitTitle: debitTitle,
                  dueDate: dueDate,
                  daysLeft: daysLeft,
                  containerColor: AppColors.secundaryGreen,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
