import 'package:finance_manager/domain/entity/category.dart';
import 'package:finance_manager/domain/entity/expense.dart';
import 'package:finance_manager/domain/entity/income.dart';
import 'package:finance_manager/domain/entity/my_user_for_hive.dart';
import 'package:finance_manager/session/session_id_manager.dart';

import 'package:finance_manager/widgets/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(IncomeAdapter());
  Hive.registerAdapter(MyUserForHiveAdapter());
  final String? userId = await SessionIdManager.instance.readUserId();

  runApp(App(userId: userId));
}
