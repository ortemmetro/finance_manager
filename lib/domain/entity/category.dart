import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String color;

  @HiveField(3)
  final String icon;

  @HiveField(4)
  final int categoryClassIndex;

  Category({
    this.id = "",
    required this.name,
    required this.color,
    required this.icon,
    required this.categoryClassIndex,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
