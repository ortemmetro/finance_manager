import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../entity/expense.dart';

class ExpensesPageModel extends ChangeNotifier {
  List<Expense> _listOfExpenses = [];

  List<Expense> get listOfExpenses => _listOfExpenses;

  void setup() async {
    await readExpenses();
  }

  Future<void> readExpenses() async {
    final listOfExpenses = await FirebaseFirestore.instance
        .collection('Expenses')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Expense.fromJson(doc.data())).toList())
        .first;
    // if (_listOfExpenses == listOfExpenses) return;
    _listOfExpenses = listOfExpenses;
    notifyListeners();
  }

  void deleteExpense(String id) {
    final docExpense =
        FirebaseFirestore.instance.collection('Expenses').doc(id);

    docExpense.delete();
    readExpenses();
    notifyListeners();
  }
}
