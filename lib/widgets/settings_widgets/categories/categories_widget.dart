import 'package:finance_manager/session/session_id_manager.dart';
import 'package:finance_manager/widgets/drawer_widget/drawer_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/expenses_categories_page.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/incomes_categories_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget>
    with TickerProviderStateMixin {
  late TabController? _tabController;
  final myTabs = <Tab>[
    Tab(text: 'Расходы', height: 39.h),
    Tab(text: 'Доходы', height: 39.h),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    Future.delayed(Duration.zero, () async {
      final model = Provider.of<AddCategoryModel>(context, listen: false);
      await model.setCategories();
      final userId = SessionIdManager.instance.readUserId();
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
    final model = Provider.of<AddCategoryModel>(context, listen: true);
    final listOfExpenseCategories = model.listOfExpenseCategories;
    final listOfIncomeCategories = model.listOfIncomeCategories;
    final iconsMap = model.iconsMap;
    _tabController?.addListener(() {
      if (myTabs[_tabController!.index].text == 'Расходы') {
        model.categoryClassIndex = CategoryClass.expense.index;
      } else {
        model.categoryClassIndex = CategoryClass.income.index;
      }
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/main_page/categories/add');
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, size: 29.w),
      ),
      drawer: const DrawerWidget(),
      appBar: AppBar(
        toolbarHeight: 70.0.h,
        title: Text(
          AppLocalizations.of(context)!.categories,
          style: TextStyle(fontSize: 20.sp),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0.h),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              side: BorderSide(color: Colors.white, width: 2.0.w),
            ),
            elevation: 26.0.h,
            color: Theme.of(context).primaryColor,
            child: TabBar(
              onTap: (index) {
                if (myTabs[index].text == 'Расходы') {
                  model.categoryClassIndex = CategoryClass.expense.index;
                } else {
                  model.categoryClassIndex = CategoryClass.income.index;
                }
              },
              controller: _tabController,
              unselectedLabelColor: const Color.fromARGB(255, 232, 232, 232),
              labelColor: Colors.black,
              indicator: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 2.0.w),
                borderRadius: BorderRadius.circular(15),
              ),
              labelStyle: TextStyle(
                fontSize: 15.5.sp,
                fontWeight: FontWeight.w500,
              ),
              tabs: <Tab>[
                Tab(text: AppLocalizations.of(context)!.expenses, height: 39.h),
                Tab(text: AppLocalizations.of(context)!.incomes, height: 39.h),
              ],
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
