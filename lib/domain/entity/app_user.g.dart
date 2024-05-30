// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      age: (json['age'] as num).toInt(),
      currency: json['currency'] as String,
      locale: json['locale'] as String,
      expenses: (json['expenses'] as List<dynamic>?)
          ?.map((e) => Expense.fromJson(e as Map<String, dynamic>))
          .toList(),
      ownCategories: (json['own_categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'age': instance.age,
      'currency': instance.currency,
      'locale': instance.locale,
      'expenses': instance.expenses?.map((e) => e.toJson()).toList(),
      'own_categories': instance.ownCategories?.map((e) => e.toJson()).toList(),
    };
