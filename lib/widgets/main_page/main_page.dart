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
      appBar: _AppBarWidget(tab: tab),
      drawer: const _DrawerWidget(),
      body: const TabBarView(
        children: [
          ExpensesPageWidget(),
          IncomePageWidget(),
        ],
      ),
    );
  }
}

class _DrawerWidget extends StatelessWidget {
  const _DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 35),
          const _UserTileWidget(),
          const Divider(thickness: 2.0),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: Icon(Icons.computer),
                  title: Text('Hello'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _UserTileWidget extends StatelessWidget {
  const _UserTileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text(
        'Артём Руппель',
        style: TextStyle(fontSize: 17),
      ),
      subtitle: Text(
        'Остаток: \$999',
        style: TextStyle(fontSize: 17),
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        radius: 25,
        child: CircleAvatar(
          radius: 22.75,
          backgroundImage: AssetImage(
            'images/user_image.jpg',
          ),
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
