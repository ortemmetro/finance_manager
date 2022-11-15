import 'package:json_annotation/json_annotation.dart';
import 'package:finance_manager/entity/expense.dart';

part 'myUser.g.dart';

@JsonSerializable()
class MyUser {
  String id;
  final String name;
  final String surName;
  final List<Expense>? expenses;

  MyUser({
    this.id = '',
    required this.name,
    required this.surName,
    required this.expenses,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);

  Map<String, dynamic> toJson() => _$MyUserToJson(this);
}
