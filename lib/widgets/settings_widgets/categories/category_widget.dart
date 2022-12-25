import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/expenses_categories_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text("Изменение категории", style: TextStyle(fontSize: 20.sp)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 1.0.h),
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Color(int.parse(arguments.category.color)),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      iconsMap[arguments.category.icon],
                      size: 35.r,
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
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  "Тип",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Text(
                  arguments.category.categoryClass == CategoryClass.expense
                      ? "Расходы"
                      : "Доходы",
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  "Иконки",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
            Container(
              height: 268.h,
              margin: EdgeInsets.only(top: 15.h),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4.0.w, vertical: 2.0.h),
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
                  child: Text(
                    "Все иконки",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 170.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Сохранить",
                    style: TextStyle(fontSize: 15.sp),
                  ),
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
                  child: Text(
                    "Удалить категорию",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
