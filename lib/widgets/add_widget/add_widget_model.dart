import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/data_provider/default_data/default_categories_data.dart';
import 'package:finance_manager/entity/category.dart';
import 'package:finance_manager/entity/expense.dart';
import 'package:finance_manager/widgets/income_page_widget/incomes_page_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../entity/income.dart';
import '../../session/session_id_model.dart';
import '../expenses_page_widget/expenses_page_model.dart';

class AddWidgetModel extends ChangeNotifier {
  final ExpensesPageModel expenseModel;
  final IncomesPageModel incomeModel;
  var selectedIndex = -1;
  String selectedCategoryName = "";

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
    final sessionIdModel = Provider.of<SessionIdModel>(context, listen: false);
    final userId = await sessionIdModel.readUserId("uid");
    //Reference to document
    final docUsersReference = (await FirebaseFirestore.instance
            .collection('Users')
            .where("id", isEqualTo: userId)
            .get())
        .docs
        .first
        .reference;
    final docExpenseReference = docUsersReference.collection('Expenses').doc();
    //creating an expense
    final expense = Expense(
      id: docExpenseReference.id,
      comment: comment,
      category: category,
      date: date,
      price: price,
    );

    final json = expense.toJson();

    await docExpenseReference.set(json);
    await expenseModel.setup(userId);
    expenseModel.listOfALLALLExpenses.clear();
    expenseModel.setALLExpenses(userId);

    Navigator.of(context).pop();
    selectedIndex = -1;
  }

  Future<void>? createIncome({
    required String comment,
    required String category,
    required DateTime date,
    required double price,
    required BuildContext context,
  }) async {
    final sessionIdModel = Provider.of<SessionIdModel>(context, listen: false);
    final userId = await sessionIdModel.readUserId("uid");
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

    final json = income.toJson();

    await docIncomeReference.set(json);
    await incomeModel.setup(userId);
    incomeModel.listOfALLALLIncomes.clear();
    incomeModel.setALLIncomes(userId);

    Navigator.of(context).pop();
    selectedIndex = -1;
    return;
  }

  void _saveDataLocally(dynamic expenseOrIncome) {
    // //storing data locally
    // var expensesBox = await Hive.openBox<Expense>('ExpensesBox');
    // expensesBox.add(expense);
    // var usersBox = await Hive.openBox('UsersBox');
    // var expenses = HiveList(expensesBox);
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
