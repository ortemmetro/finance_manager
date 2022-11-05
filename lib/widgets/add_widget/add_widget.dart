import 'package:finance_manager/widgets/add_widget/add_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../expenses_page_widget/expenses_page_model.dart';

class AddWidget extends StatefulWidget {
  AddWidget({super.key});

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  final priceController = TextEditingController();

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final expenseModel = context.read<ExpensesPageModel>();
    return ChangeNotifierProvider(
      create: (context) => AddWidgetModel(expenseModel),
      child: _AddWidgetBody(
        priceController: priceController,
        textController: textController,
      ),
    );
  }
}

class _AddWidgetBody extends StatelessWidget {
  const _AddWidgetBody({
    Key? key,
    required this.priceController,
    required this.textController,
  }) : super(key: key);

  final TextEditingController priceController;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddWidgetModel>();
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 45),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10,
                      width: 100,
                      child: TextField(
                        controller: priceController,
                        decoration: const InputDecoration(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text('KZT'),
                  ],
                ),
              ),
              const SizedBox(height: 45),
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
              const SizedBox(height: 45),
              ElevatedButton(
                onPressed: () {},
                //async {
                //   DateTime? newDate = await showDatePicker(
                //     context: context,
                //     initialDate: DateTime(2022, 10, 27),
                //     firstDate: DateTime(1900),
                //     lastDate: DateTime(2023),
                //   );
                // },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 93, 176, 117),
                  ),
                ),
                child: const Text('Выбрать дату'),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: const [
                    Text('Комментарий'),
                  ],
                ),
              ),
              SizedBox(
                width: 367,
                child: TextField(
                  controller: textController,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  await model.createExpense(
                    comment: textController.text,
                    category: 'Семья',
                    price: double.parse(priceController.text),
                    date: DateTime(2020, 10, 10),
                    context: context,
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 93, 176, 117),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Добавить',
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
