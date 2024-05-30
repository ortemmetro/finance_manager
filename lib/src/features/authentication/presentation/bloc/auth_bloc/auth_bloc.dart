import 'package:bloc/bloc.dart';
import 'package:finance_manager/src/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepository _authenticationRepository;

  AuthBloc(this._authenticationRepository) : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        switch (event) {
          case AuthSignUpEvent():
            await signUp(event, emit);
            break;
          case AuthSignInEvent():
            await signIn(event, emit);
            break;
        }
      },
    );
  }

  Future<void> signUp(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      AuthLoadingState(),
    );

    try {
      final result = await _authenticationRepository.signUp(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        age: event.age,
        currency: event.currency,
      );

      if (result.user != null) {
        emit(
          AuthSuccessState(userCredential: result),
        );
      } else {
        emit(
          AuthErrorState(
            errorMessage: 'Ошибка регистрации, попробуйте позже!',
          ),
        );
      }
    } catch (e) {
      emit(
        AuthErrorState(errorMessage: e.toString()),
      );
    }
  }

  Future<void> signIn(
    AuthSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      AuthLoadingState(),
    );
    try {
      final userCredential =
          await _authenticationRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(
        AuthSuccessState(
          userCredential: userCredential,
        ),
      );
    } catch (e) {
      emit(
        AuthErrorState(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
