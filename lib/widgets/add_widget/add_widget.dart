import 'package:finance_manager/widgets/add_widget/add_widget_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final categoryModel =
          Provider.of<AddCategoryWidgetModel>(context, listen: false);
      await categoryModel.setCategories(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenseModel = context.read<ExpensesPageModel>();
    return _AddWidgetBody(
      priceController: priceController,
      textController: textController,
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
    final model = Provider.of<AddWidgetModel>(context);
    final addCategoryWidgetModel = Provider.of<AddCategoryWidgetModel>(context);
    model.listOfCategories = addCategoryWidgetModel.listOfExpenseCategories;
    DateTime? newDate;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 45.h),
              _InputFieldWithCurrencyWidget(priceController: priceController),
              SizedBox(height: 45.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: Row(
                  children: [
                    Text(
                      'Категории',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
              _CategoriesListWidget(model: model),
              SizedBox(height: 45.h),
              ElevatedButton(
                onPressed: () async {
                  newDate = await model.myShowDatePicker(newDate, context);
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 93, 176, 117),
                  ),
                ),
                child: Text(
                  'Выбрать дату',
                  style: TextStyle(fontSize: 15.sp),
                ),
              ),
              SizedBox(height: 50.h),
              _CommentFieldWidget(textController: textController),
              SizedBox(height: 50.h),
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0.w, vertical: 20.0.h),
                  child: Text(
                    'Добавить',
                    style: TextStyle(fontSize: 19.sp),
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
                    EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.0.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _CategoryCircleIconWidget(model: model, index: index),
                  ],
                ),
              ),
              Text(
                model.listOfCategories[index].name,
                maxLines: 1,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis, fontSize: 14.5.sp),
              ),
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
              margin:
                  EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.0.h),
              child: CircleAvatar(
                radius: 32.5.r,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 29.r,
                  child: Container(
                    width: 65.w,
                    height: 65.h,
                    decoration: BoxDecoration(
                      color:
                          Color(int.parse(model.listOfCategories[index].color)),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.done,
                      size: 45.r,
                    ),
                  ),
                ),
              ),
            )
          : Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.0.h),
              child: Container(
                width: 65.w,
                height: 65.h,
                decoration: BoxDecoration(
                  color: Color(int.parse(model.listOfCategories[index].color)),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  model.iconsMap[model.listOfCategories[index].icon],
                  size: 45.r,
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
            height: 10.h,
            width: 100.w,
            child: TextField(
              controller: priceController,
              decoration: const InputDecoration(),
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            'KZT',
            style: TextStyle(fontSize: 15.sp),
          ),
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
          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
          child: Row(
            children: [
              Text(
                'Комментарий',
                style: TextStyle(fontSize: 18.sp),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 367.w,
          child: TextField(
            controller: textController,
          ),
        ),
      ],
    );
  }
}
