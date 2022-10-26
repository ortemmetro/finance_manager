import 'package:flutter/material.dart';

class AddWidget extends StatelessWidget {
  const AddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: TextField(),
                ),
                SizedBox(width: 5),
                Text('KZT'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: const [
                Text('Категории'),
              ],
            ),
          ),
          SizedBox(
            height: 125,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.all(12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const SizedBox(width: 75, height: 75),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text('Семья'),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
