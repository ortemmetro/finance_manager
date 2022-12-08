import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entity/category.dart';

class ExpensesCategoriesPage extends StatefulWidget {
  const ExpensesCategoriesPage({super.key});

  @override
  State<ExpensesCategoriesPage> createState() => _ExpensesCategoriesPageState();
}

class _ExpensesCategoriesPageState extends State<ExpensesCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddCategoryWidgetModel>(context, listen: true);
    final listOfCategories = model.listOfExpenseCategories;
    final iconsMap = model.iconsMap;
    return Scaffold(
      body: _ExpensesCategoriesGridView(
        listOfCategories: listOfCategories,
        iconsMap: iconsMap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/main_page/categories/add");
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ExpensesCategoriesGridView extends StatelessWidget {
  const _ExpensesCategoriesGridView({
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
              Text(
                listOfCategories[index].name,
                maxLines: 1,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
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
