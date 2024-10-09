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
          color: AppColors.background,
          itemBuilder: (context) => [
            PopupMenuItem(
              height: 24,
              child: const Text(
                'Empréstimo',
                style: TextStyle(
                  color: AppColors.primaryText,
                ),
              ),
              onTap: () => Navigator.pushNamed(
                context,
                NamedRoute.addLoan,
              ),
            ),
            PopupMenuItem(
              height: 24,
              child: const Text(
                'Cliente',
                style: TextStyle(
                  color: AppColors.primaryText,
                ),
              ),
              onTap: () => Navigator.pushNamed(
                context,
                NamedRoute.addConsumer,
              ),
            ),
          ],
          child: const Icon(
            Icons.add,
            size: 37.5,
            color: AppColors.primaryText,
          ),
        ),
      ),
    );
  }
}
