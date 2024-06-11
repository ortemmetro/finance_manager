import 'package:finance_manager/src/core/di/modules/blocs_module.dart';
import 'package:finance_manager/src/core/di/modules/data_source_module.dart';
import 'package:finance_manager/src/core/di/modules/firebase_module.dart';
import 'package:finance_manager/src/core/di/modules/repository_module.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

abstract class Di {
  static Future<void> initDependencies() async {
    await FirebaseModule.init();
    await DataSourceModule.init();
    await RepositoryModule.init();
    await BlocsModule.init();
  }
}
