import 'package:finance_manager/domain/locale_model/locale_model.dart';
import 'package:finance_manager/src/core/di/di.dart';
import 'package:finance_manager/src/core/di/get_it_provider.dart';
import 'package:finance_manager/src/core/utils/extensions/context_ext.dart';
import 'package:finance_manager/src/features/authentication/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:finance_manager/widgets/add_widget/add_widget_model.dart';
import 'package:finance_manager/widgets/drawer_widget/drawer_widget_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/income_page_widget/incomes_page_model.dart';
import 'package:finance_manager/widgets/settings_widgets/accounts/accounts_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_model.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ScopeProvider extends StatelessWidget {
  const ScopeProvider({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(
          value: GetItProvider(
            getIt: getIt,
          ),
        ),
        BlocProvider(
          create: (context) => context.get<AuthBloc>(),
        ),
        ChangeNotifierProvider(create: (context) => LocaleModel()),
        ChangeNotifierProvider(create: (context) => CurrencyModel()),
        ChangeNotifierProvider(create: (context) => AccountsModel()),
        ChangeNotifierProvider(create: (context) => ExpensesPageModel()),
        ChangeNotifierProvider(create: (context) => IncomesPageModel()),
        ChangeNotifierProvider(create: (context) => DrawerWidgetModel()),
        // ChangeNotifierProvider(create: (context) => AuthWidgetModel()),
        // ChangeNotifierProvider(create: (context) => SignUpWidgetModel()),
        ChangeNotifierProvider(create: (context) => AddCategoryModel()),
        ChangeNotifierProvider(
          create: (context) => AddWidgetModel(
            Provider.of<ExpensesPageModel>(context, listen: false),
            Provider.of<IncomesPageModel>(context, listen: false),
          ),
        ),
      ],
      child: child,
    );
  }
}
