// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$MyUserFromJson(Map<String, dynamic> json) => MyUser(
      id: json['id'] as String? ?? '',
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      age: json['age'] as int,
      expenses: (json['expenses'] as List<dynamic>?)
          ?.map((e) => Expense.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyUserToJson(MyUser instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'age': instance.age,
      'expenses': instance.expenses,
    };
