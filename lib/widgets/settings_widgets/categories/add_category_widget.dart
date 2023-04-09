import 'package:finance_manager/domain/entity/category.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCategoryWidget extends StatefulWidget {
  const AddCategoryWidget({super.key});

  @override
  State<AddCategoryWidget> createState() => _AddCategoryWidgetState();
}

class _AddCategoryWidgetState extends State<AddCategoryWidget> {
  final nameOfCategoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddCategoryModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.categoryName,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
                TextField(controller: nameOfCategoryController),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    SizedBox(
                      width: 180.w,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          AppLocalizations.of(context)!.expenses,
                          style: TextStyle(fontSize: 16.5.sp),
                        ),
                        leading: Radio<int>(
                          value: CategoryClass.expense.index,
                          groupValue: model.categoryClassIndex,
                          onChanged: (int? value) {
                            setState(() {
                              model.categoryClassIndex = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          AppLocalizations.of(context)!.incomes,
                          style: TextStyle(fontSize: 16.5.sp),
                        ),
                        leading: Radio<int>(
                          value: CategoryClass.income.index,
                          groupValue: model.categoryClassIndex,
                          onChanged: (int? value) {
                            setState(() {
                              model.categoryClassIndex = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.icons,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
                Container(
                  height: 268.h,
                  margin: EdgeInsets.only(top: 15.h),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 12,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.chooseColorHeader,
                      style: TextStyle(fontSize: 16.5.sp),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                          "/main_page/categories/add/all_categories"),
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.allIcons,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 11.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: model.color,
                      ),
                      width: 50.w,
                      height: 50.h,
                    ),
                    ElevatedButton(
                      onPressed: () => model.pickColor(context),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: Text(
                        AppLocalizations.of(context)!.chooseColorButton,
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () =>
                      model.addCategory(nameOfCategoryController.text, context),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                      horizontal: 20.0.w,
                      vertical: 12.0.h,
                    )),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.add,
                    style: TextStyle(fontSize: 25.sp),
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
  final AddCategoryModel model;

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
