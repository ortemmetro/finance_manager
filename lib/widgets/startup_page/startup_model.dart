import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:flutter/cupertino.dart';

class StartupModel extends ChangeNotifier {
  Future<void> startupSetup(CurrencyModel model) async {
    await model.setCurrency();
  }
}
