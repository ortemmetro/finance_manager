import 'package:finance_manager/entity/categoryItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  String id;
  final String name;
  final String color;
  final String icon;
  final List<CategoryItem>? listOfExpenses;

  Category({
    this.id = '',
    required this.name,
    required this.color,
    required this.icon,
    this.listOfExpenses,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
