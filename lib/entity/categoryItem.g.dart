// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItem _$CategoryItemFromJson(Map<String, dynamic> json) => CategoryItem(
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      comment: json['comment'] as String?,
      date: DateTime.parse(json['date'] as String),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$CategoryItemToJson(CategoryItem instance) =>
    <String, dynamic>{
      'category': instance.category,
      'comment': instance.comment,
      'date': instance.date.toIso8601String(),
      'price': instance.price,
    };
