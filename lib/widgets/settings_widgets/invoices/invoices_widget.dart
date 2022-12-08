import 'package:flutter/material.dart';

import '../../drawer_widget/drawer_widget.dart';

class InvoicesWidget extends StatelessWidget {
  const InvoicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text('Счета'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Column(
              children: const [
                Text(
                  'Итого:',
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '\$999',
                  style: TextStyle(fontSize: 29),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 30),
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: Icon(Icons.money),
                  title: Text('Основной'),
                  trailing: Text('\$999'),
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
