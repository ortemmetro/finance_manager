// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) => Expense(
      id: json['id'] as String? ?? "",
      category: json['category'] as String,
      comment: json['comment'] as String?,
      date: DateTime.parse(json['date'] as String),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'comment': instance.comment,
      'date': instance.date.toIso8601String(),
      'price': instance.price,
    };
