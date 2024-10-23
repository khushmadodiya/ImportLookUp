import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Backend-New/tar-report.dart';
import 'package:import_lookup/Model-New/tar-model.dart';
import 'package:provider/provider.dart';

import 'Backend-New/financial-year.dart';
import 'Provider-New/add-new-cases.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  // void getData() async {
  // AddNewCase dipu=Provider.of<AddNewCase>(context,listen:false);
  //  await dipu.getMainCasesFromReplication(query:"air");
  //  AddNewCase dipu2=Provider.of<AddNewCase>(context,listen:false);
  //  print("here dipu ${dipu2.mainCaseData.length}");
  // FirebaseFirestore store = FirebaseFirestore.instance;
  // WriteBatch batch = store.batch();
  // for (int i = 0; i < CATEGORY.length; i++) {
  //   for (int j = 0; j < SUBCATEGORY[CATEGORY[i]]!.length; j++) {
  //     for (int k = 0; k < DOCNAME.length; k++) {
  //       await TarReportInformation().updateDataOfTarReport(
  //           batch: batch,
  //           category: CATEGORY[i],
  //           subcategory: SUBCATEGORY[CATEGORY[i]]![j],
  //           docName: DOCNAME[k],
  //           noOfCasesOfTheMonth: 0,
  //           noOfCasesUpToTheMonth: 0,
  //           amountOfTheMonth: 0,
  //           amountUpTotheMonth: 0,
  //           openingBalance: 0,
  //           closingBalance: 0);
  // }
  // print("heeli i am ${CATEGORY[i]}   ${SUBCATEGORY[CATEGORY[i]]![j]}");
  // }
  // }
  // batch.commit();
  // }

  void getData() async {
    await Provider.of<AddNewCase>(context, listen: false).tarArrearLitigation();

    print(
        "i am dipu jddjnjnj  ${Provider.of<AddNewCase>(context, listen: false).litigationCompleteData[0]!.amountOfTheMonth}");

    // print("i am khushvant madodiya ${model!.amountOfTheMonth}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('DataTable Demo'),
        ),
        body: ListView(
          children: [_createDataTable()],
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('ID')),
      DataColumn(label: Text('Book')),
      DataColumn(
          label: DataTable(columns: [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('jsjnsD')),
      ], rows: _createRows())),
      DataColumn(label: Text('Author'))
    ];
  }

  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('Flutter Basics')),
        DataCell(Text('David John'))
      ]),
      DataRow(cells: [
        DataCell(Text('#101')),
        DataCell(Text('Dart Internals')),
        DataCell(Text('Alex Wick'))
      ])
    ];
  }
}
