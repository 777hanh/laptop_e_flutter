import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/models/user.dart';
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

  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('User');
  //update user
  Future<void> updateUser(String? userName, userGender, userPhoneNumber, userId,
      address, userImage) async {
    await cartCollection.doc(userId).update({
      'UserName': userName,
      'UserGender': userGender,
      'address': address,
      'userImage': userImage,
      'phone': userPhoneNumber
    });
  }

  //get user buy userId

  List<UserModel> UserList = [];
  Future<void> getUserBuyIdList(String userId) async {
    UserModel? user;
    List<UserModel> newList = [];
    QuerySnapshot userSnapShot = await FirebaseFirestore.instance
        .collection('User')
        .where('UserId', isEqualTo: userId)
        .get();
    userSnapShot.docs.forEach(
      (i) {
        user = UserModel(
          userId: i['UserId'],
          userName: i['UserName'],
          userEmail: i['UserEmail'],
          userGender: i['UserGender'],
          userPhoneNumber: i['phone'],
          address: i['address'],
          userImage: i['userImage'],
        );
        newList.add(user!);
      },
    );
    UserList = newList;
  }

  List<UserModel> getUserById(String userId) {
    getUserBuyIdList(userId);
    return UserList;
  }
}
