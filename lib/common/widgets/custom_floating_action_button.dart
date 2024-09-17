import 'dart:developer';

import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: FloatingActionButton(
        backgroundColor: AppColors.primaryGreen,
        onPressed: () async {
          log('FOI');
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 37.5,
          color: AppColors.primaryText,
        ),
      ),
    );
  }
}
