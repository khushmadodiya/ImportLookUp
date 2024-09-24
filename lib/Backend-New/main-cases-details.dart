// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:import_lookup/Backend-New/tar-report.dart';
import 'package:import_lookup/Model-New/main-case-model.dart';
import 'package:uuid/uuid.dart';

class MainCasesInformation {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Future addCases(
      {required String uid,
      required String name,
      required String formation,
      required String oio,
      required String date,
      required String dutyOfArrear,
      required String penalty,
      required String amountRecovered,
      required String preDeposit,
      required String intrest,
      required String totalArrearPending,
      required String briefFact,
      required String status,
      required String apealNo,
      required String stayOrderNumberAndDate,
      required String iec,
      required String gstin,
      required String pan,
      double? age,
      required List<String> completeTrack,
      required String category,
      // required String efforMade,
      required String remark,
      required String subcategory,
      required String effortMade}) async {
    String uuid = const Uuid().v1();
    MainCaseModel model = MainCaseModel(
      category: category,
      completeTrack: completeTrack,
      uid: uuid,
      name: name,
      formation: formation,
      date: date,
      oio: oio,
      dutyOfArrear: dutyOfArrear,
      age: age,
      amountRecovered: amountRecovered,
      status: status,
      briefFact: briefFact,
      effortMade: effortMade,
      remark: remark,
      penalty: penalty,
      intrest: intrest,
      totalArrearPending: totalArrearPending,
      preDeposit: preDeposit,
      apealNo: apealNo,
      stayOrderNumberAndDate: stayOrderNumberAndDate,
      gstin: gstin,
      iec: iec,
      pan: pan,
      subcategory: subcategory,
    );
    try {
      DocumentReference formationDocRef =
          _fireStore.collection("MP").doc(formation);
      DocumentSnapshot docSnapshot = await formationDocRef.get();

      if (!docSnapshot.exists) {
        await _fireStore
            .collection("MP")
            .doc(formation)
            .set({}, SetOptions(merge: true));
      }

      _fireStore
          .collection("MP")
          .doc(formation)
          .collection('cases')
          .doc(uuid)
          .set(model.toJson());
      TarReportInformation().updateDataOfTarReport(category: category, subcategory: subcategory, docName:"receipts", noOfCasesOfTheMonth:1, noOfCasesUpToTheMonth:0, amountOfTheMonth:double.parse(totalArrearPending), amountUpTotheMonth:0, openingBalance:double.parse(totalArrearPending), closingBalance: 0);
      // _fireStore.collection("MP").doc(category).collection(subcategory).doc("receipts").set({data})
      return {"res": "success"};
    } catch (e) {
      return {"res": e.toString()};
    }
  }

  //get all maincases details
  Future getAllMainCasesDetails() async {
    List<Map<String, dynamic>> allCases = [];
    try {
      QuerySnapshot querySnapshot = await _fireStore.collection('MP').get();
      final Completer<String> completer = Completer<String>();
      if (querySnapshot.docs.isEmpty) {
        // print('No documents found in the MP collection  ');
        return allCases;
      } else {
        querySnapshot.docs.forEach((doc) async {
          QuerySnapshot qsnap = await _fireStore
              .collection("MP")
              .doc(doc.id)
              .collection("cases")
              .get();
          for (var val in qsnap.docs) {
            allCases.add(val.data() as Map<String, dynamic>);
          }
          completer.complete("Success");
        });
        await completer.future;

        return allCases;
      }
    } catch (e) {
      print("i am in errro");
      return [
        {"error": "Some Error Occured"}
      ];
    }
  }

  //this is form main cases

