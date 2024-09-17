import 'package:emprestapro/features/home/home_state.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeController();

  HomeState _state = HomeInitialState();

  HomeState get state => _state;

  late PageController _pageController;
  PageController get pageController => _pageController;

  set setPageController(PageController newPageController) {
    _pageController = newPageController;
  }

  void _changeState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }
}
