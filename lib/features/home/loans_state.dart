abstract class LoansState {}

class LoansInitialState extends LoansState {}

class LoansLoadingState extends LoansState {}

class LoansSuccessState extends LoansState {}

class LoansErrorState extends LoansState {
  LoansErrorState({
    required this.message,
  });

  final String message;
}
