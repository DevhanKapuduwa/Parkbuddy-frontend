import 'package:flutter/cupertino.dart';
import 'package:plz/components/user.dart';

class UserProvider with ChangeNotifier {
  MobileUser _user;

  UserProvider(this._user);

  MobileUser get user => _user;
  set user(MobileUser newUser) {
    _user = newUser;
    notifyListeners();
  }
}
