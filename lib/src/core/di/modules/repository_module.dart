import 'package:finance_manager/src/core/di/di.dart';
import 'package:finance_manager/src/features/authentication/data/data_sources/authentication_data_source.dart';
import 'package:finance_manager/src/features/authentication/data/repositories/authentication_repository.dart';
import 'package:finance_manager/src/features/authentication/domain/repositories/i_authentication_repository.dart';

abstract class RepositoryModule {
  static Future<void> init() async {
    getIt.registerFactory<IAuthenticationRepository>(
      () => AuthenticationRepository(
        getIt<AuthenticationDataSource>(),
      ),
    );
  }
}
