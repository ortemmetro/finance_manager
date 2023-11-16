import 'package:finance_manager/domain/entity/expense.dart';
import 'package:finance_manager/my_icons_class/my_icons_class.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../charts/bar_chart_widget.dart';
import '../charts/pie_chart_widget.dart';

class ExpenseInfo {
  final List<Expense> listOfExpenses;
  final String category;

  ExpenseInfo({
    required this.listOfExpenses,
    required this.category,
  });
}

class ExpensesPageWidget extends StatefulWidget {
  const ExpensesPageWidget({super.key});

  @override
  State<ExpensesPageWidget> createState() => _ExpensesPageWidgetState();
}

class _ExpensesPageWidgetState extends State<ExpensesPageWidget>
    with AutomaticKeepAliveClientMixin<ExpensesPageWidget> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ExpensesPageModel>(context, listen: true);
    final selectedString = AppLocalizations.of(context)!.allTime;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          SizedBox(
            width: 392.7.w,
            height: model.isPieChart ? 220.h : 310.h,
            child: Stack(
              children: [
                model.isPieChart
                    ? PieChartWidget(
                        dataMap: model.dataMap,
                        listOfColors: model.listOfColors,
                        sum: model.sum,
                      )
                    : BarChartWidget(
                        findCategory: model.findCategory,
                        listOfExpensesOrIncomesSortedByDate: model
                            .sortExpensesByDate(model.listOfShortenExpenses),
                      ),
                Positioned(
                  bottom: 0.h,
                  right: 0.w,
                  child: RawMaterialButton(
                    onPressed: () => Navigator.of(context).pushNamed(
                      '/main_page/add',
                      arguments: ExpenseInfo(
                        listOfExpenses: [],
                        category: "expense",
                      ),
                    ),
                    fillColor: const Color.fromARGB(255, 93, 176, 117),
                    shape: const CircleBorder(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0.w,
                      vertical: 12.0.h,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 25.r,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 0.w,
                  bottom: 0.h,
                  child: RawMaterialButton(
                    onPressed: () => model.changePieToBar(),
                    fillColor: const Color.fromARGB(255, 93, 176, 117),
                    shape: const CircleBorder(),
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.0.w, vertical: 12.0.h),
                    child: model.isPieChart
                        ? Icon(MyIconsClass.bar_graph_1214113,
                            size: 25.r, color: Colors.white)
                        : Icon(Icons.pie_chart_outline,
                            size: 25.r, color: Colors.white),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: TextButton(
                    onPressed: () => model.showDateChangeDialog(context),
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          model.selectedPeriod ?? "",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15.sp,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.green,
                          size: 24.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: Scrollbar(
              child: _ExpensesListViewWidget(
                expenses: model.listOfShortenExpenses,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ExpensesListViewWidget extends StatelessWidget {
  final List<Expense> expenses;
  const _ExpensesListViewWidget({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: expenses.length,
      itemBuilder: (BuildContext context, int index) {
        return _ExpensesListTileWidget(
          expenses: expenses,
          index: index,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          indent: 10.w,
          endIndent: 10.w,
          thickness: 1.5.h,
          height: 1.h,
        );
      },
    );
  }
}

class _ExpensesListTileWidget extends StatelessWidget {
  final List<Expense> expenses;
  final int index;
  const _ExpensesListTileWidget({
    required this.expenses,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ExpensesPageModel>(context);
    final currenycModel = Provider.of<CurrencyModel>(context, listen: true);
    return ListTile(
      onTap: () {
        final arguments = ExpenseInfo(
            category: expenses[index].category,
            listOfExpenses: model.listOfAllExpenses);
        Navigator.of(context).pushNamed(
          '/main_page/category_view',
          arguments: arguments,
        );
      },
      dense: false,
      minLeadingWidth: 25.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: SizedBox(
          height: double.infinity,
          child: Container(
            width: 19.w,
            height: 19.h,
            decoration: BoxDecoration(
              color: Color(int.parse(
                  model.findCategory(expenses[index].category).color)),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
      title: Text(
        expenses[index].category.toString(),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
        ),
      ),
      trailing: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Text(
          "${model.sumWithSpaces(expenses[index].price)}${currenycModel.currentCurrency}",
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
    );
  }
}
