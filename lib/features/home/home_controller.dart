import 'package:emprestapro/features/home/home_state.dart';
import 'package:emprestapro/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  HomeState _state = HomeInitialState();
  final ValueNotifier<bool> showFloatingButton = ValueNotifier<bool>(true);

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

  Future<void> getUserData() async {
    // _userRepository.get();
  }
}
