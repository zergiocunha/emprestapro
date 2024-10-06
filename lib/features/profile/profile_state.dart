abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState({required this.message});
}

class ProfileLoggedOutState extends ProfileState {}

class ProfileAgreementsState extends ProfileState {}
