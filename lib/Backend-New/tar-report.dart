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
    print("heloooo i am fff");
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
        print("heloooo i am a");
        docsnap = await firebaseFirestore
            .collection("MP")
            .doc(category)
            .collection(subcategory)
            .doc(docName)
            .get();
            
        if (docsnap.exists) {
          print("heloooo i am fff b");
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
          DocumentReference ref= firebaseFirestore
              .collection("MP")
              .doc(category)
              .collection(subcategory)
              .doc(docName);
          batch.update(ref,model.toJson());
          // await firebaseFirestore
          //     .collection("MP")
          //     .doc(category)
          //     .collection(subcategory)
          //     .doc(docName)
          //     .update(model.toJson());
        } else {
          print("heloooo i am fff c");
          DocumentReference ref= firebaseFirestore
              .collection("MP")
              .doc(category)
              .collection(subcategory)
              .doc(docName);
            batch.set(ref,model.toJson());
          // await firebaseFirestore
          //     .collection("MP")
          //     .doc(category)
          //     .collection(subcategory)
          //     .doc(docName)
          //     .set(model.toJson());
        }
      } else {
        print("heloooo i am fff D");
        await firebaseFirestore
            .collection("MP")
            .doc(category)
            .set({}, SetOptions(merge: true));

        DocumentReference ref= firebaseFirestore
              .collection("MP")
              .doc(category)
              .collection(subcategory)
              .doc(docName);
            batch.set(ref,model.toJson());
         
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


  //get All category Information
// const List<String> CATEGORY = [
//     "arrear in litigation",
//     "restrained arrear",
//     "arrears where appeal period not over",
//     "recoverable arrears",
//     "arrears pending for write-off"
//   ];


Future restrainedArrearReport() async {
  Map<String, TarReportModel> allData = {};

  DocumentSnapshot snap = await firebaseFirestore.collection("MP").doc("restrained arrear").get();
  if (snap.exists) {
    for (int i = 0; i < SUBCATEGORY["restrained arrear"]!.length; i++) {
      QuerySnapshot snap2 = await firebaseFirestore.collection("MP").doc("restrained arrear").collection(SUBCATEGORY["restrained arrear"]![i]).get();
      for (var data in snap2.docs) {
        // print("Data is here: ${data.data().toString()}");
        allData[SUBCATEGORY["arrear in litigation"]![i]+data.id] = TarReportModel.fromJson(data.data() as Map<String, dynamic>);
      }
    }
  }
 
  return {"res":"success","data":allData};
}
Future periodNotOver() async {
  Map<String, TarReportModel> allData = {};

  DocumentSnapshot snap = await firebaseFirestore.collection("MP").doc("arrears where appeal period not over").get();
  if (snap.exists) {
    for (int i = 0; i < SUBCATEGORY["arrears where appeal period not over"]!.length; i++) {
      QuerySnapshot snap2 = await firebaseFirestore.collection("MP").doc("arrears where appeal period not over").collection(SUBCATEGORY["arrears where appeal period not over"]![i]).get();
      for (var data in snap2.docs) {
        // print("Data is here: ${data.data().toString()}");
        allData[SUBCATEGORY["arrear in litigation"]![i]+data.id] = TarReportModel.fromJson(data.data() as Map<String, dynamic>);
      }
    }
  }
 
  return {"res":"success","data":allData};
}
Future recoverableArrears() async {
  Map<String, TarReportModel> allData = {};

  DocumentSnapshot snap = await firebaseFirestore.collection("MP").doc("recoverable arrears").get();
  if (snap.exists) {
    for (int i = 0; i < SUBCATEGORY["recoverable arrears"]!.length; i++) {
      QuerySnapshot snap2 = await firebaseFirestore.collection("MP").doc("recoverable arrears").collection(SUBCATEGORY["recoverable arrears"]![i]).get();
      for (var data in snap2.docs) {
        // print("Data is here: ${data.data().toString()}");
        allData[SUBCATEGORY["arrear in litigation"]![i]+data.id] = TarReportModel.fromJson(data.data() as Map<String, dynamic>);
      }
    }
  }
 
  return {"res":"success","data":allData};
}
Future litigationReport() async {
  Map<String, TarReportModel> allData = {};

  DocumentSnapshot snap = await firebaseFirestore.collection("MP").doc("arrear in litigation").get();
  if (snap.exists) {
    for (int i = 0; i < SUBCATEGORY["arrear in litigation"]!.length; i++) {
      QuerySnapshot snap2 = await firebaseFirestore.collection("MP").doc("arrear in litigation").collection(SUBCATEGORY["arrear in litigation"]![i]).get();
      for (var data in snap2.docs) {
        // print("Data is here: ${data.id}");
        allData[SUBCATEGORY["arrear in litigation"]![i]+data.id] = TarReportModel.fromJson(data.data() as Map<String, dynamic>);
      }
    }
  }
  // print("heeelo $allData")
  return {"res":"success","data":allData};
}

Future writeOff() async {
  Map<String, TarReportModel> allData = {};

  DocumentSnapshot snap = await firebaseFirestore.collection("MP").doc("arrears pending for write-off").get();
  if (snap.exists) {
    for (int i = 0; i < SUBCATEGORY["arrears pending for write-off"]!.length; i++) {
      QuerySnapshot snap2 = await firebaseFirestore.collection("MP").doc("arrears pending for write-off").collection(SUBCATEGORY["arrears pending for write-off"]![i]).get();
      for (var data in snap2.docs) {
        // print("Data is here: ${data.data().toString()}");
        allData[SUBCATEGORY["arrear in litigation"]![i]+data.id] = TarReportModel.fromJson(data.data() as Map<String, dynamic>);
      }
    }
  }
  // for(var i in allData.keys){
  //   print("data is here ${allData[i]}}");
  // }
  return {"res":"success","data":allData};
}

}
