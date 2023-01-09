import 'package:finance_manager/widgets/drawer_widget/drawer_widget_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/settings_widgets/rate_the_app/rate_the_app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      icon: Icon(Icons.home, size: 28.w),
      text: 'Главная',
      onTap: (BuildContext context) =>
          Navigator.of(context).pushNamed('/main_page'),
    ),
    DrawerIconTextFunction(
      icon: Icon(Icons.attach_money, size: 28.w),
      text: 'Счета',
      onTap: (BuildContext context) =>
          Navigator.of(context).pushNamed('/main_page/invoices'),
    ),
    DrawerIconTextFunction(
      icon: Icon(Icons.auto_graph_outlined, size: 28.w),
      text: 'Графики',
      onTap: (BuildContext context) =>
          Navigator.of(context).pushNamed('/main_page/charts'),
    ),
    DrawerIconTextFunction(
      icon: Icon(Icons.category, size: 28.w),
      text: 'Категории',
      onTap: (BuildContext context) =>
          Navigator.of(context).pushNamed('/main_page/categories'),
    ),
    DrawerIconTextFunction(
      icon: Icon(Icons.money, size: 28.w),
      text: 'Валюта',
      onTap: (BuildContext context) =>
          Navigator.of(context).pushNamed('/main_page/currency'),
    ),
    DrawerIconTextFunction(
      icon: Icon(Icons.settings, size: 28.w),
      text: 'Настройки',
      onTap: (BuildContext context) =>
          Navigator.of(context).pushNamed('/main_page/settings'),
    ),
    DrawerIconTextFunction(
      icon: Icon(Icons.share, size: 28.w),
      text: 'Поделиться с друзьями',
      onTap: null,
    ),
    DrawerIconTextFunction(
      icon: Icon(Icons.star, size: 28.w),
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
    final model = Provider.of<DrawerWidgetModel>(context);
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 20.h),
          const _UserTileWidget(),
          Divider(thickness: 2.0.w),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 1.h),
              itemCount: drawerTileList.length,
              itemBuilder: (context, index) {
                final function = drawerTileList[index].onTap;
                return ListTile(
                  dense: true,
                  minVerticalPadding: 17.h,
                  leading: drawerTileList[index].icon,
                  title: Text(
                    drawerTileList[index].text,
                    style: TextStyle(fontSize: 14.5.sp),
                  ),
                  onTap: () => function!(context),
                );
              },
            ),
          ),
          SizedBox(
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ListTile(
                  leading: Icon(Icons.door_front_door, size: 28.w),
                  title: Text(
                    'Выйти',
                    style: TextStyle(fontSize: 14.5.sp),
                  ),
                  onTap: () {
                    model.signOut();
                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
                  },
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
    final expenseModel = Provider.of<ExpensesPageModel>(context, listen: true);
    if (model.userName == "" || model.userSurname == "") {
      model.getUserInfo(context);
    }
    return ListTile(
      title: Text(
        '${model.userName} ${model.userSurname}',
        style: TextStyle(fontSize: 17.5.sp),
      ),
      subtitle: Text('Итого: -${expenseModel.sum}₸',
          style: TextStyle(fontSize: 16.5.sp)),
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        radius: 25.w,
        child: CircleAvatar(
          radius: 22.75.w,
          backgroundImage: const AssetImage('images/user_image.jpg'),
        ),
      ),
    );
  }
}
