import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
@HiveType(typeId: 5)
class Account extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  final String color;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String icon;

  @HiveField(4)
  final String currencySign;

  Account({
    this.id = '',
    required this.color,
    required this.name,
    required this.icon,
    required this.currencySign,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
