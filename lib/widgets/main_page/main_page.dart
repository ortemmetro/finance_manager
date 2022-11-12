import 'package:finance_manager/widgets/income_page_widget/income_page_widget.dart';
import 'package:flutter/material.dart';
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
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    labelStyle: const TextStyle(
      fontSize: 15.5,
      fontWeight: FontWeight.w500,
    ),
    tabs: const <Tab>[
      Tab(text: 'Расходы', height: 39),
      Tab(text: 'Доходы', height: 39),
    ],
  );

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
    return AppBar(
      toolbarHeight: 68.0,
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
              width: 2.5,
            ),
          ),
          elevation: 0,
          color: Theme.of(context).primaryColor,
          child: tab,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 60.0);
}
