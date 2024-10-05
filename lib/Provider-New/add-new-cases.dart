import 'dart:core';

import 'package:flutter/material.dart';
import 'package:import_lookup/Backend-New/main-cases-details.dart';
import 'package:import_lookup/Backend-New/request-cases-details.dart';
import 'package:import_lookup/Model-New/main-case-model.dart';
import 'package:import_lookup/Model-New/request-case-model.dart';
import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

class AddNewCase with ChangeNotifier {
  // Define controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController formationController = TextEditingController();
  final TextEditingController oioController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController dutyOfArrearController = TextEditingController();
  final TextEditingController penaltyController = TextEditingController();
  final TextEditingController amountRecoveredController = TextEditingController();
  final TextEditingController preDepositController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final TextEditingController totalArrearPendingController = TextEditingController();
  final TextEditingController briefFactController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController appealNoController = TextEditingController();
  final TextEditingController stayOrderNumberAndDateController = TextEditingController();
  final TextEditingController iecController = TextEditingController();
  final TextEditingController gstinController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController ageController = TextEditingController(); 
  final TextEditingController completeTrackController = TextEditingController();
  
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController effortMadeController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final TextEditingController subcategoryController = TextEditingController();

  // Getters for each controller
  TextEditingController get name => nameController;
  TextEditingController get formation => formationController;
  TextEditingController get oio => oioController;
  TextEditingController get date => dateController;
  TextEditingController get dutyOfArrear => dutyOfArrearController;
  TextEditingController get penalty => penaltyController;
  TextEditingController get amountRecovered => amountRecoveredController;
  TextEditingController get preDeposit => preDepositController;
  TextEditingController get interest => interestController;
  TextEditingController get totalArrearPending => totalArrearPendingController;
  TextEditingController get briefFact => briefFactController;
  TextEditingController get status => statusController;
  TextEditingController get appealNo => appealNoController;
  TextEditingController get stayOrderNumberAndDate => stayOrderNumberAndDateController;
  TextEditingController get iec => iecController;
  TextEditingController get gstin => gstinController;
  TextEditingController get pan => panController;
  TextEditingController get age => ageController;
  TextEditingController get completeTrack => completeTrackController;
  TextEditingController get category => categoryController;
  TextEditingController get effortMade => effortMadeController;
  TextEditingController get remark => remarkController;
  TextEditingController get subcategory => subcategoryController;


  //this or data
  List<MainCaseModel>_mainCaseData=[];
  List<RequestCaseModel>_requestCaseData=[];

  List<MainCaseModel> get mainCaseData=>_mainCaseData;
  List<RequestCaseModel> get requestCaseData=>_requestCaseData;


  Future getMainCasesInformation({required String formation,required isAdmin})async{
    if(!isAdmin){
    _mainCaseData=(await MainCasesInformation().getFormationMainCaseInformation(formation))["res"];
    }else{
      _mainCaseData=(await MainCasesInformation().getAllMainCasesDetails())["res"];
    }
    notifyListeners();
  }
  Future getRequestCasesInformation({required formation,required isAdmin})async{
    if(isAdmin){
      _requestCaseData=(await RequestCasesInformation().getFormationRequestedCaseInformation(formation))["res"];
    }else{
      _requestCaseData=(await RequestCasesInformation().getAllReuqestCasesDetails())["res"];
    }
    notifyListeners();
  }
  Future<void> addMainCase(bool isAdmin) async {
    await MainCasesInformation().addCases(
      uid: '',
      name: nameController.text, // Use the controller's text directly
      formation: formationController.text,
      oio: oioController.text,
      date: dateController.text,
      dutyOfArrear: dutyOfArrearController.text,
      penalty: penaltyController.text,
      amountRecovered: amountRecoveredController.text,
      preDeposit: preDepositController.text,
      // interest: intestController.text,
      totalArrearPending: totalArrearPendingController.text,
      briefFact: briefFactController.text,
      status: statusController.text,
      // appealNo: appealNoController.text,
      stayOrderNumberAndDate: stayOrderNumberAndDateController.text,
      iec: iecController.text,
      gstin: gstinController.text,
      pan: panController.text,
      completeTrack:["On Date ${DateFormat('dd/mm/yyyy').format(DateTime.now())} case is in ${categoryController.text}  ${subcategoryController.text}"],
      category: categoryController.text,
      remark: remarkController.text,
      subcategory: subcategoryController.text,
      effortMade: effortMadeController.text, 
      intrest: interestController.text, 
      apealNo: appealNoController.text,
      
    );
  }


