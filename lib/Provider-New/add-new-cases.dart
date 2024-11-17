// import 'dart:core';
//
// import 'package:flutter/material.dart';
// import 'package:import_lookup/Backend-New/main-cases-details.dart';
// import 'package:import_lookup/Backend-New/request-cases-details.dart';
// import 'package:import_lookup/Model-New/main-case-model.dart';
// import 'package:import_lookup/Model-New/request-case-model.dart';
// import 'package:intl/intl.dart';
// // import 'package:provider/provider.dart';
//
// class AddNewCase with ChangeNotifier {
//   // Define controllers
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _formationController = TextEditingController();
//   final TextEditingController _oioController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _dutyOfArrearController = TextEditingController();
//   final TextEditingController _penaltyController = TextEditingController();
//   final TextEditingController _amountRecoveredController = TextEditingController();
//   final TextEditingController _preDepositController = TextEditingController();
//   final TextEditingController _interestController = TextEditingController();
//   final TextEditingController _totalArrearPendingController = TextEditingController();
//   final TextEditingController _briefFactController = TextEditingController();
//   final TextEditingController _statusController = TextEditingController();
//   final TextEditingController _appealNoController = TextEditingController();
//   final TextEditingController _stayOrderNumberAndDateController = TextEditingController();
//   final TextEditingController _iecController = TextEditingController();
//   final TextEditingController _gstinController = TextEditingController();
//   final TextEditingController _panController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _completeTrackController = TextEditingController();
//
// _  final TextEditingController _categoryController = TextEditingController();
//   final TextEditingController _effortMadeController = TextEditingController();
//   final TextEditingController _remarkController = TextEditingController();
//   final TextEditingController _subcategoryController = TextEditingController();
//
//
//
//   // Getters for each controller
//   TextEditingController get name => nameController;
//   TextEditingController get formation => formationController;
//   TextEditingController get oio => oioController;
//   TextEditingController get date => dateController;
//   TextEditingController get dutyOfArrear => dutyOfArrearController;
//   TextEditingController get penalty => penaltyController;
//   TextEditingController get amountRecovered => amountRecoveredController;
//   TextEditingController get preDeposit => preDepositController;
//   TextEditingController get interest => interestController;
//   TextEditingController get totalArrearPending => totalArrearPendingController;
//   TextEditingController get briefFact => briefFactController;
//   TextEditingController get status => statusController;
//   TextEditingController get appealNo => appealNoController;
//   TextEditingController get stayOrderNumberAndDate => stayOrderNumberAndDateController;
//   TextEditingController get iec => iecController;
//   TextEditingController get gstin => gstinController;
//   TextEditingController get pan => panController;
//   TextEditingController get age => ageController;
//   TextEditingController get completeTrack => completeTrackController;
//   TextEditingController get category => categoryController;
//   TextEditingController get effortMade => effortMadeController;
//   TextEditingController get remark => remarkController;
//   TextEditingController get subcategory => subcategoryController;
//
//
//   //this or data
//   List<MainCaseModel>_mainCaseData=[];
//   List<RequestCaseModel>_requestCaseData=[];
//
//   List<MainCaseModel> get mainCaseData=>_mainCaseData;
//   List<RequestCaseModel> get requestCaseData=>_requestCaseData;
//
//
//   Future getMainCasesInformation({required String formation,required isAdmin})async{
//     if(!isAdmin){
//     _mainCaseData=(await MainCasesInformation().getFormationMainCaseInformation(formation))["res"];
//     }else{
//       _mainCaseData=(await MainCasesInformation().getAllMainCasesDetails())["res"];
//     }
//     notifyListeners();
//   }
//   Future getRequestCasesInformation({required formation,required isAdmin})async{
//     if(isAdmin){
//       _requestCaseData=(await RequestCasesInformation().getFormationRequestedCaseInformation(formation))["res"];
//     }else{
//       _requestCaseData=(await RequestCasesInformation().getAllReuqestCasesDetails())["res"];
//     }
//     notifyListeners();
//   }
//   Future<void> addMainCase(bool isAdmin) async {
//     await MainCasesInformation().addCases(
//       uid: '',
//       name: nameController.text, // Use the controller's text directly
//       formation: formationController.text,
//       oio: oioController.text,
//       date: dateController.text,
//       dutyOfArrear: dutyOfArrearController.text,
//       penalty: penaltyController.text,
//       amountRecovered: amountRecoveredController.text,
//       preDeposit: preDepositController.text,
//       // interest: intestController.text,
//       totalArrearPending: totalArrearPendingController.text,
//       briefFact: briefFactController.text,
//       status: statusController.text,
//       // appealNo: appealNoController.text,
//       stayOrderNumberAndDate: stayOrderNumberAndDateController.text,
//       iec: iecController.text,
//       gstin: gstinController.text,
//       pan: panController.text,
//       completeTrack:["On Date ${DateFormat('dd/mm/yyyy').format(DateTime.now())} case is in ${categoryController.text}  ${subcategoryController.text}"],
//       category: categoryController.text,
//       remark: remarkController.text,
//       subcategory: subcategoryController.text,
//       effortMade: effortMadeController.text,
//       intrest: interestController.text,
//       apealNo: appealNoController.text,
//
//     );
//   }
//
//
//   //upadte maincase deatils
//     Future<void> updataMainCaseDetails(bool isAdmin,{required String uid,required bool isShifted}) async {
//     await MainCasesInformation().updateCaseDetails(
//       uid:uid,
//       name: nameController.text, // Use the controller's text directly
//       formation: formationController.text,
//       oio: oioController.text,
//       date: dateController.text,
//       dutyOfArrear: dutyOfArrearController.text,
//       penalty: penaltyController.text,
//       amountRecovered: amountRecoveredController.text,
//       preDeposit: preDepositController.text,
//       // interest: intestController.text,
//       totalArrearPending: totalArrearPendingController.text,
//       briefFact: briefFactController.text,
//       status: statusController.text,
//       // appealNo: appealNoController.text,
//       stayOrderNumberAndDate: stayOrderNumberAndDateController.text,
//       iec: iecController.text,
//       gstin: gstinController.text,
//       pan: panController.text,
//       completeTrack:"On date ${DateFormat('dd/mm/yyyy').format(DateTime.now())} case is in $category $subcategory",
//       category: categoryController.text,
//       remark: remarkController.text,
//       subcategory: subcategoryController.text,
//       effortMade: effortMadeController.text,
//       intrest: interestController.text,
//       apealNo: appealNoController.text,
//       isShifted:isShifted,
//       // isTotalArrearPendingUpadte:isToatalArrearPendingUpadte
//
//     );
//   }
//
//   //add case request
//   // pass old data and uid as empty if new case request if you are requesting to update old case data then pass old data + uid
//     Future<void> addRequestCase(bool isAdmin,{required String uid,required Map<String,dynamic>oldData,required bool isShifted}) async {
//     await RequestCasesInformation().addCases(
//       uid:uid,
//       oldData:oldData,
//       name: nameController.text,
//       formation: formationController.text,
//       oio: oioController.text,
//       date: dateController.text,
//       dutyOfArrear: dutyOfArrearController.text,
//       penalty: penaltyController.text,
//       amountRecovered: amountRecoveredController.text,
//       preDeposit: preDepositController.text,
//       // interest: intestController.text,
//       totalArrearPending: totalArrearPendingController.text,
//       briefFact: briefFactController.text,
//       status: statusController.text,
//       // appealNo: appealNoController.text,
//       stayOrderNumberAndDate: stayOrderNumberAndDateController.text,
//       iec: iecController.text,
//       gstin: gstinController.text,
//       pan: panController.text,
//       completeTrack:"On Date ${DateFormat('dd/mm/yyyy').format(DateTime.now())} case is in ${categoryController.text}  ${subcategoryController.text}",
//       category: categoryController.text,
//       remark: remarkController.text,
//       subcategory: subcategoryController.text,
//       effortMade: effortMadeController.text,
//       intrest: interestController.text,
//       apealNo: appealNoController.text,
//       isShifted:isShifted
//
//     );
//   }
//
//   // update data of requested cases
//    Future<void> updateRequestCase(bool isAdmin,{required String uid,required Map<String,dynamic>oldData,required bool isShifted}) async {
//     await RequestCasesInformation().addCases(
//       uid:uid,
//       oldData:oldData,
//       name: nameController.text,
//       formation: formationController.text,
//       oio: oioController.text,
//       date: dateController.text,
//       dutyOfArrear: dutyOfArrearController.text,
//       penalty: penaltyController.text,
//       amountRecovered: amountRecoveredController.text,
//       preDeposit: preDepositController.text,
//       // interest: intestController.text,
//       totalArrearPending: totalArrearPendingController.text,
//       briefFact: briefFactController.text,
//       status: statusController.text,
//       // appealNo: appealNoController.text,
//       stayOrderNumberAndDate: stayOrderNumberAndDateController.text,
//       iec: iecController.text,
//       gstin: gstinController.text,
//       pan: panController.text,
//       completeTrack:"On Date ${DateFormat('dd/mm/yyyy').format(DateTime.now())} case is in ${categoryController.text}  ${subcategoryController.text}",
//       category: categoryController.text,
//       remark: remarkController.text,
//       subcategory: subcategoryController.text,
//       effortMade: effortMadeController.text,
//       intrest: interestController.text,
//       apealNo: appealNoController.text,
//       isShifted:isShifted
//
//     );
//   }
//
//   // Dispose controllers when no longer needed
//   @override
//   void dispose() {
//     nameController.dispose();
//     formationController.dispose();
//     oioController.dispose();
//     dateController.dispose();
//     dutyOfArrearController.dispose();
//     penaltyController.dispose();
//     amountRecoveredController.dispose();
//     preDepositController.dispose();
//     interestController.dispose();
//     totalArrearPendingController.dispose();
//     briefFactController.dispose();
//     statusController.dispose();
//     appealNoController.dispose();
//     stayOrderNumberAndDateController.dispose();
//     iecController.dispose();
//     gstinController.dispose();
//     panController.dispose();
//     ageController.dispose();
//     completeTrackController.dispose();
//     categoryController.dispose();
//     effortMadeController.dispose();
//     remarkController.dispose();
//     subcategoryController.dispose();
//     super.dispose();
//   }
//
//   void clear() {
//     nameController.clear();
//     formationController.clear();
//     oioController.clear();
//     dateController.clear();
//     dutyOfArrearController.clear();
//     penaltyController.clear();
//     amountRecoveredController.clear();
//     preDepositController.clear();
//     interestController.clear();
//     totalArrearPendingController.clear();
//     briefFactController.clear();
//     statusController.clear();
//     appealNoController.clear();
//     stayOrderNumberAndDateController.clear();
//     iecController.clear();
//     gstinController.clear();
//     panController.clear();
//     ageController.clear();
//     completeTrackController.clear();
//     categoryController.clear();
//     effortMadeController.clear();
//     remarkController.clear();
//     subcategoryController.clear();
//     // super.clear();
//   }
// }
import 'dart:async';

