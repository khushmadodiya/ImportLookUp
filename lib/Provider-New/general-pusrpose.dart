import 'package:flutter/cupertino.dart';

import '../Backend-New/Golbal-Files/category-and-subcategory.dart';

class GeneralPurposeProvider extends ChangeNotifier{
  String _userType =USERTYPE[0];
  int _selectedIndex=0;
  String _date='Select OIO Date';
  String _selectedDisposalValue='In favor of Department';

  String get userType=>_userType;
  String get date=>_date;
  int get selectedIndex=>_selectedIndex;
  String get selectedDisposalValue =>_selectedDisposalValue;

  void updateUserType(String value){
    _userType = value;
    notifyListeners();
  }
  void updateDate(String value){
    _date = value;
    notifyListeners();
  }
  void updateSelectedIndex(int index){
    _selectedIndex=index;
    notifyListeners();
  }
  void updateSelectedDisposlaValue(String value){
    _selectedDisposalValue=value;
    notifyListeners();
  }


}