part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final int age;
  final String currency;

  AuthSignUpEvent({
    required this.age,
    required this.firstName,
    required this.lastName,
    required this.currency,
    required this.confirmPassword,
    required this.email,
    required this.password,
  });
}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvent({
    required this.email,
    required this.password,
  });
}
