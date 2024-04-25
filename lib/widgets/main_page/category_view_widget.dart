import 'package:finance_manager/domain/entity/category.dart';
import 'package:finance_manager/domain/entity/expense.dart';
import 'package:finance_manager/domain/entity/income.dart';
import 'package:finance_manager/src/core/session/session_id_manager.dart';
import 'package:finance_manager/widgets/add_widget/add_widget_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_widget.dart';
import 'package:finance_manager/widgets/income_page_widget/income_page_widget.dart';
import 'package:finance_manager/widgets/income_page_widget/incomes_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CategoryViewWidget extends StatelessWidget {
  const CategoryViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final addModel = Provider.of<AddWidgetModel>(context, listen: true);
    final expenseModel = Provider.of<ExpensesPageModel>(context, listen: true);
    final incomeModel = Provider.of<IncomesPageModel>(context, listen: true);
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
          title: Text(category == null ? 'Null' : category.name),
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
                      listOfExpensesOrIncomesOfCurrentCategory:
                          listOfExpensesOfCurrentCategory,
                      navigatorContext: context,
                      incomeModel: incomeModel,
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
          title: Text(category == null ? 'Null' : category.name),
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
                      listOfExpensesOrIncomesOfCurrentCategory:
                          listOfIncomesOfCurrentCategory,
                      navigatorContext: context,
                      incomeModel: incomeModel,
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
    required this.expenseOrIncome,
    required this.iconsMap,
    required this.listOfCategories,
    required this.category,
    required this.expenseModel,
    required this.listOfExpensesOrIncomesOfCurrentCategory,
    required this.navigatorContext,
    required this.incomeModel,
  });
  final dynamic expenseOrIncome;
  final Map<String, IconData> iconsMap;
  final List<Category> listOfCategories;
  final Category? category;
  final ExpensesPageModel expenseModel;
  final IncomesPageModel incomeModel;
  final List<dynamic> listOfExpensesOrIncomesOfCurrentCategory;
  final BuildContext navigatorContext;

  @override
  Widget build(BuildContext context) {
    final format =
        DateFormat.MMMMEEEEd(Localizations.localeOf(context).toString());
    final dateString = format.format(expenseOrIncome.date);
    final userId = SessionIdManager.instance.readUserId();
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) async {
              if (expenseOrIncome is Expense) {
                await expenseModel.deleteExpenseFromHive(expenseOrIncome);
                if (listOfExpensesOrIncomesOfCurrentCategory.length == 1) {
                  expenseModel.listOfALLALLExpenses.clear();
                  expenseModel.setALLExpenses(await userId);
                  await expenseModel.setup(await userId);
                  Navigator.of(navigatorContext).pop();
                  return;
                }
                expenseModel.listOfALLALLExpenses.clear();
                expenseModel.setALLExpenses(await userId);
                await expenseModel.setup(await userId);
              } else if (expenseOrIncome is Income) {
                await incomeModel.deleteIncomeFromHive(expenseOrIncome);
                if (listOfExpensesOrIncomesOfCurrentCategory.length == 1) {
                  incomeModel.listOfALLALLIncomes.clear();
                  incomeModel.setALLIncomes(await userId);
                  await incomeModel.setup(await userId);
                  Navigator.of(navigatorContext).pop();
                  return;
                }
                incomeModel.listOfALLALLIncomes.clear();
                incomeModel.setALLIncomes(await userId);
                await incomeModel.setup(await userId);
              }
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete,
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
                int.parse(category == null ? 'fx0060b5f3' : category!.color),
              ),
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
          style: const TextStyle(
            color: Color.fromARGB(255, 83, 83, 83),
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          dateString,
        ),
        trailing: Text(
          '${expenseOrIncome.price.toInt()} ₸',
          style: TextStyle(
            color: const Color.fromARGB(255, 83, 83, 83),
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
