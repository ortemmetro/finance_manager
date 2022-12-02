import 'package:finance_manager/entity/category.dart';
import 'package:finance_manager/my_icons_class/my_icons_class.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';
import 'package:flutter/material.dart';

class DefaultCategoriesData {
  static const Map<String, IconData> iconsMap = {
    'local_grocery_store_outlined': Icons.local_grocery_store_outlined,
    'monitor': Icons.monitor,
    'wine_bar': Icons.wine_bar,
    'attach_money': Icons.attach_money,
    'directions_bus': Icons.directions_bus,
    'local_taxi': Icons.local_taxi,
    'health_and_safety_outlined': Icons.health_and_safety_outlined,
    'wc': Icons.wc,
    'payments': Icons.payments,
    'school_outlined': Icons.school_outlined,
    'question_mark_outlined': Icons.question_mark_outlined,
    'cash_bundle_1214102': MyIconsClass.basket_1214048,
  };

  static List<Category> listOfExpenseCategories = const [
    Category(
      name: 'Продукты',
      color: '0xff34dbeb',
      icon: 'local_grocery_store_outlined',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Техника',
      color: '0xff34eb40',
      icon: 'monitor',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Развлечения',
      color: '0xffd666e3',
      icon: 'wine_bar',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Долг',
      color: '0xffe31414',
      icon: 'attach_money',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Транспорт',
      color: '0xff893dd1',
      icon: 'directions_bus',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Такси',
      color: '0xffc9d91e',
      icon: 'local_taxi',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Здоровье',
      color: '0xffa30e0b',
      icon: 'health_and_safety_outlined',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Семья',
      color: '0xff1f9cdb',
      icon: 'wc',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Подарок',
      color: '0xfff02677',
      icon: 'wc',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Кеш',
      color: '0xfff13680',
      icon: 'cash_bundle_1214102',
      categoryClass: CategoryClass.expense,
    ),
  ];

  static List<Category> listOfIncomesCategories = const [
    Category(
      name: 'Зарплата',
      color: '0xff49c520',
      icon: 'payments',
      categoryClass: CategoryClass.income,
    ),
    Category(
      name: 'Стипендия',
      color: '0xff2068c5',
      icon: 'school_outlined',
      categoryClass: CategoryClass.income,
    ),
    Category(
      name: 'Другое',
      color: '0xff20c5aa',
      icon: 'question_mark_outlined',
      categoryClass: CategoryClass.income,
    ),
  ];

  static List<Category> listOfAllIconsForAddingCategory = const [
    Category(
      name: 'Зарплата',
      color: '0xff49c520',
      icon: 'payments',
      categoryClass: CategoryClass.income,
    ),
    Category(
      name: 'Стипендия',
      color: '0xff2068c5',
      icon: 'school_outlined',
      categoryClass: CategoryClass.income,
    ),
    Category(
      name: 'Другое',
      color: '0xff20c5aa',
      icon: 'question_mark_outlined',
      categoryClass: CategoryClass.income,
    ),
    Category(
      name: 'Продукты',
      color: '0xff34dbeb',
      icon: 'local_grocery_store_outlined',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Техника',
      color: '0xff34eb40',
      icon: 'monitor',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Развлечения',
      color: '0xffd666e3',
      icon: 'wine_bar',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Долг',
      color: '0xffe31414',
      icon: 'attach_money',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Транспорт',
      color: '0xff893dd1',
      icon: 'directions_bus',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Такси',
      color: '0xffc9d91e',
      icon: 'local_taxi',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Здоровье',
      color: '0xffa30e0b',
      icon: 'health_and_safety_outlined',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Подарок',
      color: '0xfff02677',
      icon: 'wc',
      categoryClass: CategoryClass.expense,
    ),
    Category(
      name: 'Кеш',
      color: '0xfff13680',
      icon: 'cash_bundle_1214102',
      categoryClass: CategoryClass.expense,
    ),
  ];
}
