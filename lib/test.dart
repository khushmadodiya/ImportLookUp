import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Backend-New/main-cases-details.dart';
import 'package:import_lookup/Backend-New/tar-report.dart';
import 'package:import_lookup/Model-New/tar-model.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
import 'package:intl/intl.dart';
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

    searchdata();
    // getData();
    // financial();
    // print("heelo i am ${DateFormat('MMMM').format(DateTime.now())}");
    //  String time=DateFormat('dd-MMMM-yyyy').format(DateTime.now());
    //  DateFormat format=DateFormat('dd-MMMM-yyyy');

    // DateFormat format=DateFormat("dd-Mmmm-")
    // DateTime? heelo=format.parse("1-April-2025");
    //  DateTime? heelo1=format.parse("1-April-2025");
    //  DateTime dipu= DateTime(2025,3,31);
    //  DateTime dip= DateTime(2025,4,1);
    // print("here is dat -> ${time} -> ${dipu.difference(dip).inDays}");
    //  print("here is dat -> ${time}  ->${heelo1.difference(heelo).inDays} -> }");
  }

  void searchdata() async {
    await MainCasesInformation().getReplicateMainCase(category: 'ICD Tihi');
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

  void financial() {
    FinancialYear().financialYear(currentMonth: 'November');
  }

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

  // getData() async {
  //   // 576e15e0-936f-11ef-8d76-83920643c546
  //   // var res = (await TarReportInformation().TocReport());
  //   // var res = await MainCasesInformation().deleteMainCase(
  //   //     formation: 'Air Cargo Complex Indore',
  //   //     uid: '576e15e0-936f-11ef-8d76-83920643c546',
  //   //     docName: 'disposal order for denovo');
  //   // print("nooting is here ");
  // //  await FinancialYear().financialYear(currentMonth: DateFormat('MMMM').format(DateTime.now()));
  // //  print("heeelo jnsjn");
  //
  //   //  if(res['res']=='success'){
  //   //     print("this is my data ${res['data']}");
  //   //  }
  //
  //     GeneralPurposeProvider pro= Provider.of<GeneralPurposeProvider>(context,listen: false);
  //     pro.getFinancialData();
  //     print("hello i am khush");
  //     print(pro.currentMonth);
  // }

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
