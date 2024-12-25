// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls

import 'dart:async';

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
    await replicateMainCase(mainCaseModel: model, batch: batch);
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
      print("this is error by khush");
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
        for (var formation in FORMATION) {
          QuerySnapshot qsnap = await _fireStore
              .collection("MP")
              .doc(formation)
              .collection("cases")
              .get();
          if (qsnap.docs.isNotEmpty) {
            for (var val in qsnap.docs) {
              // allCases.add(val.data() as Map<String, dynamic>);
              allCases.add(
                  MainCaseModel.fromJson(val.data() as Map<String, dynamic>));
            }
          }
          if (formation == 'ICD Tihi') {
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
    MainCaseModel? oldDataModel,
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
    print("i am divyansh i n main case00");
    WriteBatch batch = _fireStore.batch();
    DocumentSnapshot snap = await _fireStore
        .collection("MP")
        .doc(formation)
        .collection('cases')
        .doc(uid)
        .get();
    if (snap.exists) {
      oldDataModel =
          MainCaseModel.fromJson(snap.data() as Map<String, dynamic>);
      List<String> trac = List<String>.from(
          (snap.data() as Map<String, dynamic>)['completeTrack']);
      if (isShifted) {
        trac.add(completeTrack);
      }
      // print(
      //     "nice is work is gere ${(_snap.data() as Map<String, dynamic>)['totalArrearPending'] != totalArrearPending}  ${totalArrearPending}");
      if ((snap.data() as Map<String, dynamic>)['totalArrearPending'] !=
          totalArrearPending) {
        // print(
        //     "heelo amoutn is pu dipu ${double.parse(totalArrearPending) - double.parse(oldDataModel.totalArrearPending)}");
        await TarReportInformation().updateDataOfTarReport(
            batch: batch,
            category: oldDataModel.category,
            subcategory: oldDataModel.subcategory,
            docName: "receipts",
            noOfCasesOfTheMonth: 0,
            noOfCasesUpToTheMonth: 0,
            amountOfTheMonth: -double.parse(oldDataModel.totalArrearPending) +
                double.parse(totalArrearPending),
            amountUpTotheMonth: 0,
            openingBalance: 0,
            closingBalance: -double.parse(oldDataModel.totalArrearPending) +
                double.parse(totalArrearPending));
      }
      if (oldDataModel.category != category ||
          oldDataModel.subcategory != subcategory) {
        await TarReportInformation().updateDataOfTarReport(
            batch: batch,
            category: oldDataModel.category,
            subcategory: oldDataModel.subcategory,
            docName: "receipts",
            noOfCasesOfTheMonth: -1,
            noOfCasesUpToTheMonth: 0,
            amountOfTheMonth: -double.parse(oldDataModel.totalArrearPending),
            amountUpTotheMonth: 0,
            openingBalance: 0,
            closingBalance: -double.parse(oldDataModel.totalArrearPending));

        //new update
        await TarReportInformation().updateDataOfTarReport(
            batch: batch,
            category: category,
            subcategory: subcategory,
            docName: "receipts",
            noOfCasesOfTheMonth: 1,
            noOfCasesUpToTheMonth: 0,
            amountOfTheMonth: double.parse(totalArrearPending),
            amountUpTotheMonth: 0,
            openingBalance: 0,
            closingBalance: double.parse(totalArrearPending));
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
        // print("i am divyansh i n main case01  ${model.toJson().toString()}");
        await upDatereplicateMainCase(uid: uid, model: model, batch: batch);
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
      {required MainCaseModel newDataModel,
      required String formation,
      required String uid,
      bool request = false}) async {
    WriteBatch batch = _fireStore.batch();
    try {
      // print("i am divyansh i n main case 10");
      Map<String, dynamic> modelData = newDataModel.toJson();

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
        batch.set(ref, newDataModel.toJson());
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

      // print("i am divyansh patidar");
      //tar report updating if total arrear pending is changed
      MainCaseModel oldDataModel =
          MainCaseModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      if ((docSnapshot.data() as Map<String, dynamic>)['totalArrearPending']
              .toString() !=
          modelData['totalArrearPending']) {
        // print(
        //     "i am inside of it update  ${oldDataModel.totalArrearPending}  ${newDataModel.totalArrearPending}");
        await TarReportInformation().updateDataOfTarReport(
            batch: batch,
            category: oldDataModel.category,
            subcategory: oldDataModel.subcategory,
            docName: "receipts",
            noOfCasesOfTheMonth: 0,
            noOfCasesUpToTheMonth: 0,
            // amountOfTheMonth: double.parse(modelData['totalArrearPending']),
            amountOfTheMonth: double.parse(oldDataModel.totalArrearPending) -
                        double.parse(newDataModel.totalArrearPending) <
                    0
                ? double.parse(newDataModel.totalArrearPending) -
                    double.parse(oldDataModel.totalArrearPending)
                : double.parse(oldDataModel.totalArrearPending) -
                    double.parse(newDataModel.totalArrearPending),
            amountUpTotheMonth: 0,
            openingBalance: 0,
            closingBalance: -double.parse(oldDataModel.totalArrearPending));
      }
      print("i am inside of it above of it");
      if (oldDataModel.category != newDataModel.category ||
          oldDataModel.subcategory != newDataModel.subcategory) {
        print(
            "i am inside of it ndjnjnjnjdnjnd  ${oldDataModel.totalArrearPending}  ${newDataModel.totalArrearPending}");
        await TarReportInformation().updateDataOfTarReport(
            batch: batch,
            category: oldDataModel.category,
            subcategory: oldDataModel.subcategory,
            docName: "receipts",
            noOfCasesOfTheMonth: -1,
            noOfCasesUpToTheMonth: 0,
            amountOfTheMonth: -double.parse(oldDataModel.totalArrearPending),
            amountUpTotheMonth: 0,
            openingBalance: 0,
            closingBalance: -double.parse(oldDataModel.totalArrearPending));
        await TarReportInformation().updateDataOfTarReport(
            batch: batch,
            category: newDataModel.category,
            subcategory: newDataModel.subcategory,
            docName: "receipts",
            noOfCasesOfTheMonth: 1,
            noOfCasesUpToTheMonth: 0,
            amountOfTheMonth: double.parse(newDataModel.totalArrearPending),
            amountUpTotheMonth: 0,
            openingBalance: 0,
            closingBalance: double.parse(newDataModel.totalArrearPending));
      }
      DocumentReference ref = _fireStore
          .collection("MP")
          .doc(formation)
          .collection("cases")
          .doc(uid);
      await upDatereplicateMainCase(
          uid: uid, model: newDataModel, batch: batch);
      batch.update(ref, newDataModel.toJson());
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
      {required String formation,
      required String uid,
      bool isWriteOff = false,
      String docName = ''}) async {
    try {
      WriteBatch batch = _fireStore.batch();

      DocumentReference ref = _fireStore
          .collection("MP")
          .doc(formation)
          .collection("cases")
          .doc(uid);
      DocumentSnapshot snap = await ref.get();
      MainCaseModel model =
          MainCaseModel.fromJson(snap.data() as Map<String, dynamic>);
      await deletereplicateMainCase(uid: uid, batch: batch);
      if (isWriteOff) {
        await writeOff(
            formation: formation,
            uid: uid,
            writeBatch: batch,
            mainCaseModel: model);
      } else {
        if (snap.exists) {
          await TarReportInformation().updateDataOfTarReport(
              batch: batch,
              category: model.category,
              subcategory: model.subcategory,
              docName: "receipts",
              noOfCasesOfTheMonth: -1,
              noOfCasesUpToTheMonth: 0,
              amountOfTheMonth: -double.parse(model.totalArrearPending),
              amountUpTotheMonth: 0,
              openingBalance: 0,
              closingBalance: double.parse(model.totalArrearPending));
          // print("here i am inside of it 3");
          await TarReportInformation().updateDataOfTarReport(
              batch: batch,
              category: model.category,
              subcategory: model.subcategory,
              docName: docName,
              noOfCasesOfTheMonth: 1,
              noOfCasesUpToTheMonth: 0,
              amountOfTheMonth: double.parse(model.totalArrearPending),
              amountUpTotheMonth: 0,
              openingBalance: 0,
              closingBalance: double.parse(model.totalArrearPending));
          // print("here i am inside of it 4");
        }
      }
      batch.delete(ref);
      await batch.commit();
      // print("here i am inside of it 5");
      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occured ${e.toString()}"};
    }
  }

  Future writeOff(
      {required String formation,
      required String uid,
      required WriteBatch writeBatch,
      required MainCaseModel mainCaseModel}) async {
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
      if (snap.exists) {
        writeBatch.set(ref, snap.data() as Map<String, dynamic>);
      } else {
        throw "error occured";
      }
      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occured ${e.toString()}"};
    }
  }
  //get maincase detail document using formation

  Future getMainCaseDetailByDocument(
      {required String formation, required String uid}) async {
    try {
      DocumentSnapshot qsnap = await _fireStore
          .collection("MP")
          .doc(formation)
          .collection("cases")
          .doc(uid)
          .get();
      MainCaseModel model =
          MainCaseModel.fromJson(qsnap.data() as Map<String, dynamic>);
      return {'res': 'success', 'model': model};
    } catch (e) {
      return {'res': 'some error occure $e'};
    }
  }
  //get reuestcase detail document using formation

  Future getRequestCaseDetailByDocument(
      {required String formation, required String uid}) async {
    try {
      DocumentSnapshot qsnap = await _fireStore
          .collection("MP")
          .doc(formation)
          .collection("requested cases")
          .doc(uid)
          .get();
      MainCaseModel model =
          MainCaseModel.fromJson(qsnap.data() as Map<String, dynamic>);
      return {'res': 'success', 'model': model};
    } catch (e) {
      return {'res': 'some error occure $e'};
    }
  }

//for read optimize

  Future replicateMainCase(
      {required MainCaseModel mainCaseModel, required WriteBatch batch}) async {
    try {
      DocumentReference ref = _fireStore
          .collection("MP")
          .doc("replicationmaincase")
          .collection("formation")
          .doc(mainCaseModel.uid);
      batch.set(ref, mainCaseModel.toJson());
      return {"res": "success"};
    } catch (e) {
      return {"res": e.toString()};
    }
  }

  Future deletereplicateMainCase(
      {required String uid, required WriteBatch batch}) async {
    try {
      DocumentReference ref = _fireStore
          .collection("MP")
          .doc("replicationmaincase")
          .collection("formation")
          .doc(uid);
      batch.delete(ref);
      return {"res": "success"};
    } catch (e) {
      return {"res": e.toString()};
    }
  }

  Future upDatereplicateMainCase(
      {required String uid,
      required MainCaseModel model,
      required WriteBatch batch}) async {
    try {
      DocumentReference ref = _fireStore
          .collection("MP")
          .doc("replicationmaincase")
          .collection("formation")
          .doc(uid);
      //  if(ref.get().
      DocumentSnapshot snap = await _fireStore
          .collection("MP")
          .doc("replicationmaincase")
          .collection("formation")
          .doc(uid)
          .get();

      if (!snap.exists) {
        print("heeli i am hrreretette 12");
        batch.set(ref, model.toJson());
      } else {
        print("heeli i am hrreretette 123   ${model.toJson().toString()}");
        batch.update(ref, model.toJson());
      }
      print("heeli i am hrreretette 1234");
      return {"res": "success"};
    } catch (e) {
      print("heeli i am hrreretette 1235  ${e.toString()}");
      return {"res": e.toString()};
    }
  }

// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

  Future<Map<String, dynamic>> searchInReplication(
      {required String category}) async {
    try {
      List<Query> queries = [
        _fireStore
            .collection("MP")
            .doc("replicationmaincase")
            .collection("formation")
            .orderBy("formation")
            .startAt([category]).endAt(["$category\uf8ff"]),
        _fireStore
            .collection("MP")
            .doc("replicationmaincase")
            .collection("formation")
            .orderBy("name")
            .startAt([category]).endAt(["$category\uf8ff"]),
        _fireStore
            .collection("MP")
            .doc("replicationmaincase")
            .collection("formation")
            .orderBy("category")
            .startAt([category]).endAt(["$category\uf8ff"]),
        _fireStore
            .collection("MP")
            .doc("replicationmaincase")
            .collection("formation")
            .orderBy("subcategory")
            .startAt([category]).endAt(["$category\uf8ff"]),
      ];
      List<QuerySnapshot> snapshots =
          await Future.wait(queries.map((query) => query.get()));
      Map<String, MainCaseModel> uniqueData = {};

      for (var snapshot in snapshots) {
        print("i am in loop");
        for (var doc in snapshot.docs) {
          String docId = doc.id;
          if (!uniqueData.containsKey(docId)) {
            uniqueData[docId] =
                MainCaseModel.fromJson(doc.data() as Map<String, dynamic>);
          }
        }
      }

      List<MainCaseModel> data = uniqueData.values.toList();

      print("Data fetched successfully. Total unique records: ${data.length}");

      for (int i = 0; i < data.length; i++) {
        print(
            "Fetched data:${data[i].uid} ${data[i].name} ${data[i].category}  ${data[i].subcategory}  ${data[i].formation}");
      }

      return {"res": "success", "data": data};
    } catch (e) {
      print("Error fetching data: $e"); // Log the error
      return {"res": e.toString(), "data": []};
    }
  }

  Future sortReplicationCases(bool isArrearPending) async {
    List<MainCaseModel> data = [];
    QuerySnapshot? snap;
    if (isArrearPending) {
      snap = await _fireStore
          .collection("MP")
          .doc("replicationmaincase")
          .collection("formation")
          .orderBy("originalAmount")
          .get();
    } else {
      snap = await _fireStore
          .collection("MP")
          .doc("replicationmaincase")
          .collection("formation")
          .orderBy("originalDate")
          .get();
    }
    for (DocumentSnapshot val in snap.docs) {
      data.add(MainCaseModel.fromJson(val.data() as Map<String, dynamic>));
    }
    return {"res": "success", "data": data};
  }
}
