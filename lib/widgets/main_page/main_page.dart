import 'package:finance_manager/widgets/drawer_widget/drawer_widget_model.dart';
import 'package:finance_manager/widgets/income_page_widget/income_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_custom.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:provider/provider.dart';
import '../drawer_widget/drawer_widget.dart';
import '../expenses_page_widget/expenses_page_model.dart';
import '../expenses_page_widget/expenses_page_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final model = ExpensesPageModel();
  final tab = TabBar(
    unselectedLabelColor: const Color.fromARGB(255, 232, 232, 232),
    labelColor: Colors.black,
    indicator: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.white,
        width: 2.0.w,
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    labelStyle: TextStyle(
      fontSize: 15.5.sp,
      fontWeight: FontWeight.w500,
    ),
    tabs: <Tab>[
      Tab(text: 'Расходы', height: 39.h),
      Tab(text: 'Доходы', height: 39.h),
    ],
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await initializeDateFormatting('ru', null);
      await Provider.of<DrawerWidgetModel>(context, listen: false)
          .getUserInfo(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _AppBarWidget(tab: tab),
        drawer: DrawerWidget(),
        body: const TabBarView(
          children: [
            ExpensesPageWidget(),
            IncomePageWidget(),
          ],
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const _AppBarWidget({
    Key? key,
    required this.tab,
  }) : super(key: key);

  final TabBar tab;

  @override
  Widget build(BuildContext context) {
    final expenseModel = Provider.of<ExpensesPageModel>(context, listen: true);
    return AppBar(
      toolbarHeight: 68.0.h,
      backgroundColor: const Color.fromARGB(255, 93, 176, 117),
      title: Text(
        'Итого: -${expenseModel.sum}₸',
        style: TextStyle(fontSize: 20.sp),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: tab.preferredSize,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            side: BorderSide(
              color: Colors.white,
              width: 2.5.w,
            ),
          ),
          elevation: 0.h,
          color: Theme.of(context).primaryColor,
          child: tab,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 60.0.h);
}
