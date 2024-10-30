import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Backend-New/main-cases-details.dart';
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
  //   FirebaseFirestore store = FirebaseFirestore.instance;
  //   WriteBatch batch = store.batch();
  //   for (int i = 0; i < CATEGORY.length; i++) {
  //     for (int j = 0; j < SUBCATEGORY[CATEGORY[i]]!.length; j++) {
  //       for (int k = 0; k < DOCNAME.length; k++) {
  //         await TarReportInformation().updateDataOfTarReport(
  //             batch: batch,
  //             category: CATEGORY[i],
  //             subcategory: SUBCATEGORY[CATEGORY[i]]![j],
  //             docName: DOCNAME[k],
  //             noOfCasesOfTheMonth: 0,
  //             noOfCasesUpToTheMonth: 0,
  //             amountOfTheMonth: 0,
  //             amountUpTotheMonth: 0,
  //             openingBalance: 0,
  //             closingBalance: 0);
  //       }
  //       print("heeli i am ${CATEGORY[i]}   ${SUBCATEGORY[CATEGORY[i]]![j]}");
  //     }
  //   }
  //   batch.commit();
  // }

  // void getData() async {
  // AddNewCase dipu=Provider.of<AddNewCase>(context,listen:false);
  //  await dipu.getRequestCasesInformation(formation:"Air Cargo Complex Indore", isAdmin:false);
  //  AddNewCase dipu2=Provider.of<AddNewCase>(context,listen:false);
  // print('dipuuuuuuuuuuuuuuu');
  // var res = await FinancialYear()
  //     .financialYear(currentMonth: DateTime.now().month.toString());
  // print('hello i am dipu ${res['res']}');
  //  print("here dipu ${dipu2.requestCaseData[2].category}");
  // await TarReportInformation().recoverableArrears();
  // }

  getData() async {
    // 576e15e0-936f-11ef-8d76-83920643c546
    // var res = (await TarReportInformation().TocReport());
    var res = await MainCasesInformation().deleteMainCase(
        formation: 'Air Cargo Complex Indore',
        uid: '576e15e0-936f-11ef-8d76-83920643c546',
        docName: 'disposal order for denovo');
    print("nooting is here ");

    //  if(res['res']=='success'){
    //     print("this is my data ${res['data']}");
    //  }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DataTable Demo'),
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
