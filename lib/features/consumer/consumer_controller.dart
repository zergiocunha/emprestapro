import 'package:emprestapro/features/consumer/consumer_state.dart';
import 'package:emprestapro/repositories/consumer_repository.dart';
import 'package:flutter/material.dart';
import 'package:emprestapro/common/models/consumer_model.dart';

class ConsumerController extends ChangeNotifier {
  final ConsumerRepository consumerRepository;

  ConsumerController({
    required this.consumerRepository,
  });

  ConsumerState _state = ConsumerInitialState();
  ConsumerState get state => _state;

  void _changeState(ConsumerState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> addConsumer({
    required ConsumerModel newConsumer,
  }) async {
    _changeState(ConsumerLoadingState());

    final result =
        await consumerRepository.insert(consumerModel: newConsumer);

    result.fold(
      (error) => _changeState(ConsumerErrorState(message: error.message)),
      (transaction) {
        _changeState(ConsumerSuccessState());
      },
    );
    notifyListeners();
  }
}
