import 'package:finance_manager/session/session_id_manager.dart';
import 'package:finance_manager/widgets/drawer_widget/drawer_widget_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/income_page_widget/incomes_page_model.dart';
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
    final startupModel = Provider.of<StartupModel>(context, listen: false);
    final currencyModel = Provider.of<CurrencyModel>(context, listen: false);
    final expenseModel = Provider.of<ExpensesPageModel>(context, listen: false);
    final incomeModel = Provider.of<IncomesPageModel>(context, listen: false);
    final addCategoryModel =
        Provider.of<AddCategoryModel>(context, listen: false);
    final drawerModel = Provider.of<DrawerWidgetModel>(context, listen: false);
    return FutureBuilder<List<dynamic>>(
      future: Future.wait<dynamic>([
        startupModel.startupSetup(
          currencyModel: currencyModel,
          expenseModel: expenseModel,
          incomeModel: incomeModel,
          addCategoryModel: addCategoryModel,
          drawerModel: drawerModel,
          context: context,
        ),
        SessionIdManager.instance.readUserId(),
      ]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data![1] != null) {
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
          } else if (snapshot.hasData && snapshot.data![1] == null) {
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
        return const CircularProgressIndicator();
      },
    );
  }
}
