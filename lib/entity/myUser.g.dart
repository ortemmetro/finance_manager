// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUser _$MyUserFromJson(Map<String, dynamic> json) => MyUser(
      id: json['id'] as String? ?? '',
      name: json['name'] as String,
      surName: json['surName'] as String,
      expenses: (json['expenses'] as List<dynamic>?)
          ?.map((e) => Expense.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyUserToJson(MyUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surName': instance.surName,
      'expenses': instance.expenses,
    };
