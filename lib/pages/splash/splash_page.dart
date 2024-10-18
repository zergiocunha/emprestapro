// ignore_for_file: type_literal_in_constant_pattern

import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/constants/routes.dart';
import 'package:emprestapro/common/extensions/sizes.dart';
import 'package:emprestapro/common/widgets/custom_modal_bottom_sheet.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';
import 'splash_controller.dart';
import 'splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with CustomModalSheetMixin {
  final _splashController = locator.get<SplashController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => Sizes.init(context));

    _splashController.isUserLogged();
    _splashController.addListener(_handleSplashStateChange);
  }

  @override
  void dispose() {
    _splashController.dispose();
    super.dispose();
  }

  void _handleSplashStateChange() {
    if (_splashController.state is AuthenticatedUser) {
      Navigator.pushNamedAndRemoveUntil(
          context,
          NamedRoute.home,
          (route) => false,
        );
    } else {
      Navigator.pushReplacementNamed(
        context,
        NamedRoute.signIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primaryGreen,
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: AppColors.primaryGreen,
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'financy',
              style: const TextStyle().copyWith(color: AppColors.primaryText),
            ),
            Text(
              'Syncing data...',
              style:const TextStyle().copyWith(color: AppColors.primaryText),
            ),
            const SizedBox(height: 16.0),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
