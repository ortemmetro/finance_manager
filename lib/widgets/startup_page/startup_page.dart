import 'package:finance_manager/domain/locale_model/locale_model.dart';
import 'package:finance_manager/session/session_id_manager.dart';
import 'package:finance_manager/widgets/drawer_widget/drawer_widget_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/income_page_widget/incomes_page_model.dart';
import 'package:finance_manager/widgets/settings_widgets/accounts/accounts_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_model.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:finance_manager/widgets/startup_page/startup_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // provider of model
      create: (context) => StartupModel(),
      child: const StartupView(),
    );
  }
}

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SessionIdManager.instance.readUserId(),
      builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            return const StartupLogicBuilder();
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            });
            return Scaffold(
              body: Center(
                child: SizedBox(
                  width: 40.w,
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: SizedBox(
                width: 40.w,
                child: const CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

class StartupLogicBuilder extends StatelessWidget {
  const StartupLogicBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final startupModel = Provider.of<StartupModel>(context, listen: false);
    final currencyModel = Provider.of<CurrencyModel>(context, listen: false);
    final expenseModel = Provider.of<ExpensesPageModel>(context, listen: false);
    final incomeModel = Provider.of<IncomesPageModel>(context, listen: false);
    final addCategoryModel =
        Provider.of<AddCategoryModel>(context, listen: false);
    final drawerModel = Provider.of<DrawerWidgetModel>(context, listen: false);
    final localeModel = Provider.of<LocaleModel>(context, listen: false);
    final accountsModel = Provider.of<AccountsModel>(context, listen: false);
    return FutureBuilder(
      future: startupModel.startupSetup(
        currencyModel: currencyModel,
        expenseModel: expenseModel,
        incomeModel: incomeModel,
        addCategoryModel: addCategoryModel,
        drawerModel: drawerModel,
        localeModel: localeModel,
        accountsModel: accountsModel,
        context: context,
      ),
      builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/main_page', (_) => false);
          });
          return Scaffold(
            body: Center(
              child: SizedBox(
                width: 40.w,
                child: const CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: SizedBox(
                width: 40.w,
                child: const CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
