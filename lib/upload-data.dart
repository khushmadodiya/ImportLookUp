import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/Backend-New/main-cases-details.dart';
import 'package:import_lookup/Model-New/main-case-model.dart';

class UploadData extends StatefulWidget {
  const UploadData({super.key});

  @override
  State<UploadData> createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  List<MainCaseModel> jsonData = [];

  String formatDate(String isoDate) {
    // Parse the ISO 8601 date string
    DateTime parsedDate = DateTime.parse(isoDate);

    // Extract day, month, and year, and format them
    String day = parsedDate.day.toString().padLeft(2, '0'); // Ensure two digits
    String month = parsedDate.month.toString().padLeft(2, '0'); // Ensure two digits
    String year = parsedDate.year.toString();

    // Return the formatted string
    return "$day-$month-$year";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("hello"),
          Container(
            height: 100,
            width: 100,
            color: Colors.red,
            child:
            ElevatedButton(
                onPressed: () async {
                  FilePickerResult? pickedFile =
                  await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['xlsx'],
                    allowMultiple: false,
                  );
                  if (pickedFile != null) {
                    // print("i ma hete ");
                    var bytes = pickedFile.files.single.bytes;
                    var excel = Excel.decodeBytes(bytes!);
                    jsonData.clear();
                    for (var table in excel.tables.keys) {
                      int i = 0;
                      for (var row in excel.tables[table]!.rows) {
                        if (i != 0) {
                          String val = formatDate(row[3]!.value.toString());
                          // print("date $val");
                       MainCaseModel model=   await MainCaseModel(uid: '',
                              name: row[0]!.value.toString().trim(),
                              formation: row[1]!.value.toString().trim(),
                              oio: row[2]!.value.toString().trim(),
                              // date: val,
                                date:'',
                              dutyOfArrear: row[4]!.value.toString().trim(),
                              penalty: row[5]!.value.toString().trim(),
                              intrest: row[19]!.value.toString().trim(),
                              amountRecovered: row[6]!.value.toString().trim(),
                              preDeposit: row[7]!.value.toString().trim(),
                              totalArrearPending: row[8]!.value.toString().trim(),
                              briefFact: row[9]!.value.toString().trim(),
                              status: row[10]!.value.toString().trim(),
                              apealNo: row[11]!.value.toString().trim(),
                              stayOrderNumberAndDate: row[12]!.value.toString().trim(),
                              gstin: row[13]!.value.toString().trim(),
                              iec: row[14]!.value.toString().trim(),
                              pan: row[15]!.value.toString().trim(),
                              completeTrack: [],
                              category: row[16]!.value.toString().trim(),
                              remark:'',
                              subcategory: row[18]!.value.toString().trim(),
                              effortMade: row[17]!.value.toString().trim());
                           jsonData.add(model);
                        }
                          i++;
                        
                      }
                      print("Complete with count $i");
                      if (jsonData.isNotEmpty) {
                        
                      }
                    }
                  }
                },
                child: Text("Upload Excel")),
          ),
          
          ElevatedButton(
              onPressed: () async {
                int count = 0;
                if (jsonData.isNotEmpty) {
                  for (var i=150;i<jsonData.length;i++) {

                    var res = await MainCasesInformation().addCases(
                        uid: jsonData[i].uid,
                        name: jsonData[i].name.trim(),
                        formation: jsonData[i].formation,
                        oio: jsonData[i].oio,
                        date: jsonData[i].date,
                        dutyOfArrear: jsonData[i].dutyOfArrear,
                        penalty: jsonData[i].penalty,
                        amountRecovered: jsonData[i].amountRecovered,
                        preDeposit: jsonData[i].preDeposit,
                        intrest: jsonData[i].intrest,
                        totalArrearPending: jsonData[i].totalArrearPending,
                        briefFact: jsonData[i].briefFact,
                        status: jsonData[i].status,
                        apealNo: jsonData[i].apealNo,
                        stayOrderNumberAndDate: jsonData[i].stayOrderNumberAndDate,
                        iec: jsonData[i].iec,
                        gstin: jsonData[i].gstin,
                        pan: jsonData[i].pan,
                        completeTrack: [],
                        category: jsonData[i].category,
                        remark: jsonData[i].remark,
                        subcategory: jsonData[i].subcategory,
                        effortMade: jsonData[i].effortMade);
                    Future.delayed(Duration(seconds: 8));
                    if (res['res'] == 'success') {
                      print('This is my count $count');
                      count++;
                    }
                  }
                }
              },
              child: Text("Load Data"))
        ],
      ),
    );
  }
}
