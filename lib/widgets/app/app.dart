import 'package:finance_manager/session/session_id_model.dart';
import 'package:finance_manager/widgets/add_widget/add_widget.dart';
import 'package:finance_manager/widgets/auth/auth_widget.dart';
import 'package:finance_manager/widgets/auth/auth_widget_model.dart';
import 'package:finance_manager/widgets/auth/sign_up_widget.dart';
import 'package:finance_manager/widgets/auth/sign_up_widget_model.dart';
import 'package:finance_manager/widgets/drawer_widget/drawer_widget_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/categories_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/charts/charts_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:finance_manager/widgets/settings_widgets/invoices/invoices_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/settings/settings_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_page/main_page.dart';
import '../settings_widgets/categories/add_category_widget.dart';
import '../settings_widgets/categories/add_category_widget_model.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => SessionIdModel()),
        ChangeNotifierProvider(create: (context) => ExpensesPageModel()),
        ChangeNotifierProvider(create: (context) => DrawerWidgetModel()),
        Provider(create: (context) => AuthWidgetModel()),
        ChangeNotifierProvider(create: (context) => SignUpWidgetModel()),
        Provider(create: (context) => CurrencyWidgetModel()),
        ChangeNotifierProvider(create: (context) => AddCategoryWidgetModel()),
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
          '/': (context) => StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Что-то пошло не так!'));
                  } else if (snapshot.hasData) {
                    return const MainPage();
                  } else {
                    return const AuthWidget();
                  }
                },
              ),
          '/sign_up': (context) => const SignUpWidget(),
          '/main_page': (context) => const MainPage(),
          '/main_page/add': (context) => const AddWidget(),
          '/main_page/invoices': (context) => const InvoicesWidget(),
          '/main_page/charts': (context) => const ChartsWidget(),
          '/main_page/categories': (context) => CategoriesWidget(),
          '/main_page/categories/add': (context) => const AddCategoryWidget(),
          '/main_page/currency': (context) => const CurrencyWidget(),
          '/main_page/settings': (context) => const SettingsWidget(),
        },
        initialRoute: '/',
      ),
    );
  }
}
