import 'dart:developer';

import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: FloatingActionButton(
        backgroundColor: AppColors.primaryGreen,
        onPressed: () async {
          log('FOI');
        },
        shape: const CircleBorder(),
        child: PopupMenuButton(
          offset: const Offset(0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: AppColors.background,
          elevation: 10,
          child: const Icon(
            Icons.add,
            size: 37.5,
            color: AppColors.primaryText,
          ),
          itemBuilder: (_) => <PopupMenuEntry>[
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(
                  Icons.monetization_on_outlined,
                  color: AppColors.primaryText,
                ),
                title: const Text(
                  'Empréstimo',
                  style: TextStyle(color: AppColors.primaryText),
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  NamedRoute.addLoan,
                ),
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: AppColors.primaryText,
                ),
                title: const Text(
                  'Cliente',
                  style: TextStyle(color: AppColors.primaryText),
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  NamedRoute.addConsumer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
