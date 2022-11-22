import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/default_data/default_categories_data.dart';
import 'package:finance_manager/session/session_id_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../entity/category.dart';
import '../../entity/expense.dart';

class ExpensesPageModel extends ChangeNotifier {
  List<Expense> listOfExpenses = [];
  List<Color> listOfColors = [];

  Map<String, double> dataMap = {};
  var sum = "";

  void setup(BuildContext context) async {
    final list = await readExpenses(context) ?? [];
    _setExpenses(list);
    _sortExpenses();
    _setDataMap();
    _setColors();
    _setSum();
    notifyListeners();
  }

  Future<List<Expense>>? readExpenses(BuildContext context) async {
    final sessionIdModel = Provider.of<SessionIdModel>(context, listen: false);
    final userId = await sessionIdModel.readUserId("uid");
    final docUsersReference = (await FirebaseFirestore.instance
            .collection('Users')
            .where("id", isEqualTo: userId)
            .get())
        .docs
        .first
        .reference;
    final docExpenseReference = docUsersReference.collection('Expenses');
    if (docExpenseReference.doc().path.isNotEmpty) {
      return docExpenseReference
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Expense.fromJson(doc.data())).toList())
          .first;
    }

    return [];
  }

  void _setExpenses(List<Expense> currentListOfExpenses) {
    listOfExpenses = currentListOfExpenses;
    notifyListeners();
  }

  Future<void> deleteExpense(String id, BuildContext context) async {
    final sessionIdModel = Provider.of<SessionIdModel>(context, listen: false);
    final userId = await sessionIdModel.readUserId("uid");
    final docUsersReference = (await FirebaseFirestore.instance
            .collection('Users')
            .where("id", isEqualTo: userId)
            .get())
        .docs
        .first
        .reference;
    final docExpenseReference = docUsersReference.collection('Expenses');
    if (docExpenseReference.doc(id).path.isNotEmpty) {
      await docExpenseReference.doc(id).delete();
      setup(context);
      notifyListeners();
    }

    setup(context);
    notifyListeners();
    return;
  }

  Category findCategory(String categoryName) {
    final categoryData = DefaultExpenseCategoriesData().listOfCategories;
    final category =
        categoryData.firstWhere((element) => element.name == categoryName);

    return category;
  }

  void _sortExpenses() {
    listOfExpenses.sort((a, b) => a.price.compareTo(b.price) * -1);
    notifyListeners();
  }

  void _setColors() {
    if (listOfExpenses.isEmpty) {
      listOfColors.clear();
      return;
    }
    listOfColors.clear();
    for (var i = 0; i < listOfExpenses.length; i++) {
      listOfColors.add(
          Color(int.parse(findCategory(listOfExpenses[i].category).color)));
    }
    notifyListeners();
  }

  void _setDataMap() {
    final Map<String, double> mapOfExpenses = {};
    dataMap.clear();
    for (var i = 0; i < listOfExpenses.length; i++) {
      mapOfExpenses[listOfExpenses[i].category] = listOfExpenses[i].price;
    }
    dataMap.addAll(mapOfExpenses);
    notifyListeners();
  }

  void _setSum() {
    sum = "";
    double currentSum = 0;
    for (var i = 0; i < listOfExpenses.length; i++) {
      currentSum += listOfExpenses[i].price;
    }
    var sumString = currentSum.floor().toString().split('');

    for (var i = sumString.length; i > 0; i--) {
      if ((sumString.length - i) % 4 == 0) {
        sumString.insert(i, ' ');
      }
    }
    sum = sumString.join();

    notifyListeners();
  }
}
