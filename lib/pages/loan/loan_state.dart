abstract class LoanState {}

class LoanInitialState extends LoanState {}

class AddLoansLoadingState extends LoanState {}

class AddLoansSuccessState extends LoanState {}

class AddLoansErrorState extends LoanState {
  AddLoansErrorState({
    required this.message,
  });

  final String message;
}
