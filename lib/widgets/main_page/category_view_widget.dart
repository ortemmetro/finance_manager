import 'package:finance_manager/entity/category.dart';
import 'package:finance_manager/entity/expense.dart';
import 'package:finance_manager/entity/income.dart';
import 'package:finance_manager/widgets/add_widget/add_widget_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/income_page_widget/incomes_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../session/session_id_manager.dart';
import '../expenses_page_widget/expenses_page_widget.dart';
import '../income_page_widget/income_page_widget.dart';

class CategoryViewWidget extends StatelessWidget {
  const CategoryViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final addModel = Provider.of<AddWidgetModel>(context, listen: true);
    final expenseModel = Provider.of<ExpensesPageModel>(context, listen: true);
    final incomeModel = Provider.of<IncomesPageModel>(context, listen: true);
    final sessionIdModel =
        Provider.of<SessionIdManager>(context, listen: false);
    final userId = sessionIdModel.readUserId();
    var arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments.runtimeType == ExpenseInfo) {
      arguments = arguments as ExpenseInfo;
      List<Expense> listOfExpensesOfCurrentCategory = [];
      for (var i = 0; i < expenseModel.listOfALLALLExpenses.length; i++) {
        if (expenseModel.listOfALLALLExpenses[i].category ==
            arguments.category) {
          listOfExpensesOfCurrentCategory
              .add(expenseModel.listOfALLALLExpenses[i]);
        }
      }
      final category = listOfExpensesOfCurrentCategory.isNotEmpty
          ? expenseModel
              .findCategory(listOfExpensesOfCurrentCategory[0].category)
          : null;

      return Scaffold(
        appBar: AppBar(
          title: Text(category == null ? "Null" : category.name),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10.0.h),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: listOfExpensesOfCurrentCategory.length,
                  itemBuilder: (context, index) {
                    return _ListTileInfoWidget(
                      expenseOrIncome: listOfExpensesOfCurrentCategory[index],
                      iconsMap: addModel.iconsMap,
                      listOfCategories: addModel.listOfCategories,
                      category: category,
                      expenseModel: expenseModel,
                      userId: userId,
                      listOfExpensesOrIncomesOfCurrentCategory:
                          listOfExpensesOfCurrentCategory,
                      navigatorContext: context,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 1.5,
                      height: 1,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      arguments = arguments as IncomeInfo;
      List<Income> listOfIncomesOfCurrentCategory = [];
      for (var i = 0; i < incomeModel.listOfALLALLIncomes.length; i++) {
        if (incomeModel.listOfALLALLIncomes[i].category == arguments.category) {
          listOfIncomesOfCurrentCategory
              .add(incomeModel.listOfALLALLIncomes[i]);
        }
      }
      final category = listOfIncomesOfCurrentCategory.isNotEmpty
          ? incomeModel.findCategory(listOfIncomesOfCurrentCategory[0].category)
          : null;

      return Scaffold(
        appBar: AppBar(
          title: Text(category == null ? "Null" : category.name),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10.0.h),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: listOfIncomesOfCurrentCategory.length,
                  itemBuilder: (context, index) {
                    return _ListTileInfoWidget(
                      expenseOrIncome: listOfIncomesOfCurrentCategory[index],
                      iconsMap: addModel.iconsMap,
                      listOfCategories: addModel.listOfCategories,
                      category: category,
                      expenseModel: expenseModel,
                      userId: userId,
                      listOfExpensesOrIncomesOfCurrentCategory:
                          listOfIncomesOfCurrentCategory,
                      navigatorContext: context,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 1.5,
                      height: 1,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class _ListTileInfoWidget extends StatelessWidget {
  const _ListTileInfoWidget({
    Key? key,
    required this.expenseOrIncome,
    required this.iconsMap,
    required this.listOfCategories,
    required this.category,
    required this.expenseModel,
    required this.userId,
    required this.listOfExpensesOrIncomesOfCurrentCategory,
    required this.navigatorContext,
  }) : super(key: key);
  final dynamic expenseOrIncome;
  final Map<String, IconData> iconsMap;
  final List<Category> listOfCategories;
  final Category? category;
  final ExpensesPageModel expenseModel;
  final Future<String?> userId;
  final List<dynamic> listOfExpensesOrIncomesOfCurrentCategory;
  final BuildContext navigatorContext;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat.MMMMEEEEd("ru");
    final dateString = format.format(expenseOrIncome.date);
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) async {
              await expenseModel.deleteExpense(
                expenseOrIncome.id,
                context,
                await userId,
              );
              if (listOfExpensesOrIncomesOfCurrentCategory.length == 1) {
                Navigator.of(navigatorContext).pop();
              }
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Удалить',
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          margin: const EdgeInsets.all(1.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(
                  int.parse(category == null ? "fx0060b5f3" : category!.color)),
              shape: BoxShape.circle,
            ),
            child: Icon(
              category == null ? Icons.done : iconsMap[category!.icon],
              size: 35,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          expenseOrIncome.comment!,
          style: TextStyle(
            color: Color.fromARGB(255, 83, 83, 83),
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          dateString,
        ),
        trailing: Text(
          "${expenseOrIncome.price.toInt()} ₸",
          style: TextStyle(
            color: const Color.fromARGB(255, 83, 83, 83),
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
