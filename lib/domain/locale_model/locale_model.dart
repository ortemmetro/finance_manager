import 'package:finance_manager/domain/data_provider/box_manager/box_manager.dart';
import 'package:finance_manager/domain/entity/my_user_for_hive.dart';
import 'package:finance_manager/l10n/l10n.dart';
import 'package:finance_manager/session/session_id_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocaleModel extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) {
      return;
    }
    _locale = locale;
    notifyListeners();
  }

  Future<void> setLocaleFromHive() async {
    final userBox = await BoxManager.instance.openUserBox();
    final userId = await SessionIdManager.instance.readUserId();
    final usersList = userBox.values.toList();

    final user = usersList.where((element) => element.id == userId).toList();

    await BoxManager.instance.closeBox(userBox);
    setLocale(Locale(user.first.locale));
  }

  Future<void> setLocaleFromSettings({
    required Locale locale,
  }) async {
    final userBox = await BoxManager.instance.openUserBox();
    final userId = await SessionIdManager.instance.readUserId();
    final usersList = userBox.values.toList();
    final user = usersList.where((element) => element.id == userId).first;

    final userKey = user.key;
    final newUserWithNewLocale = MyUserForHive(
      id: user.id,
      age: user.age,
      currency: user.currency,
      locale: locale.languageCode,
      accounts: user.accounts,
      firstName: user.firstName,
      lastName: user.lastName,
    );

    await userBox.putAt(userKey, newUserWithNewLocale);

    await BoxManager.instance.closeBox(userBox);

    setLocale(locale);
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }

  Future<void> showSuccessDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.languageChangedText),
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
