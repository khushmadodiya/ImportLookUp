
// import 'package:flutter/material.dart';

// class Test extends StatefulWidget {
//   @override
//   _TestState createState() => _TestState();
// }
// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('DataTable Demo'),
//         ),
//         body: ListView(
//           children: [
//             _createDataTable()
//           ],
//         ),
//       ),
//     );
//   }
// DataTable _createDataTable() {
//     return DataTable(columns: _createColumns(), rows: _createRows());
//   }
// List<DataColumn> _createColumns() {
//     return [
//       DataColumn(label: Text('ID')),
//       DataColumn(label: Text('Book')),
//       DataColumn(label:DataTable(columns:[
//         DataColumn(label: Text('ID')),
//         DataColumn(label: Text('jsjnsD')),], 
//         rows: _createRows())),
//       DataColumn(label: Text('Author'))
//     ];
//   }
// List<DataRow> _createRows() {
//     return [
//       DataRow(cells: [
//         DataCell(Text('#100')),
//         DataCell(Text('Flutter Basics')),
//         DataCell(Text('David John'))
//       ]),
//       DataRow(cells: [
//         DataCell(Text('#101')),
//         DataCell(Text('Dart Internals')),
//         DataCell(Text('Alex Wick'))
//       ])
//     ];
//   }
// }