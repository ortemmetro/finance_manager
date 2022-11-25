import 'package:finance_manager/widgets/add_widget/add_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../expenses_page_widget/expenses_page_model.dart';

class AddWidget extends StatefulWidget {
  const AddWidget({super.key});

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
    DateTime? newDate;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(height: 45),
              _InputFieldWithCurrencyWidget(priceController: priceController),
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: const [
                    Text('Категории'),
                  ],
                ),
              ),
              _CategoriesListWidget(model: model),
              const SizedBox(height: 45),
              ElevatedButton(
                onPressed: () async {
                  newDate = await model.myShowDatePicker(newDate, context);
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 93, 176, 117),
                  ),
                ),
                child: const Text('Выбрать дату'),
              ),
              const SizedBox(height: 50),
              _CommentFieldWidget(textController: textController),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  await model.createExpense(
                    comment: textController.text,
                    category: model.selectedCategoryName,
                    price: double.parse(priceController.text),
                    date: newDate ?? DateTime(0),
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

class _CategoriesListWidget extends StatelessWidget {
  const _CategoriesListWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final AddWidgetModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: ListView.builder(
        itemCount: model.listOfCategories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _CategoryCircleIconWidget(model: model, index: index),
                  ],
                ),
              ),
              Text(model.listOfCategories[index].name),
            ],
          );
        },
      ),
    );
  }
}

class _CategoryCircleIconWidget extends StatelessWidget {
  const _CategoryCircleIconWidget({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  final AddWidgetModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    var selectedIndex = model.selectedIndex;
    return GestureDetector(
      onTap: () {
        model.isSelectedIndex(index);
        model.selectedCategoryName = model.listOfCategories[index].name;
      },
      child: selectedIndex == index
          ? Container(
              margin: const EdgeInsets.all(12.0),
              child: CircleAvatar(
                radius: 32.5,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 29,
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color:
                          Color(int.parse(model.listOfCategories[index].color)),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.done, size: 45),
                  ),
                ),
              ),
            )
          : Container(
              margin: const EdgeInsets.all(12.0),
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: Color(int.parse(model.listOfCategories[index].color)),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  model.iconsMap[model.listOfCategories[index].icon],
                  size: 45,
                ),
              ),
            ),
    );
  }
}

class _InputFieldWithCurrencyWidget extends StatelessWidget {
  const _InputFieldWithCurrencyWidget({
    Key? key,
    required this.priceController,
  }) : super(key: key);

  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return Center(
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
          const Text('KZT'),
        ],
      ),
    );
  }
}

class _CommentFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  const _CommentFieldWidget({
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
