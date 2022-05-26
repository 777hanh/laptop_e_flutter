import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  //get user id
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid;

  Future<String> getUidAuth() async {
    String userId = await auth.currentUser!.uid.toString();
    uid = userId;
    return userId;
  }

  String get getUserId {
    return uid!;
  }
  //

}
