import 'package:finance_manager/widgets/drawer_widget/drawer_widget.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_widget.dart';
import 'package:finance_manager/widgets/income_page_widget/income_page_widget.dart';
import 'package:finance_manager/widgets/income_page_widget/incomes_page_model.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _AppBarWidget(
          tab: TabBar(
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
              Tab(text: AppLocalizations.of(context)!.expenses, height: 39.h),
              Tab(text: AppLocalizations.of(context)!.incomes, height: 39.h),
            ],
          ),
        ),
        drawer: const DrawerWidget(),
        body: const TabBarView(
          children: [
            ExpensesPageWidget(),
            IncomesPageWidget(),
          ],
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarWidget({
    required this.tab,
    super.key,
  });

  final TabBar tab;

  @override
  Widget build(BuildContext context) {
    final expenseModel = Provider.of<ExpensesPageModel>(context, listen: true);
    final incomeModel = Provider.of<IncomesPageModel>(context, listen: true);
    final currenycModel = Provider.of<CurrencyModel>(context, listen: true);
    final sum = expenseModel.sumWithSpaces(
      (incomeModel.doubleSum.toInt() - expenseModel.doubleSum.toInt())
          .toDouble(),
    );
    return AppBar(
      toolbarHeight: 68.0.h,
      backgroundColor: const Color.fromARGB(255, 93, 176, 117),
      title: Text(
        '${AppLocalizations.of(context)!.total}: $sum${currenycModel.currentCurrency}',
        style: TextStyle(fontSize: 20.sp),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: tab.preferredSize,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
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
