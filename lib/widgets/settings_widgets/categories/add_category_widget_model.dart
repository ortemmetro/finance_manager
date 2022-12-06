import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/default_data/default_categories_data.dart';
import 'package:finance_manager/entity/category.dart';
import 'package:finance_manager/session/session_id_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

enum CategoryClass { expense, income }

class AddCategoryWidgetModel extends ChangeNotifier {
  List<Category> listOfExpenseCategories = List.empty(growable: true);
  List<Category> listOfIncomeCategories = List.empty(growable: true);

  final iconsMap = DefaultCategoriesData.iconsMap;

  CategoryClass categoryClass = CategoryClass.expense;

  var selectedIndex = -1;
  String selectedCategoryIcon = "";

  Color color = Colors.red;

  void setCategories() {
    listOfExpenseCategories.clear();
    listOfIncomeCategories.clear();

    listOfExpenseCategories.addAll(
        DefaultCategoriesData.listOfExpenseCategories +
            DefaultCategoriesData.listOfTempExpenseCategories);
    listOfIncomeCategories.addAll(
        DefaultCategoriesData.listOfIncomesCategories +
            DefaultCategoriesData.listOfTempIncomeCategories);
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
    final userId = await SessionIdModel().readUserId("uid");
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

    if (categoryClass == CategoryClass.income) {
      final categoryReference = userReference.collection("Categories").doc();
      final category = Category(
        name: categoryName,
        color: stringColor,
        icon: selectedCategoryIcon,
        categoryClass: categoryClass,
      );
      final json = category.toJson();
      await categoryReference.set(json);
      await downloadCategories(context);
      notifyListeners();
      Navigator.of(context).pop();
      return;
    }

    final categoryReference = userReference.collection("Categories").doc();
    final category = Category(
      name: categoryName,
      color: stringColor,
      icon: selectedCategoryIcon,
      categoryClass: categoryClass,
    );
    final json = category.toJson();
    await categoryReference.set(json);
    await downloadCategories(context);
    notifyListeners();
    Navigator.of(context).pop();
  }

  Future<void> downloadCategories(BuildContext context) async {
    List<Category> tempList = [];
    final sessionIdModel = Provider.of<SessionIdModel>(context, listen: false);
    await sessionIdModel.writeUserId(FirebaseAuth.instance.currentUser!.uid);
    final userId = await SessionIdModel().readUserId("uid");
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
        if (tempList[i].categoryClass == CategoryClass.expense) {
          DefaultCategoriesData.listOfTempExpenseCategories.add(tempList[i]);
        } else {
          DefaultCategoriesData.listOfTempIncomeCategories.add(tempList[i]);
        }
      }
    }
  }
}
