import 'package:finance_manager/l10n/l10n.dart';
import 'package:finance_manager/session/session_id_model.dart';
import 'package:finance_manager/widgets/add_widget/add_widget.dart';
import 'package:finance_manager/widgets/add_widget/add_widget_model.dart';
import 'package:finance_manager/widgets/auth/auth_widget.dart';
import 'package:finance_manager/widgets/auth/auth_widget_model.dart';
import 'package:finance_manager/widgets/auth/sign_up_widget.dart';
import 'package:finance_manager/widgets/auth/sign_up_widget_model.dart';
import 'package:finance_manager/widgets/drawer_widget/drawer_widget_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/income_page_widget/incomes_page_model.dart';
import 'package:finance_manager/widgets/main_page/category_view_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/all_categories_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/categories_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/category_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/charts/charts_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:finance_manager/widgets/settings_widgets/invoices/invoices_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/settings/languages_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/settings/languages_widget_model.dart';
import 'package:finance_manager/widgets/settings_widgets/settings/settings_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main_page/main_page.dart';
import '../settings_widgets/categories/add_category_widget.dart';
import '../settings_widgets/categories/add_category_widget_model.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    //width of design is 393,
    //height is 803
    return MultiProvider(
      providers: [
        Provider(create: (context) => SessionIdModel()),
        ChangeNotifierProvider(create: (context) => ExpensesPageModel()),
        ChangeNotifierProvider(create: (context) => IncomesPageModel()),
        ChangeNotifierProvider(create: (context) => DrawerWidgetModel()),
        Provider(create: (context) => AuthWidgetModel()),
        ChangeNotifierProvider(create: (context) => SignUpWidgetModel()),
        Provider(create: (context) => CurrencyWidgetModel()),
        ChangeNotifierProvider(create: (context) => AddCategoryWidgetModel()),
        ChangeNotifierProvider(
            create: (context) => AddWidgetModel(
                  Provider.of<ExpensesPageModel>(context, listen: false),
                  Provider.of<IncomesPageModel>(context, listen: false),
                )),
        ChangeNotifierProvider(
            create: (BuildContext context) => LanguagesWidgetModel()),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
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
            '/main_page/category_view': (context) => const CategoryViewWidget(),
            '/main_page/add': (context) => const AddWidget(),
            '/main_page/invoices': (context) => const InvoicesWidget(),
            '/main_page/charts': (context) => const ChartsWidget(),
            '/main_page/categories': (context) => const CategoriesWidget(),
            '/main_page/categories/add': (context) => const AddCategoryWidget(),
            '/main_page/categories/one_category': (context) =>
                const CategoryWidget(),
            '/main_page/categories/add/all_categories': (context) =>
                const AllCategoriesWidget(),
            '/main_page/currency': (context) => const CurrencyWidget(),
            '/main_page/settings': (context) => const SettingsWidget(),
            '/main_page/settings/language': (context) =>
                const LanguagesWidget(),
          },
          initialRoute: '/',
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        ),
        designSize: const Size(393, 803),
      ),
    );
  }
}
