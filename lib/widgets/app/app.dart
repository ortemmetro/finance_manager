import 'package:finance_manager/widgets/add_widget/add_widget.dart';
import 'package:finance_manager/widgets/drawer_widget/drawer_widget_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/categories_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/charts/charts_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/invoices/invoices_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/settings/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_page/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ExpensesPageModel()),
        ChangeNotifierProvider(create: (context) => DrawerWidgetModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 93, 176, 117),
          disabledColor: const Color.fromARGB(255, 232, 232, 232),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 93, 176, 117),
          ),
        ),
        routes: {
          'main_page': (context) => const MainPage(),
          'main_page/add': (context) => AddWidget(),
          'main_page/invoices': (context) => const InvoicesWidget(),
          'main_page/charts': (context) => const ChartsWidget(),
          'main_page/categories': (context) => const CategoriesWidget(),
          'main_page/currency': (context) => const CurrencyWidget(),
          'main_page/settings': (context) => const SettingsWidget(),
        },
        initialRoute: 'main_page',
      ),
    );
  }
}
