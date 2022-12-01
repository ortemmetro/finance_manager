import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget.dart';
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
              itemCount: model.listOfCategories.length,
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
        ],
      ),
    );
  }
}
