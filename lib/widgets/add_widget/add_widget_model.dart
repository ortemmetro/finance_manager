import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/domain/data_provider/box_manager/box_manager.dart';
import 'package:finance_manager/domain/data_provider/default_data/default_categories_data.dart';
import 'package:finance_manager/domain/entity/category.dart';
import 'package:finance_manager/domain/entity/expense.dart';
import 'package:finance_manager/domain/entity/income.dart';

import 'package:finance_manager/widgets/income_page_widget/incomes_page_model.dart';
import 'package:flutter/material.dart';

import '../../session/session_id_manager.dart';
import '../expenses_page_widget/expenses_page_model.dart';

class AddWidgetModel extends ChangeNotifier {
  final ExpensesPageModel expenseModel;
  final IncomesPageModel incomeModel;
  var selectedIndex = -1;
  String selectedCategoryName = "";

  bool isButtonEnabled = true;

  DateTime? currentDate;

  List<Category> listOfCategories = List.empty(growable: true);
  final iconsMap = DefaultCategoriesData.iconsMap;

  AddWidgetModel(this.expenseModel, this.incomeModel);

  Future<void> createExpense({
    required String comment,
    required String category,
    required DateTime date,
    required double price,
    required BuildContext context,
  }) async {
    isButtonEnabled = !isButtonEnabled;
    notifyListeners();
    final userId = await SessionIdManager.instance.readUserId();
    //Reference to document
    final docUsersReference = (await FirebaseFirestore.instance
            .collection('Users')
            .where("id", isEqualTo: userId)
            .get())
        .docs
        .first
        .reference;
    final docExpenseReference = docUsersReference.collection('Expenses').doc();

    //Сreating an expense
    final expense = Expense(
      id: docExpenseReference.id,
      comment: comment,
      category: category,
      date: date,
      price: price,
    );

    await _saveDataLocallyInHive(expense);
    Navigator.of(context).pop();

    final json = expense.toJson();

    // await docExpenseReference.set(json);
    expenseModel.listOfALLALLExpenses.clear();
    expenseModel.setALLExpenses(userId);
    await expenseModel.setup(userId);

    selectedIndex = -1;
  }

  Future<void> createIncome({
    required String comment,
    required String category,
    required DateTime date,
    required double price,
    required BuildContext context,
  }) async {
    isButtonEnabled = !isButtonEnabled;
    notifyListeners();
    final userId = await SessionIdManager.instance.readUserId();
    //Reference to document
    final docUsersReference = (await FirebaseFirestore.instance
            .collection('Users')
            .where("id", isEqualTo: userId)
            .get())
        .docs
        .first
        .reference;
    final docIncomeReference = docUsersReference.collection('Incomes').doc();
    final income = Income(
      id: docIncomeReference.id,
      comment: comment,
      category: category,
      date: date,
      price: price,
    );

    await _saveDataLocallyInHive(income);
    Navigator.of(context).pop();

    final json = income.toJson();

    // await docIncomeReference.set(json);
    incomeModel.listOfALLALLIncomes.clear();
    incomeModel.setALLIncomes(userId);
    await incomeModel.setup(userId);

    selectedIndex = -1;
  }

  Future<void> _saveDataLocallyInHive(dynamic expenseOrIncome) async {
    if (expenseOrIncome is Expense) {
      final userKey = await SessionIdManager.instance.readUserKey();
      final expenseBox = await BoxManager.instance.openExpenseBox(userKey!);

      await expenseBox.add(expenseOrIncome);

      await BoxManager.instance.closeBox(expenseBox);
    }
    if (expenseOrIncome is Income) {
      final userKey = await SessionIdManager.instance.readUserKey();
      final incomeBox = await BoxManager.instance.openIncomeBox(userKey!);

      await incomeBox.add(expenseOrIncome);

      await BoxManager.instance.closeBox(incomeBox);
    }
  }

  void isSelectedIndex(int index) {
    if (selectedIndex == index) {
      selectedIndex = -1;
      notifyListeners();
      return;
    }
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> myShowDatePicker(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    final newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: date,
    );
    currentDate = newDate as DateTime;
    notifyListeners();
  }
}
