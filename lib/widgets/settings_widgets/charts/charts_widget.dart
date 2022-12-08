import 'package:flutter/material.dart';

import '../../drawer_widget/drawer_widget.dart';

class ChartsWidget extends StatelessWidget {
  const ChartsWidget({super.key});

  final tab = const TabBar(
    indicatorColor: Colors.transparent,
    unselectedLabelColor: Color.fromARGB(255, 232, 232, 232),
    tabs: <Tab>[
      Tab(text: 'Общий'),
      Tab(text: 'Расходы'),
      Tab(text: 'Доходы'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          title: const Text('Графики'),
          centerTitle: true,
          toolbarHeight: 70,
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
      ),
    );
  }
}
