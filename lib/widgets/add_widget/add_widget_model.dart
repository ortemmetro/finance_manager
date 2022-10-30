import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/entity/expense.dart';

class AddWidgetModel {
  Future createExpense({
    required String comment,
    required String category,
    required DateTime date,
    required double price,
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
  }
}
