import 'package:finance_manager/domain/entity/account.dart';
import 'package:finance_manager/domain/entity/category.dart';
import 'package:finance_manager/domain/entity/expense.dart';
import 'package:finance_manager/domain/entity/income.dart';
import 'package:finance_manager/domain/entity/my_user_for_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();
  BoxManager._();

  Future<Box<MyUserForHive>> openUserBox() async {
    return _openBox<MyUserForHive>("user_box", 4, MyUserForHiveAdapter());
  }

  Future<Box<Expense>> openExpenseBox(int userKey) async {
    return _openBox<Expense>("expense_box_$userKey", 2, ExpenseAdapter());
  }

  Future<Box<Income>> openIncomeBox(int userKey) async {
    return _openBox<Income>("income_box_$userKey", 3, IncomeAdapter());
  }

  Future<Box<Category>> openCategoryBox(int userKey) async {
    return _openBox<Category>("category_box_$userKey", 1, CategoryAdapter());
  }

  Future<Box<Account>> openAccountBox(int userKey) async {
    return _openBox<Account>("account_box_$userKey", 5, AccountAdapter());
  }

  Future<void> closeBox<T>(Box<T> box) async {
    await box.compact();
    await box.close();
  }

  Future<Box<T>> _openBox<T>(
    String boxName,
    int typeId,
    TypeAdapter<T> adapter,
  ) async {
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }

    return Hive.openBox<T>(boxName);
  }
}
