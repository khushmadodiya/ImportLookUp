import 'dart:async';
import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Model-New/tar-model.dart';
import 'package:uuid/uuid.dart';

class TarReportInformation {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future updateDataOfTarReport({
    required WriteBatch batch,
    required String category,
    required String subcategory,
    required String docName,
    required double noOfCasesOfTheMonth,
    required double noOfCasesUpToTheMonth,
    required double amountOfTheMonth,
    required double amountUpTotheMonth,
    required double openingBalance,
    required double closingBalance,
  }) async {
    try {
      DocumentSnapshot docsnap =
          await firebaseFirestore.collection("MP").doc(category).get();
      String uuid = const Uuid().v1();
      TarReportModel model = TarReportModel(
          amountOfTheMonth: amountOfTheMonth,
          amountUpTotheMonth: 0,
          noOfCasesOfTheMonth: noOfCasesOfTheMonth,
          noOfCasesUpToTheMonth: 0,
          openingBalance: 0,
          closingBalance: amountOfTheMonth);

      if (docsnap.exists) {
        // print("heloooo i am a");
        docsnap = await firebaseFirestore
            .collection("MP")
            .doc(category)
            .collection(subcategory)
            .doc(docName)
            .get();

        if (docsnap.exists) {
          final data = docsnap.data() as Map<String, dynamic>;
          model = TarReportModel(
              amountOfTheMonth: data['amountOfTheMonth'] + amountOfTheMonth,
              amountUpTotheMonth: data['amountUpTotheMonth'],
              noOfCasesOfTheMonth:
                  data['noOfCasesOfTheMonth'] + noOfCasesOfTheMonth,
              noOfCasesUpToTheMonth: data['noOfCasesUpToTheMonth'],
              openingBalance: data['openingBalance'],
              closingBalance: data['closingBalance'] + amountOfTheMonth);
          //
          TocModel tocmodel = TocModel(
            closingBalance: amountOfTheMonth,
            openingBalance: openingBalance,
            numberOfClosingCases: noOfCasesOfTheMonth,
            numberOfOpeningCases: 0,
          );
          if (docName == 'receipts') {
            await tocCreation(
                category: category,
                subcategory: subcategory,
                model: tocmodel,
                batch: batch);
          }
          //
          DocumentReference ref = firebaseFirestore
              .collection("MP")
              .doc(category)
              .collection(subcategory)
              .doc(docName);
          batch.update(ref, model.toJson());
        } else {
          DocumentReference ref = firebaseFirestore
              .collection("MP")
              .doc(category)
              .collection(subcategory)
              .doc(docName);
          batch.set(ref, model.toJson());
        }
      } else {
        TocModel tocmodel = TocModel(
          closingBalance: closingBalance,
          openingBalance: openingBalance,
          numberOfClosingCases: noOfCasesOfTheMonth,
          numberOfOpeningCases: 0,
        );
        if (docName == 'receipts') {
          await tocCreation(
              category: category,
              subcategory: subcategory,
              model: tocmodel,
              batch: batch);
        }
        // print("heloooo i am fff D");
        await firebaseFirestore
            .collection("MP")
            .doc(category)
            .set({}, SetOptions(merge: true));

        DocumentReference ref = firebaseFirestore
            .collection("MP")
            .doc(category)
            .collection(subcategory)
            .doc(docName);
        batch.set(ref, model.toJson());
      }

      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occured ${e.toString()}"};
    }
  }

