import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/default_data/default_categories_data.dart';
import 'package:flutter/material.dart';

import '../../entity/category.dart';
import '../../entity/expense.dart';

class ExpensesPageModel extends ChangeNotifier {
  List<Expense> listOfExpenses = [];

  void setup() async {
    final list = await readExpenses();
    setExpenses(list);
    sortExpenses();
  }

  Future<List<Expense>> readExpenses() {
    return FirebaseFirestore.instance
        .collection('Expenses')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Expense.fromJson(doc.data())).toList())
        .first;
  }

  void setExpenses(List<Expense> currentListOfExpenses) {
    listOfExpenses = currentListOfExpenses;
    notifyListeners();
  }

  void deleteExpense(String id) {
    final docExpense =
        FirebaseFirestore.instance.collection('Expenses').doc(id);

    docExpense.delete();
    setup();
    notifyListeners();
  }

  Category findCategory(String categoryName) {
    final categoryData = DefaultExpenseCategoriesData().listOfCategories;
    final category =
        categoryData.firstWhere((element) => element.name == categoryName);

    return category;
  }

  void sortExpenses() {
    listOfExpenses.sort((a, b) => a.price.compareTo(b.price) * -1);
  }
}
