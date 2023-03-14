import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/domain/data_provider/box_manager/box_manager.dart';
import 'package:finance_manager/domain/data_provider/default_data/default_categories_data.dart';
import 'package:finance_manager/domain/entity/category.dart';
import 'package:finance_manager/session/session_id_manager.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

enum CategoryClass { expense, income }

class AddCategoryWidgetModel extends ChangeNotifier {
  List<Category> listOfExpenseCategories = List.empty(growable: true);
  List<Category> listOfIncomeCategories = List.empty(growable: true);

  final iconsMap = DefaultCategoriesData.iconsMap;

  int categoryClassIndex = CategoryClass.expense.index;

  var selectedIndex = -1;
  String selectedCategoryIcon = "";

  Color color = Colors.red;

  String? userId = "";

  Future<void> setCategories() async {
    listOfExpenseCategories.clear();
    listOfIncomeCategories.clear();
    DefaultCategoriesData.listOfTempExpenseCategories.clear();
    DefaultCategoriesData.listOfTempIncomeCategories.clear();

    await downloadCategoriesFromHive();

    listOfExpenseCategories.addAll(
        DefaultCategoriesData.listOfExpenseCategories +
            DefaultCategoriesData.listOfTempExpenseCategories);
    listOfIncomeCategories.addAll(
        DefaultCategoriesData.listOfIncomesCategories +
            DefaultCategoriesData.listOfTempIncomeCategories);
    notifyListeners();
  }

  void isSelectedIndex(int index) {
    if (selectedIndex == index) {
      selectedIndex = -1;
      notifyListeners();
      return;
    }
    selectedIndex = index;
    notifyListeners();
  }

  Widget _buildColorPicker() {
    return ColorPicker(
      pickerColor: color,
      enableAlpha: false,
      labelTypes: const [],
      onColorChanged: (color) {
        this.color = color;
        notifyListeners();
      },
    );
  }

  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Выберите ваш цвет"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildColorPicker(),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "ВЫБРАТЬ",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addCategory(String categoryName, BuildContext context) async {
    final userId = await SessionIdManager.instance.readUserId();
    final userReference = (await FirebaseFirestore.instance
            .collection('Users')
            .where("id", isEqualTo: userId)
            .get())
        .docs
        .first
        .reference;
    final stringColorList = color.value.toRadixString(16).split("");
    stringColorList.insert(0, "0");
    stringColorList.insert(1, "x");
    final stringColor = stringColorList.join();

    if (categoryClassIndex == CategoryClass.income.index) {
      final categoryReference = userReference.collection("Categories").doc();
      final category = Category(
        id: categoryReference.id,
        name: categoryName,
        color: stringColor,
        icon: selectedCategoryIcon,
        categoryClassIndex: categoryClassIndex,
      );
      final userKey = await SessionIdManager.instance.readUserKey();
      final categoryBox = await BoxManager.instance.openCategoryBox(userKey!);

      await categoryBox.add(category);
      await BoxManager.instance.closeBox(categoryBox);

      Navigator.of(context).pop();

      // final json = category.toJson();
      // await categoryReference.set(json);
      await setCategories();
      notifyListeners();
      return;
    }

    final categoryReference = userReference.collection("Categories").doc();
    final category = Category(
      id: categoryReference.id,
      name: categoryName,
      color: stringColor,
      icon: selectedCategoryIcon,
      categoryClassIndex: categoryClassIndex,
    );

    final userKey = await SessionIdManager.instance.readUserKey();
    final categoryBox = await BoxManager.instance.openCategoryBox(userKey!);

    await categoryBox.add(category);
    await BoxManager.instance.closeBox(categoryBox);

    Navigator.of(context).pop();

    // final json = category.toJson();
    // await categoryReference.set(json);
    await setCategories();
    notifyListeners();
  }

  Future<void> downloadCategoriesFromFirebase(BuildContext context) async {
    List<Category> tempList = [];
    final userId = await SessionIdManager.instance.readUserId();
    final userReference = (await FirebaseFirestore.instance
            .collection('Users')
            .where("id", isEqualTo: userId)
            .get())
        .docs
        .first
        .reference;
    final categoryReference = userReference.collection("Categories");
    if (categoryReference.doc().path.isNotEmpty) {
      tempList = await categoryReference
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Category.fromJson(doc.data()))
              .toList())
          .first;
      for (var i = 0; i < tempList.length; i++) {
        if (tempList[i].categoryClassIndex == CategoryClass.expense.index) {
          DefaultCategoriesData.listOfTempExpenseCategories.add(tempList[i]);
        } else {
          DefaultCategoriesData.listOfTempIncomeCategories.add(tempList[i]);
        }
      }
    }
  }

  Future<void> downloadCategoriesFromHive() async {
    final userKey = await SessionIdManager.instance.readUserKey();
    final categoryBox = await BoxManager.instance.openCategoryBox(userKey!);

    if (categoryBox.values.isEmpty) {
      return;
    }

    final tempListOfCategories = categoryBox.values.toList();

    for (var i = 0; i < tempListOfCategories.length; i++) {
      if (tempListOfCategories[i].categoryClassIndex ==
          CategoryClass.expense.index) {
        DefaultCategoriesData.listOfTempExpenseCategories
            .add(tempListOfCategories[i]);
      } else {
        DefaultCategoriesData.listOfTempIncomeCategories
            .add(tempListOfCategories[i]);
      }
    }
  }

  Future<void> deleteCategoryFromFirebase(
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
    final docCategoryReference = docUsersReference.collection('Categories');
    if (docCategoryReference.doc(id).path.isNotEmpty) {
      await docCategoryReference.doc(id).delete();
      await setCategories();
      return;
    }
  }

  Future<void> deleteCategoryFromHive(
    Category category,
    ExpensesPageModel expenseModel,
  ) async {
    final userKey = await SessionIdManager.instance.readUserKey();
    final categoryBox = await BoxManager.instance.openCategoryBox(userKey!);

    await categoryBox.deleteAt(category.key);
    await BoxManager.instance.closeBox(categoryBox);

    final expenseBox = await BoxManager.instance.openExpenseBox(userKey);
    final expenseList = expenseBox.values.toList();
    final neededKeys = expenseList
        .where((element) => element.category == category.name)
        .map((e) => e.key);

    await expenseBox.deleteAll(neededKeys);
    await BoxManager.instance.closeBox(expenseBox);

    final userId = await SessionIdManager.instance.readUserId();

    await expenseModel.setup(userId);
    expenseModel.listOfALLALLExpenses.clear();
    await expenseModel.setALLExpenses(userId);

    await setCategories();
  }
}
