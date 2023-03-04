import 'package:finance_manager/entity/category.dart';
import 'package:hive/hive.dart';
import 'package:finance_manager/entity/expense.dart';

part 'my_user_for_hive.g.dart';

@HiveType(typeId: 4)
class MyUserForHive extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final int age;

  @HiveField(4)
  final HiveList<Expense>? expenses;

  @HiveField(5)
  final HiveList<Category>? ownCategories;

  MyUserForHive({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.expenses,
    required this.ownCategories,
  });
}
