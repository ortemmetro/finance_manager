import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/default_data/default_categories_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../entity/category.dart';
import '../../entity/expense.dart';

enum Period { day, week, month, year, customPeriod }

class ExpensesPageModel extends ChangeNotifier {
  List<Expense> listOfALLALLExpenses = [];
  List<Expense> listOfAllExpenses = [];
  List<Expense> listOfNeededExpenses = [];
  List<Expense> listOfShortenExpenses = [];
  List<Color> listOfColors = [];

  Map<String, double> dataMap = {};
  var sum = "";
  double doubleSum = 0.0;
  String? currentUserId;

  String? selectedPeriod;

  bool isPieChart = true;

  void setSelectedPeriod(String newSelectedPeriod) {
    selectedPeriod = newSelectedPeriod;
  }

  Future<void> setALLExpenses(String? userId) async {
    if (listOfALLALLExpenses.isEmpty) {
      listOfALLALLExpenses = await readExpenses(userId) ?? [];
      currentUserId = userId;
      return;
    } else if (listOfALLALLExpenses.isNotEmpty && currentUserId != userId) {
      listOfALLALLExpenses.clear();
      listOfALLALLExpenses = await readExpenses(userId) ?? [];
      currentUserId = userId;
    }
  }

  Future<void> setup(String? userId) async {
    final list = await readExpenses(userId) ?? [];
    setALLExpenses(userId);
    _setExpenses(list);
    _sortExpensesByPrice();
    _setDataMap();
    _setColors();
    _setSum();
    notifyListeners();
  }

  Future<List<Expense>>? readExpenses(String? userId) async {
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
      var currentPrice = currentListOfExpenses[i].price;

      for (var j = i + 1; j < currentListOfExpenses.length; j++) {
        if (currentListOfExpenses[i].category ==
            currentListOfExpenses[j].category) {
          currentPrice += currentListOfExpenses[j].price;
          currentListOfExpenses.removeAt(j);
          j = j - 1;
        }
      }
      listOfShortenExpenses.add(Expense(
        category: currentListOfExpenses[i].category,
        date: currentListOfExpenses[i].date,
        price: currentPrice,
      ));
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
      setup(userId);
      listOfALLALLExpenses.clear();
      await setALLExpenses(userId);
      return;
    }
    await setup(userId);
    listOfALLALLExpenses.clear();
    await setALLExpenses(userId);
    return;
  }

  Category findCategory(String categoryName) {
    final categoryData = DefaultCategoriesData.listOfExpenseCategories +
        DefaultCategoriesData.listOfTempExpenseCategories;
    final category =
        categoryData.firstWhere((element) => element.name == categoryName);

    return category;
  }

  double findMaxPrice(List<Expense> list) {
    if (list.isEmpty) {
      return 0;
    }
    var max = list[0].price;
    for (var i = 0; i < list.length; i++) {
      if (list[i].price > max) {
        max = list[i].price;
      }
    }

    return max;
  }

  void _sortExpensesByPrice() {
    listOfShortenExpenses.sort((a, b) => a.price.compareTo(b.price) * -1);
    notifyListeners();
  }

  List<Expense> sortExpensesByDate(List<Expense> list) {
    final List<Expense> newList = List.from(list);
    newList.sort((a, b) => a.date.compareTo(b.date));

    return newList;
  }

  void changePieToBar() {
    isPieChart = !isPieChart;
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
    doubleSum = 0.0;
    double currentSum = 0;
    for (var i = 0; i < listOfShortenExpenses.length; i++) {
      currentSum += listOfShortenExpenses[i].price;
    }
    var sumString = currentSum.floor().toString().split('');
    doubleSum = double.parse(sumString.join());

    for (var i = sumString.length; i > 0; i--) {
      if ((sumString.length - i) % 4 == 0) {
        sumString.insert(i, ' ');
      }
    }
    sum = sumString.join();

    notifyListeners();
  }

  void _changePeriod(
    Period period,
    DateTime currentDate,
    BuildContext context,
  ) {
    if (period == Period.day) {
      listOfNeededExpenses = List.from(listOfALLALLExpenses);
      listOfNeededExpenses.removeWhere((element) {
        final a = currentDate.subtract(const Duration(days: 1));
        var b = true;
        if (element.date.isAfter(a) && element.date.isBefore(currentDate)) {
          b = false;
        }
        return b;
      });
      _setExpenses(listOfNeededExpenses);
      _sortExpensesByPrice();
      _setDataMap();
      _setColors();
      _setSum();
      selectedPeriod = AppLocalizations.of(context)!.day;
      notifyListeners();
    } else if (period == Period.week) {
      listOfNeededExpenses = List.from(listOfALLALLExpenses);
      listOfNeededExpenses.removeWhere((element) {
        final a = currentDate.subtract(const Duration(days: 7));
        var b = true;
        if (element.date.isAfter(a) && element.date.isBefore(currentDate)) {
          b = false;
        }
        return b;
      });
      _setExpenses(listOfNeededExpenses);
      _sortExpensesByPrice();
      _setDataMap();
      _setColors();
      _setSum();
      selectedPeriod = AppLocalizations.of(context)!.week;
      notifyListeners();
    } else if (period == Period.month) {
      listOfNeededExpenses = List.from(listOfALLALLExpenses);
      listOfNeededExpenses.removeWhere((element) {
        final a = currentDate.subtract(const Duration(days: 30));
        var b = true;
        if (element.date.isAfter(a) && element.date.isBefore(currentDate)) {
          b = false;
        }
        return b;
      });
      _setExpenses(listOfNeededExpenses);
      _sortExpensesByPrice();
      _setDataMap();
      _setColors();
      _setSum();
      selectedPeriod = AppLocalizations.of(context)!.month;
      notifyListeners();
    } else if (period == Period.year) {
      listOfNeededExpenses = List.from(listOfALLALLExpenses);
      listOfNeededExpenses.removeWhere((element) {
        final a = currentDate.subtract(const Duration(days: 365));
        var b = true;
        if (element.date.isAfter(a) && element.date.isBefore(currentDate)) {
          b = false;
        }
        return b;
      });
      _setExpenses(listOfNeededExpenses);
      _sortExpensesByPrice();
      _setDataMap();
      _setColors();
      _setSum();
      selectedPeriod = AppLocalizations.of(context)!.year;
      notifyListeners();
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
            SizedBox(height: 10.h),
            ListTile(
              leading: Text(AppLocalizations.of(context)!.day),
              onTap: () {
                _changePeriod(Period.day, DateTime.now(), context);
                Navigator.of(context).pop();
              },
            ),
            const Divider(),
            ListTile(
              leading: Text(AppLocalizations.of(context)!.week),
              onTap: () {
                _changePeriod(Period.week, DateTime.now(), context);
                Navigator.of(context).pop();
              },
            ),
            const Divider(),
            ListTile(
              leading: Text(AppLocalizations.of(context)!.month),
              onTap: () {
                _changePeriod(Period.month, DateTime.now(), context);
                Navigator.of(context).pop();
              },
            ),
            const Divider(),
            ListTile(
              leading: Text(AppLocalizations.of(context)!.year),
              onTap: () {
                _changePeriod(Period.year, DateTime.now(), context);
                Navigator.of(context).pop();
              },
            ),
            const Divider(),
            ListTile(
              leading: Text(AppLocalizations.of(context)!.period),
            ),
          ],
        );
      },
    );
  }
}
