import 'package:finance_manager/domain/data_provider/default_data/default_currency_data.dart';
import 'package:finance_manager/widgets/add_widget/add_widget_model.dart';
import 'package:finance_manager/widgets/expenses_page_widget/expenses_page_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_model.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          Provider.of<AddCategoryModel>(context, listen: false);
      await categoryModel.setCategories();
      Provider.of<AddWidgetModel>(context, listen: false)
        ..currentDate = null
        ..isButtonEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    return _AddWidgetBody(
      priceController: priceController,
      textController: textController,
      arguments: arguments,
    );
  }
}

class _AddWidgetBody extends StatelessWidget {
  const _AddWidgetBody({
    Key? key,
    required this.priceController,
    required this.textController,
    required this.arguments,
  }) : super(key: key);

  final TextEditingController priceController;
  final TextEditingController textController;
  final Object? arguments;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AddWidgetModel>(context);
    final addCategoryWidgetModel = Provider.of<AddCategoryModel>(context);
    model.listOfCategories = arguments.runtimeType == ExpenseInfo
        ? addCategoryWidgetModel.listOfExpenseCategories
        : addCategoryWidgetModel.listOfIncomeCategories;
    final format =
        DateFormat.MMMMEEEEd(Localizations.localeOf(context).toString());
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 25.h),
              _InputFieldWithCurrencyWidget(priceController: priceController),
              SizedBox(height: 45.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.categories,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
              _CategoriesListWidget(model: model),
              SizedBox(height: 45.h),
              ElevatedButton(
                onPressed: () async {
                  await model.myShowDatePicker(context);
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 93, 176, 117),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.chooseDate,
                  style: TextStyle(fontSize: 15.sp),
                ),
              ),
              model.currentDate != null
                  ? Text(format.format(model.currentDate!).toString())
                  : Text(AppLocalizations.of(context)!.noDateSelected),
              SizedBox(height: 50.h),
              _CommentFieldWidget(textController: textController),
              SizedBox(height: 50.h),
              ElevatedButton(
                onPressed: () async {
                  model.isButtonEnabled
                      ? (arguments.runtimeType == ExpenseInfo
                          ? await model.createExpense(
                              comment: textController.text,
                              category: model.selectedCategoryName,
                              price: double.parse(priceController.text),
                              date: model.currentDate ?? DateTime(0),
                              context: context,
                            )
                          : await model.createIncome(
                              comment: textController.text,
                              category: model.selectedCategoryName,
                              price: double.parse(priceController.text),
                              date: model.currentDate ?? DateTime(0),
                              context: context,
                            ))
                      : null;
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
                    AppLocalizations.of(context)!.add,
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
    final currencyModel = Provider.of<CurrencyModel>(context, listen: true);
    final currency = DefaultCurrencyData.listOfCurrencies.firstWhere(
        (element) => element.currencySign == currencyModel.currentCurrency);
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30.h,
            width: 120.w,
            child: TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: priceController,
              decoration: const InputDecoration(),
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            currency.currencyCode,
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
                AppLocalizations.of(context)!.comment,
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
