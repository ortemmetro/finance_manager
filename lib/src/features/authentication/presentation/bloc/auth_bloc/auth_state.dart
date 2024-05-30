part of 'auth_bloc.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserCredential userCredential;

  AuthSuccessState({
    required this.userCredential,
  });
}

class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState({
    required this.errorMessage,
  });
}

class AuthLoadingState extends AuthState {}