  Future tocCreation(
      {required String category,
      required String subcategory,
      required TocModel model,
      required WriteBatch batch}) async {
    // print("i am in toc heree");
    DocumentSnapshot snap =
        await firebaseFirestore.collection("MP").doc(category).get();
    if (snap.exists) {
      DocumentSnapshot snp = await firebaseFirestore
          .collection("MP")
          .doc(category)
          .collection(subcategory)
          .doc("toc")
          .get();
      if (snp.exists) {
        TocModel model1 = TocModel.fromJson(snp.data() as Map<String, dynamic>);
        model = TocModel(
            closingBalance: model.closingBalance + model1.closingBalance,
            openingBalance: model1.openingBalance,
            numberOfClosingCases:
                model.numberOfClosingCases + model1.numberOfClosingCases,
            numberOfOpeningCases: model1.numberOfOpeningCases);
        DocumentSnapshot snapshot = await firebaseFirestore
            .collection("MP")
            .doc(category)
            .collection(subcategory)
            .doc("toc")
            .get();
        // if (snapshot.exists) {
        DocumentReference ref = firebaseFirestore
            .collection("MP")
            .doc(category)
            .collection(subcategory)
            .doc("toc");
        batch.update(ref, model.toJson());
        // } else {
        // DocumentReference ref = firebaseFirestore
        //     .collection("MP")
        //     .doc(category)
        //     .collection(subcategory)
        //     .doc("toc");
        // batch.set(ref, model.toJson());
        // }
      } else {
        print("I am in the else part${model.toJson()}");
        DocumentReference ref = firebaseFirestore
            .collection("MP")
            .doc(category)
            .collection(subcategory)
            .doc("toc");
        batch.set(ref, model.toJson());
      }
    } else {
      await firebaseFirestore
          .collection("MP")
          .doc(category)
          .set({}, SetOptions(merge: true));

      DocumentReference ref = firebaseFirestore
          .collection("MP")
          .doc(category)
          .collection(subcategory)
          .doc("toc");
      batch.set(ref, model.toJson());
    }
  }

  Future tocUpdate(
      {required String category,
      required String subcategory,
      required WriteBatch batch}) async {
    DocumentSnapshot snp = await firebaseFirestore
        .collection("MP")
        .doc(category)
        .collection(subcategory)
        .doc("toc")
        .get();

    if (snp.exists) {
      DocumentReference ref = firebaseFirestore
          .collection("MP")
          .doc(category)
          .collection(subcategory)
          .doc("toc");
      TocModel model = TocModel.fromJson(snp.data() as Map<String, dynamic>);
      model = TocModel(
          closingBalance: 0,
          openingBalance: model.closingBalance + model.openingBalance,
          numberOfClosingCases: 0,
          numberOfOpeningCases:
              model.numberOfOpeningCases + model.numberOfClosingCases);
      batch.update(ref, snp.data() as Map<String, dynamic>);
    }
  }

  //transfer case in up to the month

  Future transferCasesUpTheMonth({
    required String category,
    required String subcategory,
    required String docName,
  }) async {
    try {
      WriteBatch batch = firebaseFirestore.batch();
      tocUpdate(batch: batch, category: category, subcategory: subcategory);

      for (int i = 0; i < CATEGORY.length; i++) {
        category = CATEGORY[i];
        for (int j = 0; j < SUBCATEGORY[CATEGORY[i]]!.length; j++) {
          subcategory = SUBCATEGORY[category]![j];

          for (int k = 0; k < DOCNAME.length; k++) {
            docName = DOCNAME[k];
            DocumentSnapshot docsnap = await firebaseFirestore
                .collection("MP")
                .doc(category)
                .collection(subcategory)
                .doc(docName)
                .get();

            if (docsnap.exists) {
              Map<String, dynamic> data =
                  docsnap.data() as Map<String, dynamic>;
              TarReportModel model = TarReportModel(
                amountOfTheMonth: 0,
                amountUpTotheMonth:
                    data["amountOfTheMonth"] + data["amountUpToTheMonth"],
                noOfCasesOfTheMonth: 0,
                noOfCasesUpToTheMonth:
                    data["noOfCasesUpToTheMonth"] + data["noOfCasesOfTheMonth"],
                openingBalance: data["openingBalance"] + data["closingBalance"],
                closingBalance: 0,
              );

              // Use batch.update instead of direct update
              batch.update(
                  firebaseFirestore
                      .collection("MP")
                      .doc(category)
                      .collection(subcategory)
                      .doc(docName),
                  model.toJson());
            } else {
              return {"res": "some problem has occurred"};
            }
          }
        }
      }

      // Commit the batch after all updates are added
      await batch.commit();
      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occurred ${e.toString()}"};
    }
  }

