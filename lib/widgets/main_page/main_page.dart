import 'package:finance_manager/widgets/income_page_widget/income_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../add_widget/add_widget_model.dart';
import '../drawer_widget/drawer_widget.dart';
import '../expenses_page_widget/expenses_page_model.dart';
import '../expenses_page_widget/expenses_page_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final tab = const TabBar(
    indicatorColor: Colors.transparent,
    unselectedLabelColor: Color.fromARGB(255, 232, 232, 232),
    tabs: <Tab>[
      Tab(text: 'Расходы'),
      Tab(text: 'Доходы'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _AppBarWidget(tab: tab),
        drawer: DrawerWidget(),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider<ExpensesPageModel>(
                create: (_) => ExpensesPageModel()),
            ChangeNotifierProvider<AddWidgetModel>(
                create: (_) => AddWidgetModel()),
          ],
          child: const TabBarView(
            children: [
              ExpensesPageWidget(),
              IncomePageWidget(),
            ],
          ),
        ),
        //TabBarView(
        //   children: [

        //     ChangeNotifierProvider(
        //       create: (context) => ExpensesPageModel(),
        //       child: const ExpensesPageWidget(),
        //     ),
        //     IncomePageWidget(),
        //   ],
        // ),
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
    return AppBar(
      toolbarHeight: 70.0,
      backgroundColor: const Color.fromARGB(255, 93, 176, 117),
      title: const Text('Итого: \$999'),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: tab.preferredSize,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            side: BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          elevation: 26.0,
          color: Theme.of(context).primaryColor,
          child: tab,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 65.0);
}
