import 'package:finance_manager/entity/category.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:finance_manager/entity/expense.dart';

part 'my_user.g.dart';

@JsonSerializable()
class MyUser {
  String id;
  final String firstName;
  final String lastName;
  final int age;
  final List<Expense>? expenses;
  final List<Category>? ownCategories;

  MyUser({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.expenses,
    required this.ownCategories,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);

  Map<String, dynamic> toJson() => _$MyUserToJson(this);
}