import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/Backend-New/main-cases-details.dart';
import 'package:import_lookup/Backend-New/request-cases-details.dart';
import 'package:import_lookup/Backend-New/tar-report.dart';
import 'package:import_lookup/Model-New/main-case-model.dart';
import 'package:import_lookup/Model-New/request-case-model.dart';
import 'package:import_lookup/Model-New/tar-model.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Backend-New/Golbal-Files/category-and-subcategory.dart';
// import 'package:provider/provider.dart';

class AddNewCase with ChangeNotifier {
  // Define controllers as private
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _formationController = TextEditingController();
  final TextEditingController _oioController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _dutyOfArrearController = TextEditingController();
  final TextEditingController _penaltyController = TextEditingController();
  final TextEditingController _amountRecoveredController =
      TextEditingController();
  final TextEditingController _preDepositController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _totalArrearPendingController =
      TextEditingController();
  final TextEditingController _briefFactController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _appealNoController = TextEditingController();
  final TextEditingController _stayOrderNumberAndDateController =
      TextEditingController();
  final TextEditingController _iecController = TextEditingController();
  final TextEditingController _gstinController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _completeTrackController =
      TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _effortMadeController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final TextEditingController _subcategoryController = TextEditingController();
  bool _isLoading = false;
  bool _excelLoader = false;
  bool _tarLoader = false;

