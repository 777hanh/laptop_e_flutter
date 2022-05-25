import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  //get user id
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid;

  Future<String> getUidAuth() async {
    String userId = await auth.currentUser!.uid.toString();
    uid = userId;
    notifyListeners();
    return userId;
  }

  String get getUserId {
    return uid!;
  }

  Future<void> findUserId() async {
    getUidAuth();
  }
}
