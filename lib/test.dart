
import 'package:flutter/material.dart';
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

  void getData()async{
  // AddNewCase dipu=Provider.of<AddNewCase>(context,listen:false);
  //  await dipu.getRequestCasesInformation(formation:"Air Cargo Complex Indore", isAdmin:false);
  //  AddNewCase dipu2=Provider.of<AddNewCase>(context,listen:false);
    print('dipuuuuuuuuuuuuuuu');
  var res = await FinancialYear().financialYear(currentMonth: DateTime.now().month.toString());
  print('hello i am dipu ${res['res']}');
  //  print("here dipu ${dipu2.requestCaseData[2].category}");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('DataTable Demo'),
        ),
        body: ListView(
          children: [
            _createDataTable()
          ],
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
      DataColumn(label:DataTable(columns:[
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('jsjnsD')),], 
        rows: _createRows())),
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