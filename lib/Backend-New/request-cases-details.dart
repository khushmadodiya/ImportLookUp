import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:import_lookup/Backend-New/main-cases-details.dart';
import 'package:import_lookup/Model-New/main-case-model.dart';

import 'package:import_lookup/Model-New/request-case-model.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class RequestCasesInformation {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Future addCases(
      {required Map<String, dynamic> oldData,
      required String uid,
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
      required String remark,
      required String subcategory,
      required String effortMade,
      required bool isShifted,
      }) async {
    if (uid.isEmpty) {
      uid = const Uuid().v1();
    }
    if (oldData.isNotEmpty) {
      List<String> addNewTrack = List<String>.from(oldData['completeTrack']);
      addNewTrack.add(completeTrack);
      if(isShifted){
      oldData['completeTrack'] = addNewTrack;
      }
    }
    RequestCaseModel model = RequestCaseModel(
      oldData: oldData,
      upcategory: category,
      upcompleteTrack: oldData['completeTrack'] ?? [completeTrack],
      uid: uid,
      upname: name,
      upformation: formation,
      update: date,
      upoio: oio,
      updutyOfArrear: dutyOfArrear,
      upage: age,
      upamountRecovered: amountRecovered,
      upstatus: status,
      upbriefFact: briefFact,
      upeffortMade: effortMade,
      upremark: remark,
      uppenalty: penalty,
      upintrest: intrest,
      uptotalArrearPending: totalArrearPending,
      uppreDeposit: preDeposit,
      upapealNo: apealNo,
      upstayOrderNumberAndDate: stayOrderNumberAndDate,
      upgstin: gstin,
      upiec: iec,
      uppan: pan,
      upsubcategory: subcategory,
    );
    try {
      DocumentSnapshot documentSnapshot = await fireStore
          .collection("MP")
          .doc(formation)
          .collection('requested cases')
          .doc(uid)
          .get();
      if (!documentSnapshot.exists) {
        DocumentReference formationDocRef =
            fireStore.collection("MP").doc(formation);
        DocumentSnapshot docSnapshot = await formationDocRef.get();

        if (!docSnapshot.exists) {
          await fireStore
              .collection("MP")
              .doc(formation)
              .set({}, SetOptions(merge: true));
        }
        await fireStore
            .collection("MP")
            .doc(formation)
            .collection('requested cases')
            .doc(uid)
            .set(model.toJson());
        return {"res": "success"};
      } else {
        return {"res": "May be this request alreday present"};
      }
    } catch (e) {
      return {"res": e.toString()};
    }
  }

  //get all request dettails
    Future getAllReuqestCasesDetails() async {
    List<RequestCaseModel> allCases = [];
    try {
      QuerySnapshot querySnapshot = await fireStore.collection('MP').get();
      final Completer<String> completer = Completer<String>();
      if (querySnapshot.docs.isEmpty) {
        // print('No documents found in the MP collection  ');
         return allCases;
      } else {
        querySnapshot.docs.forEach((doc) async {
          // if(d)
          QuerySnapshot qsnap = await fireStore
              .collection("MP")
              .doc(doc.id)
              .collection("requested cases")
              .get();
          for (var val in qsnap.docs) {
            allCases.add(RequestCaseModel.fromJson(val.data() as Map<String, dynamic>));
          }
          completer.complete("Success");
        });
        await completer.future;

        return {"res":allCases};
        
       
      }
    } catch (e) {
      print("i am in errro");
      return [
        {"error": "Some Error Occured"}
      ];
    }
  }

  //update request data
  Future updateRequestData(
      {required Map<String, dynamic> oldData,
      required String uid,
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
      required String remark,
      required String subcategory,
      required String effortMade,required bool isShifted}) async {
    if (uid.isEmpty) {
      // uid = const Uuid().v1();
      return {"res": "Uid cannot be empty"};
    }
    print("i dsmkskmksm");
    DocumentSnapshot documentSnapshot = await fireStore
        .collection("MP")
        .doc(formation)
        .collection('requested cases')
        .doc(uid)
        .get();
    if (documentSnapshot.exists) {
      //if admin is updating the category or subgatory then the last entery of complete request will be deleted
      List<String>trackComplete=List<String>.from(documentSnapshot['upcompleteTrack']);
      if(isShifted){
          trackComplete.removeLast();
          trackComplete.add("On Date ${DateFormat('dd/mm/yyyy').format(DateTime.now())} case is in $category  $subcategory");
      }
      RequestCaseModel model = RequestCaseModel(
        oldData: documentSnapshot['oldData'],
        upcategory: category,
        upcompleteTrack:trackComplete,
        uid: uid,
        upname: name,
        upformation: formation,
        update: date,
        upoio: oio,
        updutyOfArrear: dutyOfArrear,
        upage: age,
        upamountRecovered: amountRecovered,
        upstatus: status,
        upbriefFact: briefFact,
        upeffortMade: effortMade,
        upremark: remark,
        uppenalty: penalty,
        upintrest: intrest,
        uptotalArrearPending: totalArrearPending,
        uppreDeposit: preDeposit,
        upapealNo: apealNo,
        upstayOrderNumberAndDate: stayOrderNumberAndDate,
        upgstin: gstin,
        upiec: iec,
        uppan: pan,
        upsubcategory: subcategory,
      );
      await fireStore
          .collection("MP")
          .doc(formation)
          .collection('requested cases')
          .doc(uid)
          .update(model.toJson());
      return {"res": "success"};
    } else {
      return {"res": "some error occured or request is not present"};
    }
  }
  
  //get all requets case by using formation
    Future getFormationRequestedCaseInformation(String formation)async{
    try{
      QuerySnapshot snap=await fireStore.collection("MP").doc(formation).collection("requested cases").get();
      List<RequestCaseModel>fomrationCases=[];
     
      for(var doc in snap.docs){
        // fomrationCases.add(doc.data() as Map<String,dynamic>);
        fomrationCases.add(RequestCaseModel.fromJson(doc.data() as Map<String,dynamic>));
      
      }
    // for(var form in fomrationCases){
    //     // fomrationCases.add(doc.data() as Map<String,dynamic>);
    //   print("here is data ${form.toString()}");
    //   }
      
      return {"res":fomrationCases};
    }catch(e){
      return {"res":"Some error occured ${e.toString()}"};
    }
  }

  //reject request
  Future rejectRequest({
    required String uid,
    required String formation,
    WriteBatch? batch
  }) async {
    if (uid.isEmpty) {
      return {"res": "Uid cannot be empty"};
    } else if (formation.isEmpty) {
      return {"res": "Fomration cannot be empty"};
    }

    try {
      if(batch!=null){
        DocumentReference ref= fireStore
          .collection("MP")
          .doc(formation)
          .collection('requested cases')
          .doc(uid);
          batch.delete(ref);
      }else{
        await fireStore
          .collection("MP")
          .doc(formation)
          .collection('requested cases')
          .doc(uid)
          .delete();
      }
      

      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occured ${e.toString}"};
    }
  }

  //accept request
  Future acceptRequest(
    {
      required String uid,
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
      required String remark,
      required String subcategory,
      required String effortMade
      })async{
    try{
    //model of main case
    MainCaseModel model = MainCaseModel(
      category: category,
      completeTrack: completeTrack,
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
    Map<String,dynamic>res= await MainCasesInformation().updateMainCaseDetails(model:model,uid:uid,formation:formation,request:true);
    if(res["res"]=="success"){
    return {"res":"success"};
    }else{
      return {"res":"some error occured"};
    }
    }catch(e){
      return {"res":"some error occured ${e.toString()}"};
    }
  }
}
