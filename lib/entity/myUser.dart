import 'package:json_annotation/json_annotation.dart';
import 'package:finance_manager/entity/expense.dart';

part 'myUser.g.dart';

@JsonSerializable()
class MyUser {
  String id;
  final String firstName;
  final String lastName;
  final int age;
  final List<Expense>? expenses;

  MyUser({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.expenses,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);

  Map<String, dynamic> toJson() => _$MyUserToJson(this);
}
