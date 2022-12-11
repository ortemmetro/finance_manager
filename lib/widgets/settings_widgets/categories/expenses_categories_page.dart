// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:finance_manager/session/session_id_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';

import '../../../entity/category.dart';

class CategoryInfo {
  final String userId;
  final Category category;

  CategoryInfo({
    required this.userId,
    required this.category,
  });
}

class ExpensesCategoriesPage extends StatelessWidget {
  ExpensesCategoriesPage({
    super.key,
    required this.userId,
    required this.listOfCategories,
    required this.iconsMap,
  });
  final String? userId;
  final List<Category> listOfCategories;
  final Map<String, IconData> iconsMap;

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const SizedBox.shrink();
    }
    return Scaffold(
      body: _ExpensesCategoriesGridView(
        listOfCategories: listOfCategories,
        iconsMap: iconsMap,
        userId: userId!,
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

  @override
  bool get wantKeepAlive => true;
}

class _ExpensesCategoriesGridView extends StatelessWidget {
  const _ExpensesCategoriesGridView({
    Key? key,
    required this.listOfCategories,
    required this.iconsMap,
    required this.userId,
  }) : super(key: key);

  final List<Category> listOfCategories;
  final Map<String, IconData> iconsMap;
  final String userId;

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
                      userId: userId,
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
    required this.userId,
  }) : super(key: key);
  final List<Category> listOfCategories;
  final Map<String, IconData> iconsMap;
  final int index;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          "/main_page/categories/one_category",
          arguments: CategoryInfo(
            category: listOfCategories[index],
            userId: userId,
          ),
        );
      },
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
