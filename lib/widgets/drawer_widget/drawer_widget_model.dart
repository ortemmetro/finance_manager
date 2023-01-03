import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../entity/my_user.dart';
import '../../session/session_id_model.dart';

class DrawerWidgetModel extends ChangeNotifier {
  String userName = "";
  String userSurname = "";

  Future<void> getUserInfo(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;
    final sessionIdModel = Provider.of<SessionIdModel>(context, listen: false);
    final userId = await sessionIdModel.readUserId("uid");
    final docUsersReference = (await FirebaseFirestore.instance
            .collection('Users')
            .where("id", isEqualTo: userId)
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

  Future<void> signOut() async {
    userName = "";
    userSurname = "";
    FirebaseAuth.instance.signOut();
  }
}
