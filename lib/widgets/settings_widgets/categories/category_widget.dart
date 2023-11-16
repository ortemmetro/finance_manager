import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/expenses_categories_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final addModel = Provider.of<AddCategoryModel>(context, listen: false);
    final expenseModel = Provider.of<ExpensesPageModel>(context, listen: false);

    final iconsMap = addModel.iconsMap;
    final arguments =
        ModalRoute.of(context)!.settings.arguments as CategoryInfo;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.changeCategory,
            style: TextStyle(fontSize: 20.sp)),
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
                  AppLocalizations.of(context)!.type,
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
                  arguments.category.categoryClassIndex == 0
                      ? AppLocalizations.of(context)!.expenses
                      : AppLocalizations.of(context)!.incomes,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.icons,
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
                          listOfCategories: addModel.listOfExpenseCategories,
                          iconsMap: addModel.iconsMap,
                          model: addModel,
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
                    AppLocalizations.of(context)!.allIcons,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     print(arguments.category.categoryClassIndex);
                  //   },
                  //   child: Text(
                  //     AppLocalizations.of(context)!.save,
                  //     style: TextStyle(fontSize: 15.sp),
                  //   ),
                  // ),
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              AppLocalizations.of(context)!.deleteCategory,
                            ),
                            content: Text(AppLocalizations.of(context)!
                                .deleteCategoryWarningText),
                            actions: [
                              ElevatedButton(
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ElevatedButton(
                                child: Text(
                                  AppLocalizations.of(context)!.delete,
                                ),
                                onPressed: () async {
                                  await addModel.deleteCategoryFromHive(
                                    arguments.category,
                                    expenseModel,
                                  );
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.deleteCategory,
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
