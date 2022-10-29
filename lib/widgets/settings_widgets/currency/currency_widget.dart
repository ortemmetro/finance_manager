import 'package:flutter/material.dart';

import '../../drawer_widget/drawer_widget.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        toolbarHeight: 58,
        title: const Text('Валюта'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, size: 28),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return const ListTile(
            leading: Text('Казахстанский Тенге'),
            trailing: Text('KZT'),
            dense: true,
          );
        },
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
