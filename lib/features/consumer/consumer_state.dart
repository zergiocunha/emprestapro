abstract class ConsumerState {}

class ConsumerInitialState extends ConsumerState {}

class ConsumerLoadingState extends ConsumerState {}

class ConsumerSuccessState extends ConsumerState {}

class ConsumerErrorState extends ConsumerState {
  final String message;

  ConsumerErrorState({required this.message});
}
