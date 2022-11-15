import 'package:finance_manager/entity/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense {
  final String category;
  final String? comment;
  final DateTime date;
  final double price;

  Expense({
    required this.category,
    this.comment,
    required this.date,
    required this.price,
  });

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
