import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/widgets/custom_bottom_app_bar.dart';
import 'package:emprestapro/features/home/home_controller.dart';
import 'package:emprestapro/features/home/loans_page.dart';
import 'package:emprestapro/features/sign_in/sign_in_page.dart';
import 'package:emprestapro/features/sign_up/sign_up_page.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final homeController = locator.get<LoansController>();

  @override
  void initState() {
    homeController.setPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    locator.resetLazySingleton<LoansController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: homeController.pageController,
        children: const [
          LoansPage(),
          SignUpPage(),
          SignInPage(),
        ],
      ),
      // floatingActionButton: const CustomFloatingActionButton(),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: CustomBottomAppBar(
        controller: homeController.pageController,
        selectedItemColor: AppColors.primaryGreen,
        children: [
          CustomBottomAppBarItem(
            label: 'home',
            primaryIcon: Icons.home,
            secondaryIcon: Icons.home_outlined,
            onPressed: () => homeController.pageController.jumpToPage(
              0,
            ),
          ),
          CustomBottomAppBarItem(
            label: 'profile',
            primaryIcon: Icons.person,
            secondaryIcon: Icons.person_outline,
            onPressed: () => homeController.pageController.jumpToPage(
              3,
            ),
          ),
        ],
      ),
    );
  }
}
