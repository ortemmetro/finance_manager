// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$MyUserFromJson(Map<String, dynamic> json) => MyUser(
      id: json['id'] as String? ?? '',
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      age: json['age'] as int,
      currency: json['currency'] as String,
      locale: json['locale'] as String,
      accounts:
          (json['accounts'] as List<dynamic>).map((e) => e as String).toList(),
      expenses: (json['expenses'] as List<dynamic>?)
          ?.map((e) => Expense.fromJson(e as Map<String, dynamic>))
          .toList(),
      ownCategories: (json['own_categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyUserToJson(MyUser instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'age': instance.age,
      'currency': instance.currency,
      'locale': instance.locale,
      'accounts': instance.accounts,
      'expenses': instance.expenses?.map((e) => e.toJson()).toList(),
      'own_categories': instance.ownCategories?.map((e) => e.toJson()).toList(),
    };
