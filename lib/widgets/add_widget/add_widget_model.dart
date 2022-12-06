import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/default_data/default_categories_data.dart';
import 'package:finance_manager/entity/category.dart';
import 'package:finance_manager/entity/expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../session/session_id_model.dart';
import '../expenses_page_widget/expenses_page_model.dart';

class AddWidgetModel extends ChangeNotifier {
  final ExpensesPageModel expenseModel;
  var selectedIndex = -1;
  String selectedCategoryName = "";

  List<Category> listOfCategories = List.empty(growable: true);
  final iconsMap = DefaultCategoriesData.iconsMap;

  AddWidgetModel(this.expenseModel);

  Future<void>? createExpense({
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
    final expense = Expense(
      id: docExpenseReference.id,
      comment: comment,
      category: category,
      date: date,
      price: price,
    );

    final json = expense.toJson();

    await docExpenseReference.set(json);
    expenseModel.setup(context, userId);

    Navigator.of(context).pop();
    return;
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

  Future<DateTime?> myShowDatePicker(
    DateTime? newDate,
    BuildContext context,
  ) async {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: date,
    );

    return newDate;
  }
}
