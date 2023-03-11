import 'package:finance_manager/domain/entity/income.dart';
import 'package:finance_manager/my_icons_class/my_icons_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../session/session_id_manager.dart';
import '../charts/bar_chart_widget.dart';
import '../charts/pie_chart_widget.dart';
import '../expenses_page_widget/expenses_page_model.dart';
import '../settings_widgets/categories/add_category_widget_model.dart';
import 'incomes_page_model.dart';

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
  String? uUserId;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final userId = SessionIdManager.instance.readUserId();
      uUserId = await userId;
      final addCategoryWidgetModel =
          Provider.of<AddCategoryWidgetModel>(context, listen: false);
      await addCategoryWidgetModel.downloadCategories(context);
      await Provider.of<ExpensesPageModel>(context, listen: false)
          .setup(uUserId);
      await Provider.of<IncomesPageModel>(context, listen: false)
          .setup(uUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<IncomesPageModel>(context, listen: true);
    final user = FirebaseAuth.instance.currentUser!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          Text('Logged in as ${user.email!}'),
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
                    onPressed: () {}, //model.showDateChangeDialog(context),
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
              child: _IncomesListViewWidget(
                incomes: model.listOfShortenIncomes,
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

class _IncomesListViewWidget extends StatelessWidget {
  final List<Income> incomes;
  final String? userId;
  const _IncomesListViewWidget({
    Key? key,
    required this.incomes,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: incomes.length,
      itemBuilder: (BuildContext context, int index) {
        return _IncomesListTileWidget(
          incomes: incomes,
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

class _IncomesListTileWidget extends StatelessWidget {
  final List<Income> incomes;
  final int index;
  final String? userId;
  const _IncomesListTileWidget({
    required this.incomes,
    required this.index,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<IncomesPageModel>(context);
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
                  int.parse(model.findCategory(incomes[index].category).color)),
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
          "${incomes[index].price.toInt().toString()} ₸",
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
    );
  }
}
