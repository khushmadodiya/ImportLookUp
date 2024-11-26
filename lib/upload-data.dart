// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:excel/excel.dart';
// // import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:import_lookup/Backend-New/main-cases-details.dart';
// import 'package:import_lookup/Model-New/main-case-model.dart';

// class UploadData extends StatefulWidget {
//   const UploadData({super.key});

//   @override
//   State<UploadData> createState() => _UploadDataState();
// }

// class _UploadDataState extends State<UploadData> {
//   List<MainCaseModel> jsonData = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Text("hello"),
//           Container(
//             height: 100,
//             width: 100,
//             color: Colors.red,
//             child: ElevatedButton(
//                 onPressed: () async {
//                   FilePickerResult? pickedFile =
//                       await FilePicker.platform.pickFiles(
//                     type: FileType.custom,
//                     allowedExtensions: ['xlsx'],
//                     allowMultiple: false,
//                   );
//                   if (pickedFile != null) {
//                     // print("i ma hete ");
//                     var bytes = pickedFile.files.single.bytes;
//                     var excel = Excel.decodeBytes(bytes!);
//                     for (var table in excel.tables.keys) {
//                       int i = 0;
//                       for (var row in excel.tables[table]!.rows) {
//                         if (i != 0) {
//                           // jsonData[row[1]!.value.toString()] = {
//                           //   "newTotal": int.parse(row[0]!.value.toString()),
//                           //   "warehouseId": "66fceb5163c6d5c106cfa809",
//                           //   "additionalInfo": {"reason": "Excel update"}
//                           // };
//                           MainCaseModel model = MainCaseModel(
//                               uid: '',
//                               name: row[0]!.value.toString(),
//                               formation: row[1]!.value.toString(),
//                               oio: row[2]!.value.toString(),
//                               date: row[3]!.value.toString(),
//                               dutyOfArrear: row[4]!.value.toString(),
//                               penalty: row[5]!.value.toString(),
//                               intrest: row[23]!.value.toString(),
//                               amountRecovered: row[6]!.value.toString(),
//                               preDeposit: row[7]!.value.toString(),
//                               totalArrearPending: row[8]!.value.toString(),
//                               briefFact: row[9]!.value.toString(),
//                               status: row[10]!.value.toString(),
//                               apealNo: row[11]!.value.toString(),
//                               stayOrderNumberAndDate: row[12]!.value.toString(),
//                               gstin: row[13]!.value.toString(),
//                               iec: row[14]!.value.toString(),
//                               pan: row[15]!.value.toString(),
//                               completeTrack: [],
//                               category: row[19]!.value.toString(),
//                               remark: row[24]!.value.toString(),
//                               subcategory: row[22]!.value.toString(),
//                               effortMade: row[21]!.value.toString());
//                           jsonData.add(model);
//                           print(jsonData[i].toJson());
//                         } else {
//                           i++;
//                         }
//                       }
//                       if (jsonData.isNotEmpty) {}
//                     }
//                   }
//                 },
//                 child: Text("Upload Excel")),
//           ),
//           ElevatedButton(
//               onPressed: () async {
//                 int count = 0;
//                 if (jsonData.isNotEmpty) {
//                   for (MainCaseModel i in jsonData) {
//                     var res = await MainCasesInformation().addCases(
//                         uid: i.uid,
//                         name: i.name,
//                         formation: i.formation,
//                         oio: i.oio,
//                         date: i.date,
//                         dutyOfArrear: i.dutyOfArrear,
//                         penalty: i.penalty,
//                         amountRecovered: i.amountRecovered,
//                         preDeposit: i.preDeposit,
//                         intrest: i.intrest,
//                         totalArrearPending: i.totalArrearPending,
//                         briefFact: i.briefFact,
//                         status: i.status,
//                         apealNo: i.apealNo,
//                         stayOrderNumberAndDate: i.stayOrderNumberAndDate,
//                         iec: i.iec,
//                         gstin: i.gstin,
//                         pan: i.pan,
//                         completeTrack: [],
//                         category: i.category,
//                         remark: i.remark,
//                         subcategory: i.subcategory,
//                         effortMade: i.effortMade);
//                     if (res['res'] == 'success') {
//                       print('This is my count $count');
//                       count++;
//                     }
//                   }
//                 }
//               },
//               child: Text("Load Data"))
//         ],
//       ),
//     );
//   }
// }
