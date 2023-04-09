import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/income_page_widget/incomes_page_model.dart';
import 'package:finance_manager/widgets/settings_widgets/accounts/accounts_model.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../drawer_widget/drawer_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountsWidget extends StatelessWidget {
  const AccountsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final accountsModel = Provider.of<AccountsModel>(context, listen: true);
    final expenseModel = Provider.of<ExpensesPageModel>(context, listen: true);
    final incomeModel = Provider.of<IncomesPageModel>(context, listen: true);
    final currencyModel = Provider.of<CurrencyModel>(context, listen: true);
    final sum = expenseModel.sumWithSpaces(
        (incomeModel.doubleSum.toInt() - expenseModel.doubleSum.toInt())
            .toDouble());
    return Scaffold(
      drawer: const DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).pushNamed('/main_page/accounts/add');
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.accounts),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30.h),
          Center(
            child: Column(
              children: [
                Text(
                  '${AppLocalizations.of(context)!.total}:',
                  style: TextStyle(
                    fontSize: 19.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '$sum${currencyModel.currentCurrency}',
                  style: TextStyle(fontSize: 29.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.history),
                  ),
                  const Text('История переводов'),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.compare_arrows),
                  ),
                  const Text('Создать перевод'),
                ],
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Expanded(
            child: ListView.separated(
              itemCount: accountsModel.accounts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.money),
                  title: Text(accountsModel.accounts[index]),
                  trailing: Text('${accountsModel.getSumForAccount(
                        listOfExpenses: expenseModel.listOfALLALLExpenses,
                        listOfIncomes: incomeModel.listOfALLALLIncomes,
                        account: accountsModel.accounts[index],
                      ).toString()} ${currencyModel.currentCurrency}'),
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
