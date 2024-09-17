import 'package:emprestapro/features/home/loans_state.dart';
import 'package:flutter/material.dart';

class LoansController extends ChangeNotifier {
  LoansController();

  LoansState _state = LoansInitialState();

  LoansState get state => _state;

  late PageController _pageController;
  PageController get pageController => _pageController;

  set setPageController(PageController newPageController) {
    _pageController = newPageController;
  }

  void _changeState(LoansState newState) {
    _state = newState;
    notifyListeners();
  }
}
