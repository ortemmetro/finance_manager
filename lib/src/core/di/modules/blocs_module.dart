import 'package:finance_manager/src/core/di/di.dart';
import 'package:finance_manager/src/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:finance_manager/src/features/authentication/presentation/bloc/auth_bloc/auth_bloc.dart';

abstract class BlocsModule {
  static Future<void> init() async {
    getIt.registerFactory<AuthBloc>(
      () => AuthBloc(
        getIt<IAuthenticationRepository>(),
      ),
    );
  }
}