  // Getters for each controller
  bool get isLoading => _isLoading;
  bool get excelLoader => _excelLoader;
  bool get tarLoader => _tarLoader;
  TextEditingController get name => _nameController;
  TextEditingController get formation => _formationController;
  TextEditingController get oio => _oioController;
  TextEditingController get date => _dateController;
  TextEditingController get dutyOfArrear => _dutyOfArrearController;
  TextEditingController get penalty => _penaltyController;
  TextEditingController get amountRecovered => _amountRecoveredController;
  TextEditingController get preDeposit => _preDepositController;
  TextEditingController get interest => _interestController;
  TextEditingController get totalArrearPending => _totalArrearPendingController;
  TextEditingController get briefFact => _briefFactController;
  TextEditingController get status => _statusController;
  TextEditingController get appealNo => _appealNoController;
  TextEditingController get stayOrderNumberAndDate =>
      _stayOrderNumberAndDateController;
  TextEditingController get iec => _iecController;
  TextEditingController get gstin => _gstinController;
  TextEditingController get pan => _panController;
  TextEditingController get age => _ageController;
  TextEditingController get completeTrack => _completeTrackController;
  TextEditingController get category => _categoryController;
  TextEditingController get effortMade => _effortMadeController;
  TextEditingController get remark => _remarkController;
  TextEditingController get subcategory => _subcategoryController;

