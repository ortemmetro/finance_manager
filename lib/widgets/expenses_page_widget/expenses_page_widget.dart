import 'package:finance_manager/default_data/default_categories_data.dart';
import 'package:finance_manager/my_icons_class/my_icons_class.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:provider/provider.dart';

import '../../entity/expense.dart';
import '../../session/session_id_model.dart';

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
  String? uUserId;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final sessionIdModel =
          Provider.of<SessionIdModel>(context, listen: false);
      final userId = sessionIdModel.readUserId("uid");
      uUserId = await userId;
      final addCategoryWidgetModel =
          Provider.of<AddCategoryWidgetModel>(context, listen: false);
      await addCategoryWidgetModel.downloadCategories(context);
      context.read<ExpensesPageModel>().setup(uUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ExpensesPageModel>(context, listen: true);
    final user = FirebaseAuth.instance.currentUser!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          Text('Logged in as ${user.email!}'),
          SizedBox(height: 20.h),
          SizedBox(
            width: 392.7.w,
            height: model.isPieChart ? 220.h : 310.h,
            child: Stack(
              children: [
                model.isPieChart
                    ? _PieChartWidget(model: model)
                    : BarChartWidget(model: model),
                Positioned(
                  bottom: 0.h,
                  right: 0.w,
                  child: RawMaterialButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/main_page/add'),
                    fillColor: const Color.fromARGB(255, 93, 176, 117),
                    shape: const CircleBorder(),
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.0.w, vertical: 12.0.h),
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
                          model.selectedPeriod,
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
                userId: uUserId,
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

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({
    super.key,
    required this.model,
  });
  final ExpensesPageModel model;

  @override
  Widget build(BuildContext context) {
    final newList = model.sortExpensesByDate(model.listOfShortenExpenses);
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.4,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  borderData: FlBorderData(
                    show: true,
                    border: const Border.symmetric(
                      horizontal: BorderSide(color: Color(0xFFececec)),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      drawBehindEverything: true,
                      sideTitles: SideTitles(
                        interval: 20000,
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString().length > 3
                                ? value.toInt().toString().substring(0, 2) + "K"
                                : value.toInt().toString(),
                            style: const TextStyle(
                              color: Color(0xFF606060),
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Icon(
                              DefaultCategoriesData.iconsMap[model
                                  .findCategory(newList[index].category)
                                  .icon],
                              color: Color(int.parse(model
                                  .findCategory(newList[index].category)
                                  .color)),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: const Color(0xFFececec),
                      strokeWidth: 1,
                    ),
                  ),
                  barGroups: newList
                      .map(
                        (data) => BarChartGroupData(
                          x: newList.indexOf(data),
                          barRods: [
                            BarChartRodData(
                              toY: data.price,
                              color: Color(int.parse(
                                  model.findCategory(data.category).color)),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PieChartWidget extends StatelessWidget {
  const _PieChartWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ExpensesPageModel model;

  @override
  Widget build(BuildContext context) {
    final sum = model.sum;
    return Center(
      child: SizedBox(
        height: 200.h,
        width: 200.w,
        child: pie.PieChart(
          centerText: '$sum ???',
          centerTextStyle: TextStyle(
            fontSize: 20.sp,
            foreground: null,
            backgroundColor: Colors.transparent,
            color: Colors.black,
          ),
          dataMap: model.dataMap.isEmpty
              ? <String, double>{"yes": 20.0}
              : model.dataMap,
          chartType: pie.ChartType.ring,
          colorList:
              model.listOfColors.isEmpty ? [Colors.grey] : model.listOfColors,
          ringStrokeWidth: 12.5.w,
          legendOptions: const pie.LegendOptions(showLegends: false),
          chartValuesOptions: const pie.ChartValuesOptions(
            chartValueBackgroundColor: Colors.transparent,
            showChartValues: false,
          ),
        ),
      ),
    );
  }
}

class _ExpensesListViewWidget extends StatelessWidget {
  final List<Expense> expenses;
  final String? userId;
  const _ExpensesListViewWidget({
    Key? key,
    required this.expenses,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: expenses.length,
      itemBuilder: (BuildContext context, int index) {
        return _ExpensesListTileWidget(
          expenses: expenses,
          index: index,
          userId: userId,
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
  final String? userId;
  const _ExpensesListTileWidget({
    required this.expenses,
    required this.index,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ExpensesPageModel>(context);
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
          "${expenses[index].price.toInt().toString()} ???",
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
    );
  }
}
