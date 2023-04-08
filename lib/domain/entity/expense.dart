import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
@HiveType(typeId: 2)
class Expense extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final String? comment;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final double price;

  @HiveField(5)
  final String account;

  Expense({
    this.id = "",
    required this.category,
    required this.comment,
    required this.date,
    required this.price,
    required this.account,
  });

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