  //this or data
  List<MainCaseModel> _mainCaseData = [];
  List<MainCaseModel> _allMainCaseData = [];
  List<RequestCaseModel> _requestCaseData = [];

  List<MainCaseModel> get mainCaseData => _mainCaseData;
  List<MainCaseModel> get allMainCaseData => _mainCaseData;
  List<RequestCaseModel> get requestCaseData => _requestCaseData;

  void updateExcelLoader(){
     _excelLoader = !_excelLoader;
     notifyListeners();
  }
  void updateTarLoader(){
     _tarLoader = !_tarLoader;
     notifyListeners();
  }
  void updateSubcategory(String subCatregory) {
    subcategory.text = subCatregory;
  }

  void setDate(String date) {
    _dateController.text = date;
    notifyListeners();
  }

  //update loader
  void updateLoader() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  // Setters for each property
  void setName(String newName) {
    _nameController.text = newName;
    notifyListeners();
  }

  void setFormation(String newFormation) {
    _formationController.text = newFormation;
    notifyListeners();
  }

  void setOio(String newOio) {
    _oioController.text = newOio;
    notifyListeners();
  }

  void setDutyOfArrear(String newDutyOfArrear) {
    _dutyOfArrearController.text = newDutyOfArrear;
    notifyListeners();
  }

  void setPenalty(String newPenalty) {
    _penaltyController.text = newPenalty;
    notifyListeners();
  }

  void setAmountRecovered(String newAmountRecovered) {
    _amountRecoveredController.text = newAmountRecovered;
    notifyListeners();
  }

  void setPreDeposit(String newPreDeposit) {
    _preDepositController.text = newPreDeposit;
    notifyListeners();
  }

  void setInterest(String newInterest) {
    _interestController.text = newInterest;
    notifyListeners();
  }

  void setTotalArrearPending(String newTotalArrearPending) {
    _totalArrearPendingController.text = newTotalArrearPending;
    notifyListeners();
  }

  void setBriefFact(String newBriefFact) {
    _briefFactController.text = newBriefFact;
    notifyListeners();
  }