  //upadte maincase deatils
    Future<void> updataMainCaseDetails(bool isAdmin,{required String uid,required bool isShifted}) async {
    await MainCasesInformation().updateCaseDetails(
      uid:uid,
      name: nameController.text, // Use the controller's text directly
      formation: formationController.text,
      oio: oioController.text,
      date: dateController.text,
      dutyOfArrear: dutyOfArrearController.text,
      penalty: penaltyController.text,
      amountRecovered: amountRecoveredController.text,
      preDeposit: preDepositController.text,
      // interest: intestController.text,
      totalArrearPending: totalArrearPendingController.text,
      briefFact: briefFactController.text,
      status: statusController.text,
      // appealNo: appealNoController.text,
      stayOrderNumberAndDate: stayOrderNumberAndDateController.text,
      iec: iecController.text,
      gstin: gstinController.text,
      pan: panController.text,
      completeTrack:"On date ${DateFormat('dd/mm/yyyy').format(DateTime.now())} case is in $category $subcategory",
      category: categoryController.text,
      remark: remarkController.text,
      subcategory: subcategoryController.text,
      effortMade: effortMadeController.text, 
      intrest: interestController.text, 
      apealNo: appealNoController.text,
      isShifted:isShifted,
      // isTotalArrearPendingUpadte:isToatalArrearPendingUpadte
      
    );
  }

  //add case request
  // pass old data and uid as empty if new case request if you are requesting to update old case data then pass old data + uid
    Future<void> addRequestCase(bool isAdmin,{required String uid,required Map<String,dynamic>oldData,required bool isShifted}) async {
    await RequestCasesInformation().addCases(
      uid:uid,
      oldData:oldData,
      name: nameController.text, 
      formation: formationController.text,
      oio: oioController.text,
      date: dateController.text,
      dutyOfArrear: dutyOfArrearController.text,
      penalty: penaltyController.text,
      amountRecovered: amountRecoveredController.text,
      preDeposit: preDepositController.text,
      // interest: intestController.text,
      totalArrearPending: totalArrearPendingController.text,
      briefFact: briefFactController.text,
      status: statusController.text,
      // appealNo: appealNoController.text,
      stayOrderNumberAndDate: stayOrderNumberAndDateController.text,
      iec: iecController.text,
      gstin: gstinController.text,
      pan: panController.text,
      completeTrack:"On Date ${DateFormat('dd/mm/yyyy').format(DateTime.now())} case is in ${categoryController.text}  ${subcategoryController.text}",
      category: categoryController.text,
      remark: remarkController.text,
      subcategory: subcategoryController.text,
      effortMade: effortMadeController.text, 
      intrest: interestController.text, 
      apealNo: appealNoController.text,
      isShifted:isShifted
      
    );
  }

  // update data of requested cases
   Future<void> updateRequestCase(bool isAdmin,{required String uid,required Map<String,dynamic>oldData,required bool isShifted}) async {
    await RequestCasesInformation().addCases(
      uid:uid,
      oldData:oldData,
      name: nameController.text, 
      formation: formationController.text,
      oio: oioController.text,
      date: dateController.text,
      dutyOfArrear: dutyOfArrearController.text,
      penalty: penaltyController.text,
      amountRecovered: amountRecoveredController.text,
      preDeposit: preDepositController.text,
      // interest: intestController.text,
      totalArrearPending: totalArrearPendingController.text,
      briefFact: briefFactController.text,
      status: statusController.text,
      // appealNo: appealNoController.text,
      stayOrderNumberAndDate: stayOrderNumberAndDateController.text,
      iec: iecController.text,
      gstin: gstinController.text,
      pan: panController.text,
      completeTrack:"On Date ${DateFormat('dd/mm/yyyy').format(DateTime.now())} case is in ${categoryController.text}  ${subcategoryController.text}",
      category: categoryController.text,
      remark: remarkController.text,
      subcategory: subcategoryController.text,
      effortMade: effortMadeController.text, 
      intrest: interestController.text, 
      apealNo: appealNoController.text,
      isShifted:isShifted
      
    );
  }

  // Dispose controllers when no longer needed
  @override
  void dispose() {
    nameController.dispose();
    formationController.dispose();
    oioController.dispose();
    dateController.dispose();
    dutyOfArrearController.dispose();
    penaltyController.dispose();
    amountRecoveredController.dispose();
    preDepositController.dispose();
    interestController.dispose();
    totalArrearPendingController.dispose();
    briefFactController.dispose();
    statusController.dispose();
    appealNoController.dispose();
    stayOrderNumberAndDateController.dispose();
    iecController.dispose();
    gstinController.dispose();
    panController.dispose();
    ageController.dispose();
    completeTrackController.dispose();
    categoryController.dispose();
    effortMadeController.dispose();
    remarkController.dispose();
    subcategoryController.dispose();
    super.dispose();
  }

  void clear() {
    nameController.clear();
    formationController.clear();
    oioController.clear();
    dateController.clear();
    dutyOfArrearController.clear();
    penaltyController.clear();
    amountRecoveredController.clear();
    preDepositController.clear();
    interestController.clear();
    totalArrearPendingController.clear();
    briefFactController.clear();
    statusController.clear();
    appealNoController.clear();
    stayOrderNumberAndDateController.clear();
    iecController.clear();
    gstinController.clear();
    panController.clear();
    ageController.clear();
    completeTrackController.clear();
    categoryController.clear();
    effortMadeController.clear();
    remarkController.clear();
    subcategoryController.clear();
    // super.clear();
  }
}
