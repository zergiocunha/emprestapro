import 'package:emprestapro/common/models/loan_model.dart';
import 'package:emprestapro/features/consumer/consumer_state.dart';
import 'package:emprestapro/repositories/consumer_repository.dart';
import 'package:emprestapro/repositories/loan_repository.dart';
import 'package:flutter/material.dart';
import 'package:emprestapro/common/models/consumer_model.dart';

class ConsumerController extends ChangeNotifier {
  final ConsumerRepository consumerRepository;
  final LoanRepository loanRepository;

  ConsumerController({
    required this.consumerRepository,
    required this.loanRepository,
  });

  ConsumerState _state = ConsumerInitialState();
  ConsumerState get state => _state;

  List<LoanModel> _loans = [];
  List<LoanModel> get loans => _loans;


  void _changeState(ConsumerState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> addConsumer({
    required ConsumerModel newConsumer,
  }) async {
    _changeState(ConsumerLoadingState());

    final result = await consumerRepository.insert(consumerModel: newConsumer);

    result.fold(
      (error) => _changeState(ConsumerErrorState(message: error.message)),
      (transaction) {
        _changeState(ConsumerSuccessState());
      },
    );
    notifyListeners();
  }

  Future<void> getLoansByConsumer(ConsumerModel consumer) async {
    _changeState(ConsumerLoadingState());

    final result = await loanRepository.get(
      fieldName: 'consumerId',
      value: consumer.uid!,
    );

    result.fold(
        (error) => _changeState(ConsumerErrorState(message: error.message)),
        (data) {
      _loans = data;
      _changeState(ConsumerSuccessState());
    });
  }
}
