import 'package:finance_manager/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagesWidget extends StatelessWidget {
  const LanguagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final countryName = L10n.getCountryName(locale.languageCode);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 72,
              child: Text(countryName),
            ),
          ),
          Text(AppLocalizations.of(context)!.language),
          Text(AppLocalizations.of(context)!.helloWorld),
        ],
      ),
    );
  }
}
