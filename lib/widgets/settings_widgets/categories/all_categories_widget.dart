import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCategoriesWidget extends StatelessWidget {
  const AllCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddCategoryWidgetModel>(context, listen: true);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.done,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Expanded(
            child: GridView.builder(
              itemCount: model.iconsMap.length,
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
                      AddAllCategoryCircleIconWidget(
                        model: model,
                        index: index,
                        iconsMap: model.iconsMap,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddAllCategoryCircleIconWidget extends StatelessWidget {
  const AddAllCategoryCircleIconWidget({
    super.key,
    required this.model,
    required this.index,
    required this.iconsMap,
  });
  final AddCategoryWidgetModel model;
  final int index;
  final Map<String, IconData> iconsMap;

  @override
  Widget build(BuildContext context) {
    var selectedIndex = model.selectedIndex;
    final listOfValues = iconsMap.entries.toList();

    return GestureDetector(
      onTap: () {
        model.isSelectedIndex(index);
        model.selectedCategoryIcon = listOfValues[index].key;
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
                    listOfValues[index].value,
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
                listOfValues[index].value,
                size: 45,
              ),
            ),
    );
  }
}
