import 'package:flutter/cupertino.dart';
import 'package:import_lookup/Backend-New/financial-year.dart';

import '../Backend-New/Golbal-Files/category-and-subcategory.dart';
import '../Model-New/main-case-model.dart';

class GeneralPurposeProvider extends ChangeNotifier{
  String _userType =USERTYPE[0];
  int _selectedIndex=0;
  String _date='Select OIO Date';
  String _selectedDisposalValue="disposal in favour of the department";
  String? _currentMonth;
  String? _endDate;
  String? _startDate;
  bool  _ispass = false;
  String _searchQuery = '';
  String _formationSearch = '';
  List<MainCaseModel> _searchData = [];

  String get searchQuery => _searchQuery;
  String get formationSearch => _formationSearch;
  String get userType=>_userType;
  String get date=>_date;
  int get selectedIndex=>_selectedIndex;
  String get selectedDisposalValue =>_selectedDisposalValue;
  String? get currentMonth => _currentMonth;
  String? get endDate => _endDate;
  String? get startDate => _startDate;
  bool get ispass => _ispass;
  List<MainCaseModel> get searchData => _searchData;



  void updateSearchDate(List<MainCaseModel> data){
    _searchData = data;
    notifyListeners();
  }


  void updateSearchQuery(String val){
    _searchQuery = val;
    notifyListeners();
  }
  void updateFormationSearch(String val){
    _formationSearch = val;
    notifyListeners();
  }
  void updatePass(){
    _ispass = !_ispass;
    notifyListeners();
  }

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
  
  Future<List<String>> getFinancialData()async{
    var res =  await  FinancialYear().getFinancialData();
    print(res['res']);
     if(res['res']=="success"){
       return [res['data']['current month'],  res['data']['financial year start date'], res['data']['financial year end date']];
     
     }
     return [];
  }

  void updateFinancialVars(String currentMonth,String startDate ,String endDate){
          _currentMonth = currentMonth;
          notifyListeners();
          _startDate = startDate;
          notifyListeners();
          _endDate = endDate;
          notifyListeners();
  }


}