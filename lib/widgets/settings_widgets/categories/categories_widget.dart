import 'package:finance_manager/session/session_id_model.dart';
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

class _CategoriesWidgetState extends State<CategoriesWidget>
    with TickerProviderStateMixin {
  late TabController? _tabController;
  final myTabs = const <Tab>[
    Tab(text: 'Расходы', height: 39),
    Tab(text: 'Доходы', height: 39),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    Future.delayed(Duration.zero, () async {
      final model = Provider.of<AddCategoryWidgetModel>(context, listen: false);
      await model.setCategories(context);
      final sessionIdModel =
          Provider.of<SessionIdModel>(context, listen: false);
      final userId = sessionIdModel.readUserId("uid");
      model.userId = await userId;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddCategoryWidgetModel>(context, listen: true);
    final listOfExpenseCategories = model.listOfExpenseCategories;
    final listOfIncomeCategories = model.listOfIncomeCategories;
    final iconsMap = model.iconsMap;
    _tabController?.addListener(() {
      if (myTabs[_tabController!.index].text == "Расходы") {
        model.categoryClass = CategoryClass.expense;
      } else {
        model.categoryClass = CategoryClass.income;
      }
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/main_page/categories/add");
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      drawer: DrawerWidget(),
      appBar: AppBar(
        toolbarHeight: 70.0,
        title: const Text('Категории'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
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
            child: TabBar(
              onTap: (index) {
                if (myTabs[index].text == "Расходы") {
                  model.categoryClass = CategoryClass.expense;
                } else {
                  model.categoryClass = CategoryClass.income;
                }
              },
              controller: _tabController,
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
              tabs: myTabs,
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ExpensesCategoriesPage(
            userId: model.userId,
            iconsMap: iconsMap,
            listOfCategories: listOfExpenseCategories,
          ),
          IncomesCategoriesPage(
            userId: model.userId,
            iconsMap: iconsMap,
            listOfCategories: listOfIncomeCategories,
          ),
        ],
      ),
    );
  }
}
