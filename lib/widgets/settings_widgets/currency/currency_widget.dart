import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../drawer_widget/drawer_widget.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CurrencyWidgetModel>(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        elevation: 8.0,
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
        itemCount: model.listOfCurrencies.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              model.listOfCurrencies[index].currencyName,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: Text(
              model.listOfCurrencies[index].currencySign,
              style: const TextStyle(fontSize: 19),
            ),
            dense: true,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
