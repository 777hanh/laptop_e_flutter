import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaptop/models/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class User_Provider {
  List<UserModel> allUserDataList = [];

  final CollectionReference allUserCollection =
      FirebaseFirestore.instance.collection('User');

  // String currentUser = FirebaseAuth.instance.currentUser != null
  //     ? FirebaseAuth.instance.currentUser!.uid
  //     : '';

  Stream<List<UserModel>> get allUsers {
    return allUserCollection.snapshots().map((snapshot) {
      return _userFromSnapShot(snapshot);
    });
  }

  List<UserModel> _userFromSnapShot(QuerySnapshot snapshot) {
    List<UserModel> newList = [];
    snapshot.docs.forEach((element) {
      UserModel user = UserModel(
        userId: element['UserId'],
        userName: element['UserName'],
        userEmail: element['UserEmail'],
        userGender: element['UserGender'],
        userPhoneNumber: element['phone'],
        address: element['address'],
      );
      newList.add(user);
    });
    allUserDataList = newList;
    return allUserDataList;
  }
}
