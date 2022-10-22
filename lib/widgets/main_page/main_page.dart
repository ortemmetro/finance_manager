import 'package:finance_manager/widgets/income_page_widget/income_page_widget.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: const TabBarView(
        children: [
          ExpensesPageWidget(),
          IncomePageWidget(),
        ],
      ),
    );
  }
}