  Future transferCasesYear({
    required String category,
    required String subcategory,
    required String docName,
  }) async {
    try {
      WriteBatch batch = firebaseFirestore.batch();
      tocUpdate(batch: batch, category: category, subcategory: subcategory);

      for (int i = 0; i < CATEGORY.length; i++) {
        category = CATEGORY[i];
        for (int j = 0; j < SUBCATEGORY[CATEGORY[i]]!.length; j++) {
          subcategory = SUBCATEGORY[category]![j];
          for (int k = 0; k < DOCNAME.length; k++) {
            docName = DOCNAME[k];
            DocumentSnapshot docsnap = await firebaseFirestore
                .collection("MP")
                .doc(category)
                .collection(subcategory)
                .doc(docName)
                .get();

            if (docsnap.exists) {
              Map<String, dynamic> data =
                  docsnap.data() as Map<String, dynamic>;
              TarReportModel model = TarReportModel(
                amountOfTheMonth: 0,
                amountUpTotheMonth: 0,
                noOfCasesOfTheMonth: 0,
                noOfCasesUpToTheMonth: 0,
                openingBalance: data["openingBalance"] + data["closingBalance"],
                closingBalance: 0,
              );

              // Use batch.update instead of direct update
              batch.update(
                  firebaseFirestore
                      .collection("MP")
                      .doc(category)
                      .collection(subcategory)
                      .doc(docName),
                  model.toJson());
            } else {
              return {"res": "some problem has occurred"};
            }
          }
        }
      }

      // Commit the batch after all updates are added
      await batch.commit();
      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occurred ${e.toString()}"};
    }
  }

  Future restrainedArrearReport() async {
    Map<String, TarReportModel> allData = {};

    DocumentSnapshot snap =
        await firebaseFirestore.collection("MP").doc("restrained arrear").get();
    if (snap.exists) {
      for (int i = 0; i < SUBCATEGORY["restrained arrear"]!.length; i++) {
        QuerySnapshot snap2 = await firebaseFirestore
            .collection("MP")
            .doc("restrained arrear")
            .collection(SUBCATEGORY["restrained arrear"]![i])
            .get();
        for (var data in snap2.docs) {
          // print("Data is here: ${data.data().toString()}");
          allData[SUBCATEGORY["restrained arrear"]![i] + data.id] =
              TarReportModel.fromJson(data.data() as Map<String, dynamic>);
        }
      }
    }

    return {"res": "success", "data": allData};
  }

  Future periodNotOver() async {
    Map<String, TarReportModel> allData = {};

    DocumentSnapshot snap = await firebaseFirestore
        .collection("MP")
        .doc("arrears where appeal period not over")
        .get();
    if (snap.exists) {
      for (int i = 0;
          i < SUBCATEGORY["arrears where appeal period not over"]!.length;
          i++) {
        QuerySnapshot snap2 = await firebaseFirestore
            .collection("MP")
            .doc("arrears where appeal period not over")
            .collection(SUBCATEGORY["arrears where appeal period not over"]![i])
            .get();
        for (var data in snap2.docs) {
          // print("Data is here: ${data.data().toString()}");
          allData[SUBCATEGORY["arrears where appeal period not over"]![i] +
                  data.id] =
              TarReportModel.fromJson(data.data() as Map<String, dynamic>);
        }
      }
    }

    return {"res": "success", "data": allData};
  }

