import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../entity/myUser.dart';
import '../../session/session_key.dart';

class DrawerWidgetModel extends ChangeNotifier {
  String userName = '';
  String userSurname = '';
  void getUserInfo() async {
    final docUsersReference = (await FirebaseFirestore.instance
            .collection('Users')
            .where("id", isEqualTo: SessionKey.currentUserId)
            .get())
        .docs
        .first
        .reference;
    final userInfoObject = await docUsersReference.get();
    final userInfoMap = userInfoObject.data();
    final userInfo = MyUser.fromJson(userInfoMap!);
    userName = userInfo.firstName;
    userSurname = userInfo.lastName;
    notifyListeners();
  }
}
