import 'package:flutter/material.dart';

class AddCategoryWidget extends StatelessWidget {
  const AddCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: const [
              Text("Название категории"),
            ],
          ),
          TextField(),
          Row(
            children: [],
          ),
        ],
      ),
    );
  }
}
