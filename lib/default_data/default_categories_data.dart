import 'package:finance_manager/entity/category.dart';
import 'package:flutter/material.dart';

class DefaultExpenseCategoriesData {
  Map<String, IconData> iconsMap = {
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
  };

  final List<Category> listOfExpenseCategories = [
    Category(
      name: 'Продукты',
      color: '0xff34dbeb',
      icon: 'local_grocery_store_outlined',
    ),
    Category(
      name: 'Техника',
      color: '0xff34eb40',
      icon: 'monitor',
    ),
    Category(
      name: 'Развлечения',
      color: '0xffd666e3',
      icon: 'wine_bar',
    ),
    Category(
      name: 'Долг',
      color: '0xffe31414',
      icon: 'attach_money',
    ),
    Category(
      name: 'Транспорт',
      color: '0xff893dd1',
      icon: 'directions_bus',
    ),
    Category(
      name: 'Такси',
      color: '0xffc9d91e',
      icon: 'local_taxi',
    ),
    Category(
      name: 'Здоровье',
      color: '0xffa30e0b',
      icon: 'health_and_safety_outlined',
    ),
    Category(
      name: 'Семья',
      color: '0xff1f9cdb',
      icon: 'wc',
    ),
    Category(
      name: 'Подарок',
      color: '0xfff02677',
      icon: 'wc',
    ),
  ];

  final List<Category> listOfIncomesCategories = [
    Category(
      name: 'Зарплата',
      color: '0xff49c520',
      icon: 'payments',
    ),
    Category(
      name: 'Стипендия',
      color: '0xff2068c5',
      icon: 'school_outlined',
    ),
    Category(
      name: 'Другое',
      color: '0xff20c5aa',
      icon: 'question_mark_outlined',
    ),
  ];
}