  Future recoverableArrears() async {
    try {
      Map<String, TarReportModel> allData = {};
      // print("here is dipuu");
      DocumentSnapshot snap = await firebaseFirestore
          .collection("MP")
          .doc("recoverable arrears")
          .get();
      // print("here is dipuu  n ");
      if (snap.exists) {
        // print("here is dipuu");
        for (int i = 0; i < SUBCATEGORY["recoverable arrears"]!.length; i++) {
          QuerySnapshot snap2 = await firebaseFirestore
              .collection("MP")
              .doc("recoverable arrears")
              .collection(SUBCATEGORY["recoverable arrears"]![i])
              .get();
          for (var data in snap2.docs) {
            // print("Data is here: ${data.data().toString()}");
            allData[SUBCATEGORY["recoverable arrears"]![i] + data.id] =
                TarReportModel.fromJson(data.data() as Map<String, dynamic>);
          }
        }
      }
      // print("here is dipuu end");

      return {"res": "success", "data": allData};
    } catch (e) {
      print("heeelo ma error ${e.toString()}");
    }
  }

  Future TocReport() async {
    Map<String, TocModel> tocData = {};
    try {
      for (int i = 0; i < CATEGORY.length - 1; i++) {
        DocumentSnapshot snap =
            await firebaseFirestore.collection("MP").doc(CATEGORY[i]).get();
        if (snap.exists) {
          for (int j = 0; j < SUBCATEGORY[CATEGORY[i]]!.length; j++) {
            DocumentSnapshot snap2 = await firebaseFirestore
                .collection("MP")
                .doc(CATEGORY[i])
                .collection(SUBCATEGORY[CATEGORY[i]]![j])
                .doc('toc')
                .get();
            tocData[SUBCATEGORY[CATEGORY[i]]![j] + snap2.id] =
                TocModel.fromJson(snap2.data() as Map<String, dynamic>);
          }
        }
      }
      try {
        DocumentSnapshot snap3 = await firebaseFirestore
            .collection('MP')
            .doc('arrears pending for write-off')
            .collection('cases')
            .doc('toc')
            .get();
        tocData["arrears pending for write-off" + snap3.id] =
            TocModel.fromJson(snap3.data() as Map<String, dynamic>);
        return {"res": "success", "data": tocData};
      } catch (e) {
        print("some error occure $e");
      }
    } catch (e) {
      print("error occurs $e");
    }
  }

  Future litigationReport() async {
    Map<String, TarReportModel> allData = {};

    DocumentSnapshot snap = await firebaseFirestore
        .collection("MP")
        .doc("arrear in litigation")
        .get();
    if (snap.exists) {
      for (int i = 0; i < SUBCATEGORY["arrear in litigation"]!.length; i++) {
        QuerySnapshot snap2 = await firebaseFirestore
            .collection("MP")
            .doc("arrear in litigation")
            .collection(SUBCATEGORY["arrear in litigation"]![i])
            .get();
        for (var data in snap2.docs) {
          print("Data is here: ${data.id}");

          allData[SUBCATEGORY["arrear in litigation"]![i] + data.id] =
              TarReportModel.fromJson(data.data() as Map<String, dynamic>);
        }
      }
    }
    // print("heeelo $allData")
    return {
      "res": "success",
      "data": allData,
    };
  }

  Future writeOff() async {
    Map<String, TarReportModel> allData = {};

    DocumentSnapshot snap = await firebaseFirestore
        .collection("MP")
        .doc("arrears pending for write-off")
        .get();
    if (snap.exists) {
      for (int i = 0;
          i < SUBCATEGORY["arrears pending for write-off"]!.length;
          i++) {
        QuerySnapshot snap2 = await firebaseFirestore
            .collection("MP")
            .doc("arrears pending for write-off")
            .collection(SUBCATEGORY["arrears pending for write-off"]![i])
            .get();
        for (var data in snap2.docs) {
          // print("Data is here: ${data.data().toString()}");
          allData[SUBCATEGORY["arrears pending for write-off"]![i] + data.id] =
              TarReportModel.fromJson(data.data() as Map<String, dynamic>);
        }
      }
    }
    // for(var i in allData.keys){
    //   print("data is here ${allData[i]}}");
    // }
    return {"res": "success", "data": allData};
  }
}
