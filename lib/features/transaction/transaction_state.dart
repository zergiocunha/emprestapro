abstract class TransactionState {}

class TransactionInitialState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionSuccessState extends TransactionState {}

class TransactionErrorState extends TransactionState {
  final String message;

  TransactionErrorState({required this.message});
}
