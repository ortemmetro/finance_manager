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
  final nameOfCategoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddCategoryWidgetModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Text("Название категории"),
                  ],
                ),
                TextField(controller: nameOfCategoryController),
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
                              model.categoryClass = value!;
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
                              model.categoryClass = value!;
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                              listOfCategories: model.listOfCategories,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Выберите цвет"),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                          "/main_page/categories/add/all_categories"),
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
                      ),
                      child: const Text("Все иконки"),
                    )
                  ],
                ),
                Row(
                  children: const [],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: model.color,
                      ),
                      width: 50,
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () => model.pickColor(context),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: const Text("Выбрать цвет"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      model.addCategory(nameOfCategoryController.text, context),
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20.0)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: const Text(
                    "Добавить",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
        ],
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
        model.selectedCategoryIcon = model.listOfCategories[index].icon;
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
                  decoration: BoxDecoration(
                    color: model.color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    iconsMap[listOfCategories[index].icon],
                    size: 45,
                  ),
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
