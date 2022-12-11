import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  String id;
  final String name;
  final String color;
  final String icon;
  final CategoryClass categoryClass;

  Category({
    this.id = "",
    required this.name,
    required this.color,
    required this.icon,
    required this.categoryClass,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
