import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/expenses_categories_page.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/incomes_categories_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../drawer_widget/drawer_widget.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final tab = TabBar(
    unselectedLabelColor: const Color.fromARGB(255, 232, 232, 232),
    labelColor: Colors.black,
    indicator: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.white,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    labelStyle: const TextStyle(
      fontSize: 15.5,
      fontWeight: FontWeight.w500,
    ),
    tabs: const <Tab>[
      Tab(text: 'Расходы', height: 39),
      Tab(text: 'Доходы', height: 39),
    ],
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final model = Provider.of<AddCategoryWidgetModel>(context, listen: false);
      await model.setCategories(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          toolbarHeight: 70.0,
          title: const Text('Категории'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: tab.preferredSize,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                side: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              elevation: 26.0,
              color: Theme.of(context).primaryColor,
              child: tab,
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ExpensesCategoriesPage(),
            IncomesCategoriesPage(),
          ],
        ),
      ),
    );
  }
}
