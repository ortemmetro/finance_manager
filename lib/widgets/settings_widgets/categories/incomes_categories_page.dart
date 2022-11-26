import 'package:flutter/material.dart';

import '../../../default_data/default_categories_data.dart';
import '../../../entity/category.dart';

class IncomesCategoriesPage extends StatelessWidget {
  IncomesCategoriesPage({super.key});
  final listOfIncomesCategories =
      DefaultExpenseCategoriesData.listOfIncomesCategories;
  final iconsMap = DefaultExpenseCategoriesData.iconsMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _IncomesCategoriesGridView(
        listOfCategories: listOfIncomesCategories,
        iconsMap: iconsMap,
      ),
    );
  }
}

class _IncomesCategoriesGridView extends StatelessWidget {
  const _IncomesCategoriesGridView({
    Key? key,
    required this.listOfCategories,
    required this.iconsMap,
  }) : super(key: key);

  final List<Category> listOfCategories;
  final Map<String, IconData> iconsMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: GridView.builder(
        itemCount: listOfCategories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CategoryCircleIconWidget(
                      index: index,
                      listOfCategories: listOfCategories,
                      iconsMap: iconsMap,
                    ),
                  ],
                ),
              ),
              Text(listOfCategories[index].name),
            ],
          );
        },
      ),
    );
  }
}

class CategoryCircleIconWidget extends StatelessWidget {
  const CategoryCircleIconWidget({
    Key? key,
    required this.index,
    required this.listOfCategories,
    required this.iconsMap,
  }) : super(key: key);
  final List<Category> listOfCategories;
  final Map<String, IconData> iconsMap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(1.0),
        child: Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: Color(int.parse(listOfCategories[index].color)),
            shape: BoxShape.circle,
          ),
          child: Icon(
            iconsMap[listOfCategories[index].icon],
            size: 45,
          ),
        ),
      ),
    );
  }
}
