import 'package:finance_manager/domain/data_provider/default_data/default_currency_data.dart';
import 'package:finance_manager/domain/entity/category.dart';
import 'package:finance_manager/widgets/settings_widgets/accounts/accounts_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_model.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddAccountPage extends StatelessWidget {
  AddAccountPage({super.key});

  final headingTextStyle = TextStyle(
    fontSize: 18.5.sp,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    final accountsModel = Provider.of<AccountsModel>(context, listen: true);
    final addCategoryModel =
        Provider.of<AddCategoryModel>(context, listen: true);
    final currencyModel = Provider.of<CurrencyModel>(context, listen: true);
    final currency = DefaultCurrencyData.listOfCurrencies.firstWhere(
        (element) => element.currencySign == currencyModel.currentCurrency);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавление счёта'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
        children: [
          Text(
            'Остаток на счету:',
            style: headingTextStyle,
          ),
          SizedBox(
            width: 200.w,
            child: TextField(),
          ),
          Text(
            'Название счёта:',
            style: headingTextStyle,
          ),
          SizedBox(
            width: 200.w,
            child: TextField(),
          ),
          Text(
            'Выбор валюты:',
            style: headingTextStyle,
          ),
          Row(
            children: [
              SizedBox(
                width: 200.w,
                child: TextField(),
              ),
              Text(currency.currencyCode.toString()),
            ],
          ),
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.icons,
                style: headingTextStyle,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 2.0.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AddCategoryCircleIconWidgetForAccounts(
                        index: index,
                        listOfCategories:
                            addCategoryModel.listOfExpenseCategories,
                        iconsMap: accountsModel.iconsMap,
                        model: accountsModel,
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
                onPressed: () => Navigator.of(context)
                    .pushNamed("/main_page/categories/add/all_categories"),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
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
                  color: accountsModel.selectedColor,
                ),
                width: 50.w,
                height: 50.h,
              ),
              ElevatedButton(
                onPressed: () => accountsModel.pickColor(context),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: Text(
                  AppLocalizations.of(context)!.chooseColorButton,
                  style: TextStyle(fontSize: 15.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () {},
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
    );
  }
}

class AddCategoryCircleIconWidgetForAccounts extends StatelessWidget {
  const AddCategoryCircleIconWidgetForAccounts({
    Key? key,
    required this.index,
    required this.listOfCategories,
    required this.iconsMap,
    required this.model,
  }) : super(key: key);
  final List<Category> listOfCategories;
  final Map<String, IconData> iconsMap;
  final int index;
  final AccountsModel model;

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
                    color: model.selectedColor,
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
