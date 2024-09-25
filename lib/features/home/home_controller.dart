import 'package:emprestapro/features/home/home_state.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeController();

  final HomeState _state = HomeInitialState();
  final ValueNotifier<bool> showFloatingButton = ValueNotifier<bool>(true);

  HomeState get state => _state;

  late PageController _pageController;
  PageController get pageController => _pageController;

  set setPageController(PageController newPageController) {
    _pageController = newPageController;
  }

  void jumpToWalletPage() {
    pageController.jumpToPage(2);
    showFloatingButton.value = false;
  }
}
