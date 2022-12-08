import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense {
  String id;
  final String category;
  final String? comment;
  final DateTime date;
  final double price;

  Expense({
    this.id = "",
    required this.category,
    this.comment,
    required this.date,
    required this.price,
  });

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