  Future updateCaseDetails(
      {required String uid,
      required String name,
      required String formation,
      required String oio,
      required String date,
      required String dutyOfArrear,
      required String penalty,
      required String amountRecovered,
      required String preDeposit,
      required String intrest,
      required String totalArrearPending,
      required String briefFact,
      required String status,
      required String apealNo,
      required String stayOrderNumberAndDate,
      required String iec,
      required String gstin,
      required String pan,
      double? age,
      required String completeTrack,
      required String category,
      // required String efforMade,
      required String remark,
      required String subcategory,
      required String effortMade,
      required bool isShifted,
      }
      ) async {
 DocumentSnapshot _snap=await _fireStore
          .collection("MP")
          .doc(formation)
          .collection('cases')
          .doc(uid)
          .get();
    if(_snap.exists){
      List<String>trac=List<String>.from((_snap.data() as Map<String,dynamic>)['completeTrack']);
      if(isShifted){
      trac.add(completeTrack);
      }
      if((_snap.data() as Map<String,dynamic>)['totalArrearPending'].toString()!=totalArrearPending){
        TarReportInformation().updateDataOfTarReport(category: category, subcategory: subcategory, docName:"receipts", noOfCasesOfTheMonth:0, noOfCasesUpToTheMonth:0, amountOfTheMonth:double.parse(totalArrearPending), amountUpTotheMonth:0, openingBalance:double.parse(totalArrearPending), closingBalance: 0);
      }
      
    
    MainCaseModel model = MainCaseModel(
      category: category,
      completeTrack:trac,
      uid: uid,
      name: name,
      formation: formation,
      date: date,
      oio: oio,
      dutyOfArrear: dutyOfArrear,
      age: age,
      amountRecovered: amountRecovered,
      status: status,
      briefFact: briefFact,
      effortMade: effortMade,
      remark: remark,
      penalty: penalty,
      intrest: intrest,
      totalArrearPending: totalArrearPending,
      preDeposit: preDeposit,
      apealNo: apealNo,
      stayOrderNumberAndDate: stayOrderNumberAndDate,
      gstin: gstin,
      iec: iec,
      pan: pan,
      subcategory: subcategory,
    );
    try {
      _fireStore
          .collection("MP")
          .doc(formation)
          .collection('cases')
          .doc(uid)
          .update(model.toJson());
      return {"res": "success"};
    } catch (e) {
      return {"res": e.toString()};
    }
}else{
       return {"res":"please provide me all required Prameter"};
}
  }

  //update maincase datils (requested cases)
  Future updateMainCaseDetails(
      {required MainCaseModel model,
      required String formation,
      required String uid}) async {
    try {
       Map<String,dynamic>modelData=model.toJson();
      DocumentSnapshot docSnapshot = await _fireStore
          .collection("MP")
          .doc(formation)
          .collection("cases")
          .doc(uid)
          .get();
      if (!docSnapshot.exists) {
        _fireStore
            .collection("MP")
            .doc(formation)
            .collection("cases")
            .doc(uid)
            .set(model.toJson());
            //updating tarreport if this request is not present in database
            TarReportInformation().updateDataOfTarReport(
           category:modelData['category'],
           subcategory:modelData['subcategory'], 
           docName:"receipts",
            noOfCasesOfTheMonth:1,
            noOfCasesUpToTheMonth:0, 
            amountOfTheMonth:double.parse(modelData['totalArrearPending']), 
            amountUpTotheMonth:0, 
            openingBalance:double.parse(modelData['totalArrearPending']), 
            closingBalance: 0);
        return {"res": "success"};
      }

      //tar report updating if total arrear pending is changed
     
       if((docSnapshot.data() as Map<String,dynamic>)['totalArrearPending'].toString()!=modelData['totalArrearPending']){
        TarReportInformation().updateDataOfTarReport(
          category:modelData['category'],
           subcategory:modelData['subcategory'], 
           docName:"receipts",
            noOfCasesOfTheMonth:0,
             noOfCasesUpToTheMonth:0, 
             amountOfTheMonth:double.parse(modelData['totalArrearPending']), 
             amountUpTotheMonth:0, 
             openingBalance:double.parse(modelData['totalArrearPending']), 
             closingBalance: 0);
      }

      _fireStore
          .collection("MP")
          .doc(formation)
          .collection("cases")
          .doc(uid)
          .update(model.toJson());
      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occured ${e.toString()}"};
    }
  }

  
  Future getFormationMainCaseInformation(String formation)async{
    try{
      QuerySnapshot snap=await _fireStore.collection("MP").doc(formation).collection("cases").get();
      List<Map<String,dynamic>>fomrationCases=[];
     
      for(var doc in snap.docs){
        fomrationCases.add(doc.data() as Map<String,dynamic>);
      
      }
    
      
      return {"res":fomrationCases};
    }catch(e){
      return {"res":"Some error occured ${e.toString()}"};
    }
  }

  //delete main case
  Future deleteMainCase({required String formation,required String uid})async{
    try{
    await _fireStore.collection("MP").doc(formation).collection("cases").doc(uid).delete();
     return {"res":"success"};
    }catch(e){
      return {"res":"some error occured ${e.toString()}"};
    }
  }

}
