import 'package:finance_manager/widgets/settings_widgets/categories/add_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AllCategoriesWidget extends StatelessWidget {
  const AllCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddCategoryModel>(context, listen: true);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.done,
          size: 35.r,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 30.h),
          Expanded(
            child: GridView.builder(
              itemCount: model.iconsMap.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 2.0.h),
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
  final AddCategoryModel model;
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
              radius: 32.5.r,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 29.r,
                child: Container(
                  width: 65.w,
                  height: 65.h,
                  decoration: BoxDecoration(
                    color: model.color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    listOfValues[index].value,
                    size: 45.r,
                  ),
                ),
              ),
            )
          : Container(
              width: 65.w,
              height: 65.h,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                listOfValues[index].value,
                size: 45.r,
              ),
            ),
    );
  }
}
