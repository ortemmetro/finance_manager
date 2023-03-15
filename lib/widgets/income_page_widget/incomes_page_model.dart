import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/domain/data_provider/box_manager/box_manager.dart';
import 'package:finance_manager/domain/entity/category.dart';
import 'package:finance_manager/domain/entity/income.dart';
import 'package:finance_manager/session/session_id_manager.dart';

import 'package:flutter/cupertino.dart';

import '../../domain/data_provider/default_data/default_categories_data.dart';

class IncomesPageModel extends ChangeNotifier {
  List<Income> listOfALLALLIncomes = [];
  List<Income> listOfAllIncomes = [];
  List<Income> listOfNeededIncomes = [];
  List<Income> listOfShortenIncomes = [];
  List<Color> listOfColors = [];

  Map<String, double> dataMap = {};
  var sum = "";
  double doubleSum = 0.0;
  String? currentUserId;

  String selectedPeriod = "За всё время";

  bool isPieChart = true;

  Future<void> setALLIncomes(String? userId) async {
    if (listOfALLALLIncomes.isEmpty) {
      listOfALLALLIncomes = await readIncomesFromHive();
      currentUserId = userId;
      return;
    } else if (listOfALLALLIncomes.isNotEmpty && currentUserId != userId) {
      listOfALLALLIncomes.clear();
      listOfALLALLIncomes = await readIncomesFromHive();
      currentUserId = userId;
    }
  }

  Future<void> setup(String? userId) async {
    final list = await readIncomesFromHive();
    setALLIncomes(userId);
    _setIncomes(list);
    _sortIncomesByPrice();
    _setDataMap();
    _setColors();
    _setSum();
    notifyListeners();
  }

  Future<List<Income>> readIncomesFromFirebase(String? userId) async {
    final docUsersReference = (await FirebaseFirestore.instance
            .collection('Users')
            .where("id", isEqualTo: (userId))
            .get())
        .docs
        .first
        .reference;
    final docIncomesReference = docUsersReference.collection('Incomes');
    if (docIncomesReference.doc().path.isNotEmpty) {
      return docIncomesReference
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => Income.fromJson(doc.data())).toList())
          .first;
    }
    return [];
  }

  Future<List<Income>> readIncomesFromHive() async {
    final userKey = await SessionIdManager.instance.readUserKey();
    final incomeBox = await BoxManager.instance.openIncomeBox(userKey!);
    final incomeList = incomeBox.values.toList();
    await BoxManager.instance.closeBox(incomeBox);
    return incomeList;
  }

  void _setIncomes(List<Income> currentListOfIncomes) {
    listOfShortenIncomes.clear();
    listOfAllIncomes.clear();
    listOfAllIncomes = List.from(currentListOfIncomes);
    for (var i = 0; i < currentListOfIncomes.length; i++) {
      var currentPrice = currentListOfIncomes[i].price;

      for (var j = i + 1; j < currentListOfIncomes.length; j++) {
        if (currentListOfIncomes[i].category ==
            currentListOfIncomes[j].category) {
          currentPrice += currentListOfIncomes[j].price;
          currentListOfIncomes.removeAt(j);
          j = j - 1;
        }
      }
      listOfShortenIncomes.add(Income(
        category: currentListOfIncomes[i].category,
        date: currentListOfIncomes[i].date,
        price: currentPrice,
      ));
    }
    notifyListeners();
  }

  void _sortIncomesByPrice() {
    listOfShortenIncomes.sort((a, b) => a.price.compareTo(b.price) * -1);
    notifyListeners();
  }

  void _setDataMap() {
    final Map<String, double> mapOfIncomes = {};
    dataMap.clear();
    for (var i = 0; i < listOfShortenIncomes.length; i++) {
      mapOfIncomes[listOfShortenIncomes[i].category] =
          listOfShortenIncomes[i].price;
    }
    dataMap.addAll(mapOfIncomes);
    notifyListeners();
  }

  void _setColors() {
    if (listOfShortenIncomes.isEmpty) {
      listOfColors.clear();
      return;
    }
    listOfColors.clear();
    for (var i = 0; i < listOfShortenIncomes.length; i++) {
      listOfColors.add(Color(
          int.parse(findCategory(listOfShortenIncomes[i].category).color)));
    }
    notifyListeners();
  }

  void _setSum() {
    sum = "";
    doubleSum = 0.0;
    double currentSum = 0;
    for (var i = 0; i < listOfShortenIncomes.length; i++) {
      currentSum += listOfShortenIncomes[i].price;
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

  Category findCategory(String categoryName) {
    final categoryData = DefaultCategoriesData.listOfIncomesCategories +
        DefaultCategoriesData.listOfTempIncomeCategories;
    final category =
        categoryData.firstWhere((element) => element.name == categoryName);

    return category;
  }

  List<Income> sortIncomesByDate(List<Income> list) {
    final List<Income> newList = List.from(list);
    newList.sort((a, b) => a.date.compareTo(b.date));

    return newList;
  }

  void changePieToBar() {
    isPieChart = !isPieChart;
    notifyListeners();
  }
}