  void setStatus(String newStatus) {
    _statusController.text = newStatus;
    notifyListeners();
  }

  void setAppealNo(String newAppealNo) {
    _appealNoController.text = newAppealNo;
    notifyListeners();
  }

  void setStayOrderNumberAndDate(String newStayOrderNumberAndDate) {
    _stayOrderNumberAndDateController.text = newStayOrderNumberAndDate;
    notifyListeners();
  }

  void setIec(String newIec) {
    _iecController.text = newIec;
    notifyListeners();
  }

  void setGstin(String newGstin) {
    _gstinController.text = newGstin;
    notifyListeners();
  }

  void setPan(String newPan) {
    _panController.text = newPan;
    notifyListeners();
  }

  void setAge(String newAge) {
    _ageController.text = newAge;
    notifyListeners();
  }

  void setCompleteTrack(String newCompleteTrack) {
    _completeTrackController.text = newCompleteTrack;
    notifyListeners();
  }

  void setCategory(String newCategory) {
    _categoryController.text = newCategory;
    notifyListeners();
  }

  void setEffortMade(String newEffortMade) {
    _effortMadeController.text = newEffortMade;
    notifyListeners();
  }

  void setRemark(String newRemark) {
    _remarkController.text = newRemark;
    notifyListeners();
  }

  void setSubcategory(String newSubcategory) {
    _subcategoryController.text = newSubcategory;
    notifyListeners();
  }

  Future getMainCasesInformation(
      {required String formation, required bool isAdmin}) async {
    if (!isAdmin) {
      _mainCaseData = (await MainCasesInformation()
          .getFormationMainCaseInformation(formation))["res"];
    } else {
      _mainCaseData =
          (await MainCasesInformation().getAllMainCasesDetails())["res"];
    }
    notifyListeners();
  }

  Future getRequestCasesInformation(
      {required String formation, required bool isAdmin}) async {
    if (!isAdmin) {
      _requestCaseData = (await RequestCasesInformation()
          .getFormationRequestedCaseInformation(formation))["res"];
    } else {
      _requestCaseData =
          (await RequestCasesInformation().getAllReuqestCasesDetails())["res"];
    }
    notifyListeners();
    return {"res": "success"};
  }

  Future addMainCase() async {
    var res = await MainCasesInformation().addCases(
      uid: '',
      name: _nameController.text, // Use the controller's text directly
      formation: _formationController.text,
      oio: _oioController.text,
      date: _dateController.text,
      dutyOfArrear: _dutyOfArrearController.text,
      penalty: _penaltyController.text,
      amountRecovered: _amountRecoveredController.text,
      preDeposit: _preDepositController.text,
      totalArrearPending: _totalArrearPendingController.text,
      briefFact: _briefFactController.text,
      status: _statusController.text,
      stayOrderNumberAndDate: _stayOrderNumberAndDateController.text,
      iec: _iecController.text,
      gstin: _gstinController.text,
      pan: _panController.text,
      completeTrack: [
        "On Date ${DateFormat('dd/MM/yyyy').format(DateTime.now())} case is in ${_categoryController.text}  ${_subcategoryController.text}"
      ],
      category: _categoryController.text,
      remark: _remarkController.text,
      subcategory: _subcategoryController.text,
      effortMade: _effortMadeController.text,
      intrest: _interestController.text,
      apealNo: _appealNoController.text,
    );
    return res;
  }

