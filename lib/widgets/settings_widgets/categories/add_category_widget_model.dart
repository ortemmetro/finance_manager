import 'package:finance_manager/default_data/default_categories_data.dart';
import 'package:flutter/cupertino.dart';

enum CategoryClass { expense, income }

class AddCategoryWidgetModel extends ChangeNotifier {
  final listOfCategories = DefaultExpenseCategoriesData.listOfExpenseCategories;
  final iconsMap = DefaultExpenseCategoriesData.iconsMap;

  CategoryClass? categoryClass = CategoryClass.expense;

  var selectedIndex = -1;
  String selectedCategoryName = "";

  void isSelectedIndex(int index) {
    if (selectedIndex == index) {
      selectedIndex = -1;
      notifyListeners();
      return;
    }
    selectedIndex = index;
    notifyListeners();
  }
}
