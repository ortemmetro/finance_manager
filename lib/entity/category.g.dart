// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String? ?? "",
      name: json['name'] as String,
      color: json['color'] as String,
      icon: json['icon'] as String,
      categoryClass: $enumDecode(_$CategoryClassEnumMap, json['categoryClass']),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'icon': instance.icon,
      'categoryClass': _$CategoryClassEnumMap[instance.categoryClass]!,
    };

const _$CategoryClassEnumMap = {
  CategoryClass.expense: 'expense',
  CategoryClass.income: 'income',
};
