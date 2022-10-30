import 'package:cloud_firestore/cloud_firestore.dart';

import '../../entity/expense.dart';

class ExpensesPageModel {
  Stream<List<Expense>> readExpenses() {
    return FirebaseFirestore.instance.collection('Expenses').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Expense.fromJson(doc.data())).toList());
  }
}
