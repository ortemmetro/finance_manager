import 'package:finance_manager/entity/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categoryItem.g.dart';

@JsonSerializable()
class CategoryItem {
  final Category category;
  final String? comment;
  final DateTime date;
  final double price;

  CategoryItem({
    required this.category,
    required this.comment,
    required this.date,
    required this.price,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemToJson(this);
}
