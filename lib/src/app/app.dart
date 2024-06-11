import 'package:finance_manager/domain/locale_model/locale_model.dart';
import 'package:finance_manager/l10n/l10n.dart';
import 'package:finance_manager/src/app/scope_provider.dart';
import 'package:finance_manager/src/features/authentication/presentation/pages/authentication_page.dart';
import 'package:finance_manager/src/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:finance_manager/widgets/add_widget/add_widget.dart';
import 'package:finance_manager/widgets/main_page/category_view_widget.dart';
import 'package:finance_manager/widgets/main_page/main_page.dart';
import 'package:finance_manager/widgets/settings_widgets/accounts/accounts_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/accounts/add_account_page.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/all_categories_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/categories_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/category_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/settings/languages_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/settings/settings_widget.dart';
import 'package:finance_manager/widgets/startup_page/startup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    //width of design is 393,
    //height is 803
    return ScopeProvider(
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: false,
            primaryColor: const Color.fromARGB(255, 93, 176, 117),
            disabledColor: const Color.fromARGB(255, 232, 232, 232),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 93, 176, 117),
            ),
          ),
          routes: {
            '/start': (context) => const StartupPage(),
            '/': (context) => const AuthenticationPage(),
            '/sign_up': (context) => const SignUpPage(),
            '/main_page': (context) => const MainPage(),
            '/main_page/category_view': (context) => const CategoryViewWidget(),
            '/main_page/add': (context) => const AddWidget(),
            '/main_page/accounts': (context) => const AccountsWidget(),
            '/main_page/accounts/add': (context) => AddAccountPage(),
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
          initialRoute: '/start',
          locale: Provider.of<LocaleModel>(context).locale,
          supportedLocales: L10n.all,
          localizationsDelegates: const [
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
