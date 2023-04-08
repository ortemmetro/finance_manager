import 'package:finance_manager/domain/data_provider/box_manager/box_manager.dart';
import 'package:finance_manager/domain/data_provider/default_data/default_currency_data.dart';
import 'package:finance_manager/domain/entity/my_user_for_hive.dart';
import 'package:finance_manager/session/session_id_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CurrencyModel extends ChangeNotifier {
  final listOfCurrencies = DefaultCurrencyData.listOfCurrencies;
  String? currentCurrency;

  Future<void> setCurrency() async {
    final userBox = await BoxManager.instance.openUserBox();
    final userId = await SessionIdManager.instance.readUserId();
    final usersList = userBox.values.toList();

    final user = usersList.where((element) => element.id == userId).toList();

    currentCurrency = user.length == 1 ? user.first.currency : null;
    await BoxManager.instance.closeBox(userBox);
  }

  Future<void> setCurrencyFromSettings(String currency) async {
    final userBox = await BoxManager.instance.openUserBox();
    final userId = await SessionIdManager.instance.readUserId();
    final usersList = userBox.values.toList();
    final user = usersList.where((element) => element.id == userId).first;

    final userKey = user.key;
    final newUserWithNewCurrency = MyUserForHive(
      id: user.id,
      age: user.age,
      currency: currency,
      locale: user.locale,
      accounts: user.accounts,
      firstName: user.firstName,
      lastName: user.lastName,
    );
    currentCurrency = currency;

    await userBox.putAt(userKey, newUserWithNewCurrency);

    await BoxManager.instance.closeBox(userBox);
    notifyListeners();
  }

  Future<void> showSuccessDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.currencyChangedText),
          actionsPadding: EdgeInsets.all(15.0.r),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                  horizontal: 10.0.h,
                  vertical: 10.0.w,
                )),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: Text(
                AppLocalizations.of(context)!.okay,
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          ],
        );
      },
    );
  }
}
