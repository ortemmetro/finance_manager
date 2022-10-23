import 'package:flutter/material.dart';

import '../radial_percent/radial_percent_widget.dart';

class ExpensesPageWidget extends StatelessWidget {
  const ExpensesPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const SizedBox(
            height: 200,
            width: 200,
            child: RadialPercentWidget(
              percent: 0.5,
              backgroundColor: Color.fromRGBO(255, 10, 23, 0.0),
              filledColor: Color.fromARGB(255, 37, 203, 103),
              unfilledColor: Color.fromARGB(255, 232, 232, 232),
              lineWidth: 5.5,
              child: Text(
                '\$100.01',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 93, 176, 117),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  dense: true,
                  leading: Container(
                    width: 19,
                    height: 19,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 93, 176, 117),
                      shape: BoxShape.circle,
                    ),
                  ),
                  title: const Text(
                    'Item',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  trailing: const Text('Statistic'),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1.5,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
