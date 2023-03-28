import 'package:finance_manager/session/session_id_manager.dart';
import 'package:finance_manager/widgets/drawer_widget/drawer_widget_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/income_page_widget/incomes_page_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_model.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartupModel extends ChangeNotifier {
  Future<void> startupSetup({
    required CurrencyModel currencyModel,
    required ExpensesPageModel expenseModel,
    required IncomesPageModel incomeModel,
    required AddCategoryModel addCategoryModel,
    required DrawerWidgetModel drawerModel,
    required BuildContext context,
  }) async {
    final String allTime = AppLocalizations.of(context)!.allTime;
    await initializeDateFormatting('ru', null);
    await drawerModel.getUserInfo(context);

    // setting  all info for expenses/incomes
    final userId = await SessionIdManager.instance.readUserId();
    await addCategoryModel.downloadCategoriesFromHive();
    await expenseModel.setup(userId);
    expenseModel.setSelectedPeriod(allTime);
    await incomeModel.setup(userId);
    incomeModel.setSelectedPeriod(allTime);
    await currencyModel.setCurrency();
  }
}
