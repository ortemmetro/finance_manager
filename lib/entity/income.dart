import 'package:json_annotation/json_annotation.dart';

part 'income.g.dart';

@JsonSerializable()
class Income {
  String id;
  final String category;
  final String? comment;
  final DateTime date;
  final double price;

  Income({
    this.id = "",
    required this.category,
    this.comment,
    required this.date,
    required this.price,
  });

  factory Income.fromJson(Map<String, dynamic> json) => _$IncomeFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeToJson(this);
}
