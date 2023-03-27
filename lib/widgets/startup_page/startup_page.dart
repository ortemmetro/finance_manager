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

class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<StartupModel>(context, listen: false);
    final currencyModel = Provider.of<CurrencyModel>(context, listen: false);
    return FutureBuilder(
      future: model.startupSetup(currencyModel),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
