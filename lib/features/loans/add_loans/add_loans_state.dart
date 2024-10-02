abstract class AddLoansState {}

class AddLoansInitialState extends AddLoansState {}

class AddLoansLoadingState extends AddLoansState {}

class AddLoansSuccessState extends AddLoansState {}

class AddLoansErrorState extends AddLoansState {
  AddLoansErrorState({
    required this.message,
  });

  final String message;
}