  // Update main case details
  Future updateMainCaseDetails(bool isAdmin,
      {required String uid,
      required bool isShifted,
      required MainCaseModel oldDataModel}) async {
    var res = await MainCasesInformation().updateCaseDetails(
      oldDataModel: oldDataModel,
      uid: uid,
      name: _nameController.text, // Use the controller's text directly
      formation: _formationController.text,
      oio: _oioController.text,
      date: _dateController.text,
      dutyOfArrear: _dutyOfArrearController.text,
      penalty: _penaltyController.text,
      amountRecovered: _amountRecoveredController.text,
      preDeposit: _preDepositController.text,
      totalArrearPending: _totalArrearPendingController.text,
      briefFact: _briefFactController.text,
      status: _statusController.text,
      stayOrderNumberAndDate: _stayOrderNumberAndDateController.text,
      iec: _iecController.text,
      gstin: _gstinController.text,
      pan: _panController.text,
      completeTrack:
          "On date ${DateFormat('dd/MM/yyyy').format(DateTime.now())} case is in ${_categoryController.text} ${_subcategoryController.text}",
      category: _categoryController.text,
      remark: _remarkController.text,
      subcategory: _subcategoryController.text,
      effortMade: _effortMadeController.text,
      intrest: _interestController.text,
      apealNo: _appealNoController.text,
      isShifted: isShifted,
    );
    return res;
  }

  // Add case request
  Future addRequestCase(bool isAdmin,
      {required String uid,
      required Map<String, dynamic> oldData,
      required bool isShifted}) async {
    var res = await RequestCasesInformation().addCases(
      uid: uid,
      oldData: oldData,
      name: _nameController.text,
      formation: _formationController.text,
      oio: _oioController.text,
      date: _dateController.text,
      dutyOfArrear: _dutyOfArrearController.text,
      penalty: _penaltyController.text,
      amountRecovered: _amountRecoveredController.text,
      preDeposit: _preDepositController.text,
      totalArrearPending: _totalArrearPendingController.text,
      briefFact: _briefFactController.text,
      status: _statusController.text,
      stayOrderNumberAndDate: _stayOrderNumberAndDateController.text,
      iec: _iecController.text,
      gstin: _gstinController.text,
      pan: _panController.text,
      completeTrack:
          "On Date ${DateFormat('dd/MM/yyyy').format(DateTime.now())} case is in ${_categoryController.text}  ${_subcategoryController.text}",
      category: _categoryController.text,
      remark: _remarkController.text,
      subcategory: _subcategoryController.text,
      effortMade: _effortMadeController.text,
      intrest: _interestController.text,
      apealNo: _appealNoController.text,
      isShifted: isShifted,
    );
    return res;
  }

  // Update data of requested cases
  Future updateRequestCase(bool isAdmin,
      {required String uid,
      required Map<String, dynamic> oldData,
      required bool isShifted}) async {
    var res = await RequestCasesInformation().addCases(
      uid: uid,
      oldData: oldData,
      name: _nameController.text,
      formation: _formationController.text,
      oio: _oioController.text,
      date: _dateController.text,
      dutyOfArrear: _dutyOfArrearController.text,
      penalty: _penaltyController.text,
      amountRecovered: _amountRecoveredController.text,
      preDeposit: _preDepositController.text,
      totalArrearPending: _totalArrearPendingController.text,
      briefFact: _briefFactController.text,
      status: _statusController.text,
      stayOrderNumberAndDate: _stayOrderNumberAndDateController.text,
      iec: _iecController.text,
      gstin: _gstinController.text,
      pan: _panController.text,
      completeTrack:
          "On Date ${DateFormat('dd/MM/yyyy').format(DateTime.now())} case is in ${_categoryController.text}  ${_subcategoryController.text}",
      category: _categoryController.text,
      remark: _remarkController.text,
      subcategory: _subcategoryController.text,
      effortMade: _effortMadeController.text,
      intrest: _interestController.text,
      apealNo: _appealNoController.text,
      isShifted: isShifted,
    );
    return res;
  }

  //acceptRequest usin admin
  Future acceptRequestByAdmin(
      {required String uid,
      required String formation,
      required bool isRequest}) async {
    var res = RequestCasesInformation().acceptRequest(
      uid: uid,
      name: _nameController.text,
      formation: formation,
      oio: _oioController.text,
      date: _dateController.text,
      dutyOfArrear: _dutyOfArrearController.text,
      penalty: _penaltyController.text,
      amountRecovered: _amountRecoveredController.text,
      preDeposit: _preDepositController.text,
      intrest: _interestController.text,
      totalArrearPending: _totalArrearPendingController.text,
      briefFact: _briefFactController.text,
      status: _statusController.text,
      apealNo: _appealNoController.text,
      stayOrderNumberAndDate: _stayOrderNumberAndDateController.text,
      iec: _iecController.text,
      gstin: _gstinController.text,
      pan: _panController.text,
      completeTrack: [_completeTrackController.text],
      category: _categoryController.text,
      remark: _remarkController.text,
      subcategory: _subcategoryController.text,
      effortMade: _effortMadeController.text,
      isRequest: true,
    );
    return res;
  }

