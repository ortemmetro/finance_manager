import 'package:finance_manager/widgets/drawer_widget/drawer_widget_model.dart';
import 'package:finance_manager/widgets/settings_widgets/rate_the_app/rate_the_app_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);

  final drawerTileList = <DrawerIconTextFunction>[
    DrawerIconTextFunction(
      icon: const Icon(Icons.home),
      text: 'Главная',
      onTap: (BuildContext context) =>
          Navigator.of(context).pushNamed('/main_page'),
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.attach_money),
      text: 'Счета',
      onTap: (BuildContext context) =>
          Navigator.of(context).pushNamed('/main_page/invoices'),
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.auto_graph_outlined),
      text: 'Графики',
      onTap: (BuildContext context) =>
          Navigator.of(context).pushNamed('/main_page/charts'),
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.category),
      text: 'Категории',
      onTap: (BuildContext context) =>
          Navigator.of(context).pushNamed('/main_page/categories'),
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.money),
      text: 'Валюта',
      onTap: (BuildContext context) =>
          Navigator.of(context).pushNamed('/main_page/currency'),
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.settings),
      text: 'Настройки',
      onTap: (BuildContext context) =>
          Navigator.of(context).pushNamed('/main_page/settings'),
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.share),
      text: 'Поделиться с друзьями',
      onTap: null,
    ),
    DrawerIconTextFunction(
      icon: const Icon(Icons.star),
      text: 'Оценить приложение',
      onTap: (BuildContext context) async {
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return const RateTheAppDialog();
          },
        );
      },
    ),
  ];

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
              itemCount: drawerTileList.length,
              itemBuilder: (context, index) {
                final function = drawerTileList[index].onTap;
                return ListTile(
                  leading: drawerTileList[index].icon,
                  title: Text(drawerTileList[index].text),
                  onTap: () => function!(context),
                );
              },
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ListTile(
                  leading: Icon(Icons.door_front_door),
                  title: Text('Выйти'),
                  onTap: () => FirebaseAuth.instance.signOut(),
                ),
              ],
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
    final model = Provider.of<DrawerWidgetModel>(context);
    model.getUserInfo();
    return ListTile(
      title: Text(
        '${model.userName} ${model.userSurname}',
        style: const TextStyle(fontSize: 17),
      ),
      subtitle: const Text(
        'Остаток: \$999',
        style: TextStyle(fontSize: 17),
      ),
      leading: const CircleAvatar(
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
