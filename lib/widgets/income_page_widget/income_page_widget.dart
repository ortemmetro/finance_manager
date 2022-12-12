import 'package:flutter/material.dart';

class IncomePageWidget extends StatelessWidget {
  const IncomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: 392.7,
            height: 200,
            child: Stack(
              children: [
                const Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Text("One day here will be your statistics"),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: RawMaterialButton(
                    onPressed: () {},
                    fillColor: const Color.fromARGB(255, 93, 176, 117),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12.0),
                    child: const Icon(
                      Icons.add,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