  //reject request
  Future rejectRequest({required String uid, required String formation}) async {
    var res = await RequestCasesInformation()
        .rejectRequest(uid: uid, formation: formation);
    return res;
  }

  //getTarReport Infromation
  Future getTarReport() async {}

  // Dispose controllers when no longer needed
  @override
  void dispose() {
    _nameController.dispose();
    _formationController.dispose();
    _oioController.dispose();
    _dateController.dispose();
    _dutyOfArrearController.dispose();
    _penaltyController.dispose();
    _amountRecoveredController.dispose();
    _preDepositController.dispose();
    _interestController.dispose();
    _totalArrearPendingController.dispose();
    _briefFactController.dispose();
    _statusController.dispose();
    _appealNoController.dispose();
    _stayOrderNumberAndDateController.dispose();
    _iecController.dispose();
    _gstinController.dispose();
    _panController.dispose();
    _ageController.dispose();
    _completeTrackController.dispose();
    _categoryController.dispose();
    _effortMadeController.dispose();
    _remarkController.dispose();
    _subcategoryController.dispose();
    super.dispose();
  }

  //get replication data
  Future getMainCasesFromReplication({required String query}) async {
    // print("i am djjdnjdn");
    _mainCaseData = (await MainCasesInformation()
        .getReplicateMainCase(category: query))["res"];

    notifyListeners();
  }

  //get Tar report  data
  //     "arrear in litigation",
//     "restrained arrear",
//     "arrears where appeal period not over",
//     "recoverable arrears",
//     "arrears pending for write-off"
  List<TarReportModel?> _litigationCompleteData = [];
  List<TarReportModel?> _restrainedCompleteData = [];
  List<TarReportModel?> _apealPeriodNotOverCompleteData = [];
  List<TarReportModel?> _recoverableCompleteData = [];
  List<TarReportModel?> _writeOffCompleteData = [];

  Map<String, TarReportModel> _arrearLitigation = {};
  Map<String, TarReportModel> _restrainded = {};
  Map<String, TarReportModel> _appealPeriodNotOver = {};
  Map<String, TarReportModel> _recoverable = {};
  Map<String, TarReportModel> _writeOff = {};
  Map<String, TarReportModel> get arrearLitigation => _arrearLitigation;
  Map<String, TarReportModel> get restrainded => _restrainded;
  Map<String, TarReportModel> get appealPeriodNotOver => _appealPeriodNotOver;
  Map<String, TarReportModel> get writeOff => _writeOff;

  List<TarReportModel?> get litigationCompleteData => _litigationCompleteData;
  List<TarReportModel?> get restrainedCompleteData => _restrainedCompleteData;
  List<TarReportModel?> get apealPeiodNotOverCompleteData => _apealPeriodNotOverCompleteData;
  List<TarReportModel?> get recoverableCompleteData => _recoverableCompleteData;
  List<TarReportModel?> get writeOffCompleteData => _writeOffCompleteData;

  Map<String , TocModel> _allTocdata = {};
  List<TocModel> _arrearTocLitgation = [];
  List<TocModel> _arrearTocRestrained = [];
  List<TocModel> _arrearTocRecoverable = [];
  TocModel ?_arrearTocWhereApealPeriodNotOver ;
  TocModel? _arrearTocPendingForWirteOff;
  Map<String , TocModel> get allTocdata => _allTocdata;
  List<TocModel> get arrearTocLitgation => _arrearTocLitgation;
  List<TocModel> get arrearTocRestrained => _arrearTocRestrained;
  TocModel get arrearTocWhereApealPeriodNotOver => _arrearTocWhereApealPeriodNotOver!;
  List<TocModel> get arrearTocRecoverable => _arrearTocRecoverable;
  TocModel get arrearTocPendingForWirteOff => _arrearTocPendingForWirteOff!;


