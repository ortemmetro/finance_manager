import 'package:finance_manager/entity/category.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategoryWidget extends StatefulWidget {
  const AddCategoryWidget({super.key});

  @override
  State<AddCategoryWidget> createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddCategoryWidgetModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: const [
                Text("Название категории"),
              ],
            ),
            TextField(),
            const SizedBox(height: 30),
            Row(
              children: [
                SizedBox(
                  width: 180,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('Расходы'),
                    leading: Radio<CategoryClass>(
                      value: CategoryClass.expense,
                      groupValue: model.categoryClass,
                      onChanged: (CategoryClass? value) {
                        setState(() {
                          model.categoryClass = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('Доходы'),
                    leading: Radio<CategoryClass>(
                      value: CategoryClass.income,
                      groupValue: model.categoryClass,
                      onChanged: (CategoryClass? value) {
                        setState(() {
                          model.categoryClass = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Text("Иконки"),
              ],
            ),
            Container(
              height: 268,
              margin: const EdgeInsets.only(top: 15),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: model.listOfCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 2.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AddCategoryCircleIconWidget(
                              index: index,
                              listOfCategories: model.listOfCategories,
                              iconsMap: model.iconsMap,
                              model: model,
                            ),
                          ],
                        ),
                      ),
                      Text(model.listOfCategories[index].name),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Text("Выберите цвет"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddCategoryCircleIconWidget extends StatelessWidget {
  const AddCategoryCircleIconWidget({
    Key? key,
    required this.index,
    required this.listOfCategories,
    required this.iconsMap,
    required this.model,
  }) : super(key: key);
  final List<Category> listOfCategories;
  final Map<String, IconData> iconsMap;
  final int index;
  final AddCategoryWidgetModel model;

  @override
  Widget build(BuildContext context) {
    var selectedIndex = model.selectedIndex;
    return GestureDetector(
      onTap: () {
        model.isSelectedIndex(index);
        model.selectedCategoryName = model.listOfCategories[index].name;
      },
      child: selectedIndex == index
          ? CircleAvatar(
              radius: 32.5,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 29,
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.done, size: 45),
                ),
              ),
            )
          : Container(
              width: 65,
              height: 65,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconsMap[listOfCategories[index].icon],
                size: 45,
              ),
            ),
    );
  }
}
