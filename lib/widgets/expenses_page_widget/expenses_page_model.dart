import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../entity/expense.dart';

class ExpensesPageModel extends ChangeNotifier {
  Stream<List<Expense>> readExpenses() {
    return FirebaseFirestore.instance.collection('Expenses').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Expense.fromJson(doc.data())).toList());
  }

  void deleteExpense(String id) async {
    final docExpense =
        FirebaseFirestore.instance.collection('Expenses').doc(id);

    await docExpense.delete();
    notifyListeners();
  }
}