  Future getAllSubcategoryTocdata()async{
    print('hello i am khush');
    _allTocdata =  (await TarReportInformation().TocReport())['data'];
    print('hello i am khush$_allTocdata');
    for(int i=0;i<4;i++){
      _arrearTocLitgation.add(_allTocdata[TOCKEY[i]]!);
    }
    for(int i=4;i<8;i++){
      _arrearTocRestrained.add(_allTocdata[TOCKEY[i]]!);
    }
    _arrearTocWhereApealPeriodNotOver=_allTocdata[TOCKEY[8]]!;
    for(int i=9;i<13;i++){
      _arrearTocRecoverable.add(_allTocdata[TOCKEY[i]]!);
    }
    _arrearTocPendingForWirteOff=_allTocdata[TOCKEY[13]]!;

     // print(_allTocdata['sctoc']!.);
     notifyListeners();
  }


  Future tarArrearLitigation() async {
    _arrearLitigation = (await TarReportInformation().litigationReport())["data"];
    for (var i in LITIGATIONKEYS.keys) {
      for (int j = 0; j < LITIGATIONKEYS[i]!.length; j++) {
        _litigationCompleteData.add(_arrearLitigation[LITIGATIONKEYS![i]![j]]);
      }
    }
    notifyListeners();
  }

  Future tarRestrainded() async {
    _restrainded =
        (await TarReportInformation().restrainedArrearReport())["data"];
    for (var i in RESTRAINEDKEYS.keys) {
      for (int j = 0; j < RESTRAINEDKEYS[i]!.length; j++) {
        _restrainedCompleteData.add(_restrainded[RESTRAINEDKEYS![i]![j]]);
      }
    }
    notifyListeners();
  }

  Future tarAppealPeriodNotOver() async {
    _appealPeriodNotOver =
        (await TarReportInformation().periodNotOver())["data"];
    for (var i in PERIODNOTOVERKEYS.keys) {
      for (int j = 0; j < PERIODNOTOVERKEYS[i]!.length; j++) {
        _apealPeriodNotOverCompleteData
            .add(_appealPeriodNotOver[PERIODNOTOVERKEYS![i]![j]]);
      }
    }

    notifyListeners();
  }

  Future tarRecoverable() async {
    _recoverable = (await TarReportInformation().recoverableArrears())["data"];
    for (var i in RECOVERABLEKEYS.keys) {
      for (int j = 0; j < RECOVERABLEKEYS[i]!.length; j++) {
        _recoverableCompleteData.add(_recoverable[RECOVERABLEKEYS![i]![j]]);
      }
    }

    notifyListeners();
  }

  Future tarWriteOff() async {
    _writeOff = (await TarReportInformation().writeOff())["data"];
    for (var i in WRITEOFFKEYS.keys) {
      for (int j = 0; j < WRITEOFFKEYS[i]!.length; j++) {
        _writeOffCompleteData.add(_writeOff[WRITEOFFKEYS![i]![j]]);
      }
    }

    notifyListeners();
  }

  void clear() {
    _nameController.clear();
    _formationController.clear();
    _oioController.clear();
    _dateController.clear();
    _dutyOfArrearController.clear();
    _penaltyController.clear();
    _amountRecoveredController.clear();
    _preDepositController.clear();
    _interestController.clear();
    _totalArrearPendingController.clear();
    _briefFactController.clear();
    _statusController.clear();
    _appealNoController.clear();
    _stayOrderNumberAndDateController.clear();
    _iecController.clear();
    _gstinController.clear();
    _panController.clear();
    _ageController.clear();
    _completeTrackController.clear();
    _categoryController.clear();
    _effortMadeController.clear();
    _remarkController.clear();
    _subcategoryController.clear();
  }
}
