import 'package:finance_manager/domain/locale_model/locale_model.dart';
import 'package:finance_manager/l10n/l10n.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/income_page_widget/incomes_page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LanguagesWidget extends StatelessWidget {
  const LanguagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final languageModel = Provider.of<LocaleModel>(context);
    final expenseModel = Provider.of<ExpensesPageModel>(context);
    final incomeModel = Provider.of<IncomesPageModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 30.h),
          Text(
            AppLocalizations.of(context)!.language,
            style: TextStyle(fontSize: 20.sp),
          ),
          Text(
            AppLocalizations.of(context)!.helloWorld,
            style: TextStyle(fontSize: 20.sp),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: ListView.separated(
              itemCount: L10n.all.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () async {
                    await languageModel.setLocaleFromSettings(
                      locale: L10n.all[index],
                    );
                    await languageModel.showSuccessDialog(context);
                    expenseModel.setSelectedPeriod(
                      AppLocalizations.of(context)!.allTime,
                    );
                    incomeModel.setSelectedPeriod(
                      AppLocalizations.of(context)!.allTime,
                    );
                  },
                  leading: Text(
                    L10n.getCountryName(L10n.all[index].languageCode),
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  tileColor: const Color.fromARGB(255, 206, 206, 206),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}
