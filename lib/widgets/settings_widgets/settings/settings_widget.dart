import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../drawer_widget/drawer_widget.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          // ListTile(
          //   leading: Icon(Icons.lock),
          //   title: Text('Код-пароль'),
          // ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalizations.of(context)!.selectLanguage),
            onTap: () {
              Navigator.of(context).pushNamed("/main_page/settings/language");
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.dark_mode),
          //   title: Text('Темная тема'),
          // ),
          // ListTile(
          //   leading: Icon(Icons.document_scanner),
          //   title: Text('Политика конфиденциоальности'),
          // ),
        ],
      ),
    );
  }
}
