// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Backend-New/request-cases-details.dart';
import 'package:import_lookup/Backend-New/tar-report.dart';
import 'package:import_lookup/Model-New/main-case-model.dart';
import 'package:universal_html/html.dart';
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
    print("this is formation in database $formation");
    WriteBatch batch = _fireStore.batch();
    await replicateMainCase(mainCaseModel:model,batch:batch);
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

      //
      DocumentReference ref = _fireStore
          .collection("MP")
          .doc(formation)
          .collection("cases")
          .doc(uuid);
      batch.set(ref, model.toJson());
      await TarReportInformation().updateDataOfTarReport(
          batch: batch,
          category: category,
          subcategory: subcategory,
          docName: "receipts",
          noOfCasesOfTheMonth: 1,
          noOfCasesUpToTheMonth: 0,
          amountOfTheMonth: double.parse(totalArrearPending),
          amountUpTotheMonth: 0,
          openingBalance: double.parse(totalArrearPending),
          closingBalance: 0);
      batch.commit();
      return {"res": "success"};
    } catch (e) {
      return {"res": e.toString()};
    }
  }

  //get all maincases details
  Future getAllMainCasesDetails() async {
    List<MainCaseModel> allCases = [];
    try {
      QuerySnapshot querySnapshot = await _fireStore.collection('MP').get();
      final Completer<String> completer = Completer<String>();
      if (querySnapshot.docs.isEmpty) {
        // print('No documents found in the MP collection  ');
        return allCases;
      } else {
        for(var formation in FORMATION){
          QuerySnapshot qsnap = await _fireStore
              .collection("MP")
              .doc(formation)
              .collection("cases")
              .get();
        if(qsnap.docs.isNotEmpty){
           for (var val in qsnap.docs) {
            // allCases.add(val.data() as Map<String, dynamic>);
            allCases.add(
                MainCaseModel.fromJson(val.data() as Map<String, dynamic>));
          }
        }
        if(formation=='ICD Tihi'){
           completer.complete("Success");
        }
        }

        // querySnapshot.docs.forEach((doc) async {
        //   QuerySnapshot qsnap = await _fireStore
        //       .collection("MP")
        //       .doc(doc.id)
        //       .collection("cases")
        //       .get();
        //   for (var val in qsnap.docs) {
        //     // allCases.add(val.data() as Map<String, dynamic>);
        //     allCases.add(
        //         MainCaseModel.fromJson(val.data() as Map<String, dynamic>));
        //   }
        //   completer.complete("Success");
        // });
        print("all cases here with lenght ${allCases.length}");
        await completer.future;

        return {"res": allCases};
      }
    } catch (e) {
      print("i am in errro");
      return [
        {"error": "Some Error Occured"}
      ];
    }
  }

  //this is form main cases

  Future updateCaseDetails({
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
    // required String efforMade,
    required String remark,
    required String subcategory,
    required String effortMade,
    required bool isShifted,
  }) async {
    WriteBatch batch = _fireStore.batch();
    DocumentSnapshot _snap = await _fireStore
        .collection("MP")
        .doc(formation)
        .collection('cases')
        .doc(uid)
        .get();
    if (_snap.exists) {
      List<String> trac = List<String>.from(
          (_snap.data() as Map<String, dynamic>)['completeTrack']);
      if (isShifted) {
        trac.add(completeTrack);
      }
      if ((_snap.data() as Map<String, dynamic>)['totalArrearPending']
              .toString() !=
          totalArrearPending) {
        await TarReportInformation().updateDataOfTarReport(
            batch: batch,
            category: category,
            subcategory: subcategory,
            docName: "receipts",
            noOfCasesOfTheMonth: 0,
            noOfCasesUpToTheMonth: 0,
            amountOfTheMonth: double.parse(totalArrearPending),
            amountUpTotheMonth: 0,
            openingBalance: double.parse(totalArrearPending),
            closingBalance: 0);
      }

      MainCaseModel model = MainCaseModel(
        category: category,
        completeTrack: trac,
        uid: uid,
        name: name,
        formation: formation,
        date: date,
        oio: oio,
        dutyOfArrear: dutyOfArrear,
        age: 0.0,
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
        DocumentReference ref = _fireStore
            .collection("MP")
            .doc(formation)
            .collection('cases')
            .doc(uid);
        batch.update(ref, model.toJson());
        await batch.commit();
        // _fireStore
        //     .collection("MP")
        //     .doc(formation)
        //     .collection('cases')
        //     .doc(uid)
        //     .update(model.toJson());
        return {"res": "success"};
      } catch (e) {
        print("hello i am khushvant ${e.toString()}");
        print(e.toString());
        return {"res": e.toString()};
      }
    } else {
      return {"res": "please provide me all required Prameter"};
    }
  }

  //update maincase datils (requested cases)
  Future updateMainCaseDetails(
      {required MainCaseModel model,
      required String formation,
      required String uid,
      bool request = false}) async {
    WriteBatch batch = _fireStore.batch();
    try {
      Map<String, dynamic> modelData = model.toJson();
      upDatereplicateMainCase(uid: uid, model: model, batch: batch);
      DocumentSnapshot docSnapshot = await _fireStore
          .collection("MP")
          .doc(formation)
          .collection("cases")
          .doc(uid)
          .get();
      if (!docSnapshot.exists) {
        DocumentReference ref = _fireStore
            .collection("MP")
            .doc(formation)
            .collection("cases")
            .doc(uid);
        batch.set(ref, model.toJson());
        // .set(model.toJson());
        //updating tarreport if this request is not present in database
        await TarReportInformation().updateDataOfTarReport(
            // batch:_fireStore.batch(),
            batch: batch,
            category: modelData['category'],
            subcategory: modelData['subcategory'],
            docName: "receipts",
            noOfCasesOfTheMonth: 1.0,
            noOfCasesUpToTheMonth: 0.0,
            amountOfTheMonth: double.parse(modelData['totalArrearPending']),
            amountUpTotheMonth: 0.0,
            openingBalance: double.parse(modelData['totalArrearPending']),
            closingBalance: 0.0);
        if (request) {
          // print("i am in request njndjdnbjdbn");
          await RequestCasesInformation()
              .rejectRequest(uid: uid, formation: formation, batch: batch);
        }
       await batch.commit();
        return {"res": "success"};
      }

      //tar report updating if total arrear pending is changed

      if ((docSnapshot.data() as Map<String, dynamic>)['totalArrearPending']
              .toString() !=
          modelData['totalArrearPending']) {
        await TarReportInformation().updateDataOfTarReport(
            batch: batch,
            category: modelData['category'],
            subcategory: modelData['subcategory'],
            docName: "receipts",
            noOfCasesOfTheMonth: 0,
            noOfCasesUpToTheMonth: 0,
            amountOfTheMonth: double.parse(modelData['totalArrearPending']),
            amountUpTotheMonth: 0,
            openingBalance: double.parse(modelData['totalArrearPending']),
            closingBalance: 0);
      }
      DocumentReference ref = _fireStore
          .collection("MP")
          .doc(formation)
          .collection("cases")
          .doc(uid);
      batch.update(ref, model.toJson());
      if (request) {
          // print("i am in request njndjdnbjdbn");
          await RequestCasesInformation()
              .rejectRequest(uid: uid, formation: formation, batch: batch);
        }
      await batch.commit();

      
      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occured ${e.toString()}"};
    }
  }

  Future getFormationMainCaseInformation(String formation) async {
    try {
      QuerySnapshot snap = await _fireStore
          .collection("MP")
          .doc(formation)
          .collection("cases")
          .get();
      List<MainCaseModel> formationCases = [];

      for (var doc in snap.docs) {
        // fomrationCases.add(doc.data() as Map<String,dynamic>);
        formationCases
            .add(MainCaseModel.fromJson(doc.data() as Map<String, dynamic>));
      }

      return {"res": formationCases};
    } catch (e) {
      return {"res": "Some error occured ${e.toString()}"};
    }
  }

  //delete main case
  Future deleteMainCase(
      {required String formation, required String uid}) async {
    try {
      WriteBatch batch = _fireStore.batch();
      // await _fireStore.collection("MP").doc(formation).collection("cases").doc(uid).delete();
      DocumentReference ref = _fireStore
          .collection("MP")
          .doc(formation)
          .collection("cases")
          .doc(uid);
      await deletereplicateMainCase(uid: uid, batch: batch);
      await writeOff(formation: formation, uid: uid, writeBatch: batch);
      batch.delete(ref);
     await batch.commit();
      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occured ${e.toString()}"};
    }
  }

  Future writeOff(
      {required String formation,
      required String uid,
      required WriteBatch writeBatch}) async {
    try {
      DocumentSnapshot snap = await _fireStore
          .collection("MP")
          .doc(formation)
          .collection("cases")
          .doc(uid)
          .get();
      //  uid=const Uuid().v1();
      // await _fireStore.collection("MP").doc("writeOff").collection("cases").doc(uid).set(_snap.data() as Map<String,dynamic>);
      DocumentReference ref = _fireStore
          .collection("MP")
          .doc("writeOff")
          .collection("cases")
          .doc(uid);
      if(snap.exists){
      writeBatch.set(ref, snap.data() as Map<String, dynamic>);
      }else{
        throw "error occured";
      }
      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occured ${e.toString()}"};
    }
  }
  //get maincase detail document using formation

  Future getMainCaseDetailByDocument({required  String formation,required String uid}) async {

    try{
      DocumentSnapshot qsnap = await _fireStore
          .collection("MP")
          .doc(formation)
          .collection("cases").doc(uid)
          .get();
      MainCaseModel model = MainCaseModel.fromJson(qsnap.data() as Map<String, dynamic>);
      return {'res':'success','model':model};
    }
    catch(e){
      return {'res': 'some error occure $e'};
    }
  }
  //get reuestcase detail document using formation

  Future getRequestCaseDetailByDocument({required  String formation,required String uid}) async {

    try{
      DocumentSnapshot qsnap = await _fireStore
          .collection("MP")
          .doc(formation)
          .collection("requested cases").doc(uid)
          .get();
      MainCaseModel model = MainCaseModel.fromJson(qsnap.data() as Map<String, dynamic>);
      return {'res':'success','model':model};
    }
    catch(e){
      return {'res': 'some error occure $e'};
    }
  }

