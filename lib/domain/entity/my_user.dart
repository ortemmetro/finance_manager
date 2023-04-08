import 'package:finance_manager/domain/entity/category.dart';
import 'package:finance_manager/domain/entity/expense.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MyUser {
  String id;
  final String firstName;
  final String lastName;
  final int age;
  final String currency;
  final String locale;
  final List<String> accounts;
  final List<Expense>? expenses;
  final List<Category>? ownCategories;

  MyUser({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.currency,
    required this.locale,
    required this.accounts,
    required this.expenses,
    required this.ownCategories,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);

  Map<String, dynamic> toJson() => _$MyUserToJson(this);
}
