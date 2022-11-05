import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../entity/expense.dart';

class ExpensesPageModel extends ChangeNotifier {
  List<Expense> listOfExpenses = [];

  void setup() async {
    final list = await readExpenses();
    setExpenses(list);
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
}
