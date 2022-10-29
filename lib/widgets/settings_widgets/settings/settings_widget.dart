import 'package:flutter/material.dart';

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
        children: const [
          SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Код-пароль'),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Выбор языка'),
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
        ],
      ),
    );
  }
}
