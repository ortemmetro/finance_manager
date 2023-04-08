import 'package:finance_manager/domain/data_provider/box_manager/box_manager.dart';
import 'package:finance_manager/domain/entity/expense.dart';
import 'package:finance_manager/domain/entity/income.dart';
import 'package:finance_manager/domain/entity/my_user_for_hive.dart';
import 'package:finance_manager/session/session_id_manager.dart';
import 'package:flutter/material.dart';

class AccountsModel extends ChangeNotifier {
  List<String> accounts = [];

  Future<void> setAccounts() async {
    final userId = await SessionIdManager.instance.readUserId();
    final userBox = await BoxManager.instance.openUserBox();
    final usersList = userBox.values.toList();
    final user = usersList.where((element) => element.id == userId).first;
    accounts = user.accounts;
    notifyListeners();
  }

  double getSumForAccount({
    required List<Expense> listOfExpenses,
    required List<Income> listOfIncomes,
    required String account,
  }) {
    var currentExpenses = [];
    var expenseSum = 0.0;
    for (var i = 0; i < listOfExpenses.length; i++) {
      if (listOfExpenses[i].account == account) {
        currentExpenses.add(listOfExpenses[i]);
        expenseSum += listOfExpenses[i].price;
      }
    }

    var currentIncomes = [];
    var incomeSum = 0.0;
    for (var i = 0; i < listOfIncomes.length; i++) {
      if (listOfIncomes[i].account == account) {
        currentIncomes.add(listOfIncomes[i]);
        incomeSum += listOfIncomes[i].price;
      }
    }

    double sum = incomeSum - expenseSum;
    return sum;
  }

  Future<void> addAccount(String account) async {
    final userBox = await BoxManager.instance.openUserBox();
    final userId = await SessionIdManager.instance.readUserId();
    final usersList = userBox.values.toList();
    final user = usersList.where((element) => element.id == userId).first;

    final userKey = user.key;
    final List<String> newAccounts = List.from(user.accounts);
    newAccounts.add(account);

    final newUserWithNewAccounts = MyUserForHive(
      id: user.id,
      age: user.age,
      currency: user.currency,
      locale: user.locale,
      accounts: newAccounts,
      firstName: user.firstName,
      lastName: user.lastName,
    );

    await userBox.putAt(userKey, newUserWithNewAccounts);

    await BoxManager.instance.closeBox(userBox);
    notifyListeners();
  }
}
