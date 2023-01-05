import 'package:finance_manager/entity/category.dart';
import 'package:finance_manager/entity/expense.dart';
import 'package:finance_manager/widgets/add_widget/add_widget_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../session/session_id_model.dart';
import '../expenses_page_widget/expenses_page_widget.dart';

class CategoryViewWidget extends StatelessWidget {
  const CategoryViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final addModel = Provider.of<AddWidgetModel>(context, listen: true);
    final expenseModel = Provider.of<ExpensesPageModel>(context, listen: true);
    final sessionIdModel = Provider.of<SessionIdModel>(context, listen: false);
    final userId = sessionIdModel.readUserId("uid");
    List<Expense> listOfExpensesOfCurrentCategory = [];
    final arguments = ModalRoute.of(context)!.settings.arguments as ExpenseInfo;
    for (var i = 0; i < expenseModel.listOfALLALLExpenses.length; i++) {
      if (expenseModel.listOfALLALLExpenses[i].category == arguments.category) {
        listOfExpensesOfCurrentCategory
            .add(expenseModel.listOfALLALLExpenses[i]);
      }
    }
    if (listOfExpensesOfCurrentCategory.isNotEmpty) {}
    final category = listOfExpensesOfCurrentCategory.isNotEmpty
        ? expenseModel.findCategory(listOfExpensesOfCurrentCategory[0].category)
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
                    expense: listOfExpensesOfCurrentCategory[index],
                    iconsMap: addModel.iconsMap,
                    listOfCategories: addModel.listOfCategories,
                    category: category,
                    expenseModel: expenseModel,
                    userId: userId,
                    listOfExpensesOfCurrentCategory:
                        listOfExpensesOfCurrentCategory,
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

class _ListTileInfoWidget extends StatelessWidget {
  const _ListTileInfoWidget({
    Key? key,
    required this.expense,
    required this.iconsMap,
    required this.listOfCategories,
    required this.category,
    required this.expenseModel,
    required this.userId,
    required this.listOfExpensesOfCurrentCategory,
  }) : super(key: key);
  final Expense expense;
  final Map<String, IconData> iconsMap;
  final List<Category> listOfCategories;
  final Category? category;
  final ExpensesPageModel expenseModel;
  final Future<String?> userId;
  final List<Expense> listOfExpensesOfCurrentCategory;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat.MMMMEEEEd("ru");
    final dateString = format.format(expense.date);
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) async {
              await expenseModel.deleteExpense(
                expense.id,
                context,
                await userId,
              );
              if (listOfExpensesOfCurrentCategory.length == 1) {
                Navigator.pop(context);
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
          expense.comment!,
          style: TextStyle(
            color: Color.fromARGB(255, 83, 83, 83),
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          dateString,
        ),
        trailing: Text(
          "${expense.price.toInt()} ₸",
          style: TextStyle(
            color: Color.fromARGB(255, 83, 83, 83),
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
