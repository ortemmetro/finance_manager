import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/default_data/default_categories_data.dart';
import 'package:finance_manager/entity/expense.dart';
import 'package:flutter/cupertino.dart';

import '../../entity/category.dart';
import '../expenses_page_widget/expenses_page_model.dart';

class AddWidgetModel extends ChangeNotifier {
  final ExpensesPageModel expenseModel;

  final listOfCategories = DefaultExpenseCategoriesData().listOfCategories;
  final iconsMap = DefaultExpenseCategoriesData().iconsMap;

  AddWidgetModel(this.expenseModel);

  Future<void>? createExpense({
    required String comment,
    required String category,
    required DateTime date,
    required double price,
    required BuildContext context,
  }) async {
    //Reference to document
    final docExpense = FirebaseFirestore.instance.collection('Expenses').doc();
    final expense = Expense(
      id: docExpense.id,
      comment: comment,
      category: category,
      date: date,
      price: price,
    );

    final json = expense.toJson();

    await docExpense.set(json);
    expenseModel.setup();

    Navigator.of(context).pop();
    return;
  }
}
