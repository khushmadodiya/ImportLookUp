import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Model-New/tar-model.dart';
import 'package:uuid/uuid.dart';

class TarReportInformation {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future updateDataOfTarReport({
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
          openingBalance:0,
          closingBalance: amountOfTheMonth);
      if (docsnap.exists) {
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
              closingBalance: data['closingBalance'] + amountOfTheMonth
              );
          await firebaseFirestore
              .collection("MP")
              .doc(category)
              .collection(subcategory)
              .doc(docName)
              .update(model.toJson());
        } else {
          await firebaseFirestore
              .collection("MP")
              .doc(category)
              .collection(subcategory)
              .doc(docName)
              .set(model.toJson());
        }
      } else {
        await firebaseFirestore
            .collection("MP")
            .doc(category)
            .set({}, SetOptions(merge: true));
        await firebaseFirestore
            .collection("MP")
            .doc(category)
            .collection(subcategory)
            .doc(docName)
            .set(model.toJson());
      }
      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occured ${e.toString()}"};
    }
  }

  //transfer case in up to the month

  Future transferCasesUpTheMonth({
    required String category,
    required String subcategory,
    required String docName,
  }) async {
    try {
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
                      data["amountOfTheMonth"] + data["amountUpTotheMonth"],
                  noOfCasesOfTheMonth: 0,
                  noOfCasesUpToTheMonth: data["noOfCasesUpToTheMonth"] +
                      data["noOfCasesOfTheMonth"],
                  openingBalance:
                      data["openingBalance"] + data["closingBalance"],
                  closingBalance: 0);
              await firebaseFirestore
                  .collection("MP")
                  .doc(category)
                  .collection(subcategory)
                  .doc(docName)
                  .update(model.toJson());
            } else {
              return {"res": "some problem is occured"};
            }
          }
        }
      }

      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occured ${e.toString()}"};
    }
  }

  Future transferCasesYear({
    required String category,
    required String subcategory,
    required String docName,
  }) async {
    try {
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
                  openingBalance:
                      data["openingBalance"] + data["closingBalance"],
                  closingBalance: 0);
              await firebaseFirestore
                  .collection("MP")
                  .doc(category)
                  .collection(subcategory)
                  .doc(docName)
                  .update(model.toJson());
            } else {
              return {"res": "some problem is occured"};
            }
          }
        }
      }

      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occured ${e.toString()}"};
    }
  }
}
