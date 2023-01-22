import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../drawer_widget/drawer_widget.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text('Настройки'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Код-пароль'),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Выбор языка'),
            onTap: () {
              Navigator.of(context).pushNamed("/main_page/settings/language");
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Округлять'),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Темная тема'),
          ),
          ListTile(
            leading: Icon(Icons.document_scanner),
            title: Text('Политика конфиденциоальности'),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalizations.of(context)!.language),
            subtitle: Text(AppLocalizations.of(context)!.helloWorld),
          ),
        ],
      ),
    );
  }
}
