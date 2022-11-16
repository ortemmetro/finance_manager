import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../entity/myUser.dart';

class DrawerWidgetModel extends ChangeNotifier {
  String userName = '';
  String userSurname = '';
  void getUserInfo() async {
    final docUsersReference = FirebaseFirestore.instance
        .collection('Users')
        .doc('b5D2GOjlsaQZtYffHurw');
    final userInfoObject = await docUsersReference.get();
    final userInfoMap = userInfoObject.data();
    final userInfo = MyUser.fromJson(userInfoMap!);
    userName = userInfo.name;
    userSurname = userInfo.surname;
    notifyListeners();
  }
}
