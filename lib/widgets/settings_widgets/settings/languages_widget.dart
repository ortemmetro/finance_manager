import 'package:finance_manager/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'languages_widget_model.dart';

class LanguagesWidget extends StatelessWidget {
  const LanguagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final model = Provider.of<LanguagesWidgetModel>(context, listen: true);
    // model.setLocale(locale);
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
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () => model.setLocale(const Locale('kk')),
                  leading: const Text("Қазақша"),
                  tileColor: const Color.fromARGB(255, 206, 206, 206),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
