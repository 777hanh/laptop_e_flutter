import 'package:elaptop/models/user.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<String> notificationList = [];

  void addNotification(String notification) {
    notificationList.add(notification);
    notifyListeners();
  }

  void resetNotification() {
    print('logger');
    notificationList = [];
  }

  int get getNotificationIndex {
    // notifyListeners();
    return notificationList.length;
  }

  get getNotificationList {
    // notifyListeners();
    return notificationList;
  }
}
