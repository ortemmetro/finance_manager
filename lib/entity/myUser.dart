import 'package:finance_manager/entity/expense.dart';

class MyUser {
  final String name;
  final String surName;
  final Expense? expenses;

  MyUser({
    required this.name,
    required this.surName,
    required this.expenses,
  });
}
