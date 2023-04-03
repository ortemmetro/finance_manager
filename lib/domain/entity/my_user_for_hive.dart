import 'package:hive/hive.dart';

part 'my_user_for_hive.g.dart';

@HiveType(typeId: 4)
class MyUserForHive extends HiveObject {
  //used fields 4, 5
  @HiveField(0)
  String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final int age;

  @HiveField(6)
  final String currency;

  @HiveField(7)
  final String locale;

  MyUserForHive({
    this.id = '',
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.currency,
    required this.locale,
  });
}