//for read optimize 

  Future replicateMainCase(
      {required MainCaseModel mainCaseModel,required WriteBatch batch}) async {


    try {
     DocumentReference ref= _fireStore.collection("MP").doc("replicationmaincase").collection("formation").doc(mainCaseModel.uid);
     batch.set(ref,mainCaseModel.toJson());
    return {"res": "success"};
    } catch (e) {
      return {"res": e.toString()};
    }
  }
  Future deletereplicateMainCase(
      {required String uid,required WriteBatch batch}) async {


    try {
     DocumentReference ref= _fireStore.collection("MP").doc("replicationmaincase").collection("formation").doc(uid);
     batch.delete(ref);
    return {"res": "success"};
    } catch (e) {
      return {"res": e.toString()};
    }
  }

    Future upDatereplicateMainCase(
      {required String uid,required MainCaseModel model,required WriteBatch batch}) async {
    try {
     DocumentReference ref= _fireStore.collection("MP").doc("replicationmaincase").collection("formation").doc(uid);
    //  if(ref.get().
    DocumentSnapshot snap=await _fireStore.collection("MP").doc("replicationmaincase").collection("formation").doc(uid).get();
    if(!snap.exists){
       batch.set(ref,model.toJson());
    }else{
       batch.update(ref,model.toJson());
    }
    
    return {"res": "success"};
    } catch (e) {
      return {"res": e.toString()};
    }
  }


// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getReplicateMainCase({required String category}) async {
  try {
    print("Making request for data");
    
    // String lowerCategory = category.toLowerCase();
    // String upperCategory = category.toUpperCase();
    
    // Create a list of queries for each field
    List<Query> queries = [
      _fireStore.collection("MP").doc("replicationmaincase").collection("formation")
        .where(("name").toLowerCase(),isLessThanOrEqualTo:("GoUrAv").toLowerCase())
        .where(("name").toLowerCase(),isGreaterThanOrEqualTo:("GoUrAv").toLowerCase())

        // .where("name", isLessThanOrEqualTo: "GOURAV"),
      // _fireStore.collection("MP").doc("replicationmaincase").collection("formation")
      //   .where("formation", isGreaterThanOrEqualTo: lowerCategory)
      //   .where("formation", isLessThanOrEqualTo: upperCategory + '\uf8ff'),
      // _fireStore.collection("MP").doc("replicationmaincase").collection("formation")
      //   .where("briefFact", isGreaterThanOrEqualTo: lowerCategory)
      //   .where("briefFact", isLessThanOrEqualTo: upperCategory + '\uf8ff'),
      // _fireStore.collection("MP").doc("replicationmaincase").collection("formation")
      //   .where("amountRecovered", isGreaterThanOrEqualTo: lowerCategory)
      //   .where("amountRecovered", isLessThanOrEqualTo: upperCategory + '\uf8ff'),
      // _fireStore.collection("MP").doc("replicationmaincase").collection("formation")
      //   .where("apealNo", isGreaterThanOrEqualTo: lowerCategory)
      //   .where("apealNo", isLessThanOrEqualTo: upperCategory + '\uf8ff'),
      // _fireStore.collection("MP").doc("replicationmaincase").collection("formation")
      //   .where("category", isGreaterThanOrEqualTo: lowerCategory)
      //   .where("category", isLessThanOrEqualTo: upperCategory + '\uf8ff'),
      // _fireStore.collection("MP").doc("replicationmaincase").collection("formation")
      //   .where("intrest", isGreaterThanOrEqualTo: lowerCategory)
      //   .where("intrest", isLessThanOrEqualTo: upperCategory + '\uf8ff'),
    ];

    // Execute all queries
    List<QuerySnapshot> snapshots = await Future.wait(queries.map((query) => query.get()));

    // Combine and deduplicate results
    Map<String, MainCaseModel> uniqueData = {};

    for (var snapshot in snapshots) {
      for (var doc in snapshot.docs) {
        String docId = doc.id;
        if (!uniqueData.containsKey(docId)) {
          uniqueData[docId] = MainCaseModel.fromJson(doc.data() as Map<String, dynamic>);
        }
      }
    }

    List<MainCaseModel> data = uniqueData.values.toList();

    print("Data fetched successfully. Total unique records: ${data.length}");

    for (int i = 0; i < data.length; i++) {
      print("Fetched data: ${data[i].name}");
    }

    return {"res": "success", "data": data};
  } catch (e) {
    print("Error fetching data: $e");  // Log the error
    return {"res": e.toString(), "data": []};
  }
}

}


 

