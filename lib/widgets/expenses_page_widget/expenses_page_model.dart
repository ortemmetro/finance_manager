import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/default_data/default_categories_data.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../entity/category.dart';
import '../../entity/expense.dart';

enum Period { day, week, month, customPeriod }

class ExpensesPageModel extends ChangeNotifier {
  List<Expense> listOfAllExpenses = [];
  List<Expense> listOfNeededExpenses = [];
  List<Expense> listOfShortenExpenses = [];
  List<Color> listOfColors = [];

  Map<String, double> dataMap = {};
  var sum = "";

  Future<void> setup(
    BuildContext context,
    String? userId,
  ) async {
    final list = await readExpenses(context, userId) ?? [];
    _setExpenses(list);
    _sortExpenses();
    _setDataMap();
    _setColors();
    _setSum();
    notifyListeners();
  }

  Future<List<Expense>>? readExpenses(
    BuildContext context,
    String? userId,
  ) async {
    final docUsersReference = (await FirebaseFirestore.instance
            .collection('Users')
            .where("id", isEqualTo: (userId))
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
    listOfShortenExpenses.clear();
    listOfAllExpenses.clear();
    listOfAllExpenses = List.from(currentListOfExpenses);
    for (var i = 0; i < currentListOfExpenses.length; i++) {
      for (var j = i + 1; j < currentListOfExpenses.length; j++) {
        if (currentListOfExpenses[i].category ==
                currentListOfExpenses[j].category &&
            i != j) {
          listOfShortenExpenses.add(Expense(
            category: currentListOfExpenses[i].category,
            date: currentListOfExpenses[i].date,
            price:
                currentListOfExpenses[i].price + currentListOfExpenses[j].price,
          ));
          currentListOfExpenses.removeAt(j);
          break;
        } else if (j == currentListOfExpenses.length - 1) {
          listOfShortenExpenses.add(currentListOfExpenses[i]);
        }
      }
      if (i == currentListOfExpenses.length - 1) {
        listOfShortenExpenses.add(currentListOfExpenses[i]);
      }
    }

    notifyListeners();
  }

  Future<void> deleteExpense(
    String id,
    BuildContext context,
    String? userId,
  ) async {
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
      setup(context, userId);
      return;
    }
    setup(context, userId);
    return;
  }

  Category findCategory(String categoryName) {
    final categoryData = DefaultCategoriesData.listOfExpenseCategories +
        DefaultCategoriesData.listOfTempExpenseCategories;
    final category =
        categoryData.firstWhere((element) => element.name == categoryName);

    return category;
  }

  void _sortExpenses() {
    listOfShortenExpenses.sort((a, b) => a.price.compareTo(b.price) * -1);
    notifyListeners();
  }

  void _setColors() {
    if (listOfShortenExpenses.isEmpty) {
      listOfColors.clear();
      return;
    }
    listOfColors.clear();
    for (var i = 0; i < listOfShortenExpenses.length; i++) {
      listOfColors.add(Color(
          int.parse(findCategory(listOfShortenExpenses[i].category).color)));
    }
    notifyListeners();
  }

  void _setDataMap() {
    final Map<String, double> mapOfExpenses = {};
    dataMap.clear();
    for (var i = 0; i < listOfShortenExpenses.length; i++) {
      mapOfExpenses[listOfShortenExpenses[i].category] =
          listOfShortenExpenses[i].price;
    }
    dataMap.addAll(mapOfExpenses);
    notifyListeners();
  }

  void _setSum() {
    sum = "";
    double currentSum = 0;
    for (var i = 0; i < listOfShortenExpenses.length; i++) {
      currentSum += listOfShortenExpenses[i].price;
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

  void _changePeriod(Period period, DateTime currentDate) {
    if (period == Period.day) {
      listOfNeededExpenses = List.from(listOfAllExpenses);
      listOfNeededExpenses.removeWhere((element) {
        final a = currentDate.subtract(const Duration(days: 1));
        var b = true;
        if (element.date.isAfter(a) && element.date.isBefore(currentDate)) {
          b = false;
        }
        return b;
      });
      _setExpenses(listOfNeededExpenses);
      _sortExpenses();
      _setDataMap();
      _setColors();
      _setSum();
    }
  }

  void showDateChangeDialog(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      expand: false,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            ListTile(
              leading: const Text("День"),
              onTap: () => _changePeriod(Period.day, DateTime.now()),
            ),
            Divider(),
            ListTile(
              leading: Text("Неделя"),
            ),
            Divider(),
            ListTile(
              leading: Text("Месяц"),
            ),
            Divider(),
            ListTile(
              leading: Text("Год"),
            ),
            Divider(),
            ListTile(
              leading: Text("Период"),
            ),
          ],
        );
      },
    );
  }
}
