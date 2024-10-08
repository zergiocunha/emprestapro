import 'package:emprestapro/common/constants/app_collors.dart';
import 'package:emprestapro/common/widgets/custom_bottom_app_bar.dart';
import 'package:emprestapro/common/widgets/custom_floating_action_button.dart';
import 'package:emprestapro/features/consumer/consumers_page.dart';
import 'package:emprestapro/features/home/home_controller.dart';
import 'package:emprestapro/features/home/home_page.dart';
import 'package:emprestapro/features/loan/loans_page.dart';
import 'package:emprestapro/features/profile/profile_page.dart';
import 'package:emprestapro/locator.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final homeController = locator.get<HomeController>();

  @override
  void initState() {
    homeController.setPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    locator.resetLazySingleton<HomeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: homeController.pageController,
        children: const [
          HomePage(),
          LoansPage(),
          ConsumersPage(),
          ProfilePage(),
        ],
      ),
      // Remove o floatingActionButton, pois você indicou que não quer usá-lo
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: CustomBottomAppBar(
        controller: homeController.pageController,
        selectedItemColor: AppColors.primaryGreen,
        children: [
          CustomBottomAppBarItem(
            label: 'home',
            primaryIcon: Icons.home,
            secondaryIcon: Icons.home_outlined,
            onPressed: () => homeController.pageController.jumpToPage(0),
          ),
          CustomBottomAppBarItem(
            label: 'loans',
            primaryIcon: Icons.request_page,
            secondaryIcon: Icons.request_page_outlined,
            onPressed: () => homeController.pageController.jumpToPage(1),
          ),
          CustomBottomAppBarItem.empty(),
          CustomBottomAppBarItem(
            label: 'consumers',
            primaryIcon: Icons.people,
            secondaryIcon: Icons.people_outline,
            onPressed: () => homeController.pageController.jumpToPage(2),
          ),
          CustomBottomAppBarItem(
            label: 'profile',
            primaryIcon: Icons.person,
            secondaryIcon: Icons.person_2_outlined,
            onPressed: () => homeController.pageController.jumpToPage(3),
          ),
        ],
      ),
    );
  }
}
