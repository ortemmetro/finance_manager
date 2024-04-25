import 'package:finance_manager/domain/entity/income.dart';
import 'package:finance_manager/my_icons_class/my_icons_class.dart';
import 'package:finance_manager/widgets/charts/bar_chart_widget.dart';
import 'package:finance_manager/widgets/charts/pie_chart_widget.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/income_page_widget/incomes_page_model.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class IncomeInfo {
  final List<Income> listOfIncomes;
  final String category;

  IncomeInfo({
    required this.listOfIncomes,
    required this.category,
  });
}

class IncomesPageWidget extends StatefulWidget {
  const IncomesPageWidget({super.key});

  @override
  State<IncomesPageWidget> createState() => _IncomesPageWidgetState();
}

class _IncomesPageWidgetState extends State<IncomesPageWidget>
    with AutomaticKeepAliveClientMixin<IncomesPageWidget> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<IncomesPageModel>(context, listen: true);
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
                        listOfExpensesOrIncomesSortedByDate:
                            model.sortIncomesByDate(model.listOfShortenIncomes),
                      ),
                Positioned(
                  bottom: 0.h,
                  right: 0.w,
                  child: RawMaterialButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/main_page/add'),
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
                      horizontal: 12.0.w,
                      vertical: 12.0.h,
                    ),
                    child: model.isPieChart
                        ? Icon(
                            MyIconsClass.bar_graph_1214113,
                            size: 25.r,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.pie_chart_outline,
                            size: 25.r,
                            color: Colors.white,
                          ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: TextButton(
                    onPressed: () => model.showDateChangeDialog(context),
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(0)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          model.selectedPeriod ?? '',
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
              child: _IncomesListViewWidget(
                incomes: model.listOfShortenIncomes,
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

class _IncomesListViewWidget extends StatelessWidget {
  final List<Income> incomes;
  const _IncomesListViewWidget({
    required this.incomes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: incomes.length,
      itemBuilder: (BuildContext context, int index) {
        return _IncomesListTileWidget(
          incomes: incomes,
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

class _IncomesListTileWidget extends StatelessWidget {
  final List<Income> incomes;
  final int index;
  const _IncomesListTileWidget({
    required this.incomes,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<IncomesPageModel>(context);
    final expenseModel = Provider.of<ExpensesPageModel>(context);
    final currenycModel = Provider.of<CurrencyModel>(context, listen: true);
    return ListTile(
      onTap: () {
        final arguments = IncomeInfo(
          category: incomes[index].category,
          listOfIncomes: model.listOfAllIncomes,
        );
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
              color: Color(
                int.parse(model.findCategory(incomes[index].category).color),
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
      title: Text(
        incomes[index].category.toString(),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
        ),
      ),
      trailing: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Text(
          '${expenseModel.sumWithSpaces(incomes[index].price)}${currenycModel.currentCurrency}',
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
    );
  }
}
