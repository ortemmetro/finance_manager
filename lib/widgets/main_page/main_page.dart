import 'package:finance_manager/widgets/income_page_widget/income_page_widget.dart';
import 'package:flutter/material.dart';

import '../expenses_page_widget/expenses_page_widget.dart';

class DrawerIconTextFunction {
  final Icon icon;
  final String text;
  final Function? onTap;

  DrawerIconTextFunction({
    required this.icon,
    required this.text,
    required this.onTap,
  });
}

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

  final drawerTileList = <DrawerIconTextFunction>[
    DrawerIconTextFunction(
      icon: const Icon(Icons.home),
      text: 'Главная',
      onTap: null,
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.attach_money),
      text: 'Счета',
      onTap: (BuildContext context) =>
          Navigator.of(context).pushNamed('main_page/invoices'),
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.auto_graph_outlined),
      text: 'Графики',
      onTap: null,
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.category),
      text: 'Категории',
      onTap: null,
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.money),
      text: 'Валюта',
      onTap: null,
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.settings),
      text: 'Настройки',
      onTap: null,
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.share),
      text: 'Поделиться с друзьями',
      onTap: null,
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.star),
      text: 'Оценить приложение',
      onTap: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBarWidget(tab: tab),
      drawer: _DrawerWidget(itemList: drawerTileList),
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
  final List<DrawerIconTextFunction> itemList;
  const _DrawerWidget({
    Key? key,
    required this.itemList,
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
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                final function = itemList[index].onTap;
                return ListTile(
                  leading: itemList[index].icon,
                  title: Text(itemList[index].text),
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
