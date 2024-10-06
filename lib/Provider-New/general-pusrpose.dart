import 'package:flutter/cupertino.dart';

import '../Backend-New/Golbal-Files/category-and-subcategory.dart';

class GeneralPurposeProvider extends ChangeNotifier{
  String _userType =USERTYPE[0];
  String _date='Select OIO Date';

  String get userType=>_userType;
  String get date=>_date;

  void updateUserType(String value){
    _userType = value;
    notifyListeners();
  }
  void updateDate(String value){
    _date = value;
    notifyListeners();
  }

}