import 'package:finance_manager/entity/category.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/expenses_categories_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddCategoryWidgetModel>(context, listen: false);
    final iconsMap = model.iconsMap;
    final arguments =
        ModalRoute.of(context)!.settings.arguments as CategoryInfo;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Изменение категории"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.all(1.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(int.parse(arguments.category.color)),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      iconsMap[arguments.category.icon],
                      size: 35,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(isDense: true),
                    controller:
                        TextEditingController(text: arguments.category.name),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Text(
                  "Тип",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(arguments.category.categoryClass == CategoryClass.expense
                    ? "Расходы"
                    : "Доходы"),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Text(
                  "Иконки",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Container(
              height: 268,
              margin: const EdgeInsets.only(top: 15),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AddCategoryCircleIconWidget(
                          index: index,
                          listOfCategories: model.listOfExpenseCategories,
                          iconsMap: model.iconsMap,
                          model: model,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed("/main_page/categories/add/all_categories"),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  ),
                  child: const Text("Все иконки"),
                ),
              ],
            ),
            const SizedBox(height: 170),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Сохранить"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await model.deleteCategory(
                      arguments.category.id,
                      context,
                      arguments.userId,
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text("Удалить категорию"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
