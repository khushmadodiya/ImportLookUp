// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:import_lookup/Backend/authmethos.dart';
// import 'package:import_lookup/Provider-New/add-new-cases.dart';
// import 'package:import_lookup/Provider-New/get-user-deatils.dart';
// import 'package:provider/provider.dart';
// import 'package:import_lookup/Backend/fetchAsseserData.dart';
// import 'package:import_lookup/Screens/universal-update-details-page.dart';
// import 'package:import_lookup/excael-download-option.dart';
// import '../global.dart';
// import '../provider/provider.dart';
//
//
// class ShowAsserDetails extends StatefulWidget {
//   const ShowAsserDetails({super.key});
//
//   @override
//   State<ShowAsserDetails> createState() => _ShowAsserDetailsState();
// }
//
// class _ShowAsserDetailsState extends State<ShowAsserDetails> {
//   List<Map<String, dynamic>> myData = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch data on widget initialization
//     getData();
//   }
//
//   int num = 0;
//
//   @override
//   Widget build(BuildContext context) {
//
//         return Consumer<AddNewCase>(
//           builder: (context,provider,child)=>
//            Scaffold(
//             appBar: AppBar(
//                 title: const Text('SHOW OIO DETAILS'),
//                 actions: [
//                   IconButton(onPressed: (){
//                     AuthMethods().signOut(context);
//                     setState(() {
//
//                     });
//                   }, icon: Icon(Icons.logout))
//                 ],
//             ),
//             // body: Text('hell0'),
//             body: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InkWell(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 40,
//                       width: 150,
//                       color: Colors.amber.withOpacity(0.3),
//                       child: const Center(child: Text("Download Excel")),
//                     ),
//                   ),
//                   onTap: () {
//                     ExcelDonwloadOption().exportToExcel(myData, 'OIO DETAILS');
//                   },
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Padding(
//                         padding: const EdgeInsets.all(18.0),
//                         child: Card(
//                           elevation: 12,
//                           color: Colors.white,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                           child: Table(
//                             border: TableBorder.all(width: 1.0, color: Colors.black),
//                             columnWidths: const {
//                               0: FixedColumnWidth(70),
//                               1: FixedColumnWidth(300),
//                               2: FixedColumnWidth(180),
//                               3: FixedColumnWidth(300),
//                               4: FixedColumnWidth(150),
//                               5: FixedColumnWidth(120),
//                               6: FixedColumnWidth(180),
//                               7: FixedColumnWidth(180),
//                               8: FixedColumnWidth(180),
//                               9: FixedColumnWidth(180),
//                               10: FixedColumnWidth(180),
//                               11: FixedColumnWidth(350),
//                               12: FixedColumnWidth(350),
//                               13: FixedColumnWidth(250),
//                               14: FixedColumnWidth(180),
//                               15: FixedColumnWidth(180),
//                             },
//                             children: [
//                               // Header Row
//                               _buildHeaderRow(),
//                               // Data Rows
//                               for(int i=0;i<provider.mainCaseData.length;i++)
//                                 _buildDataRow( provider, i)
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//              ),
//           );
//
//
//   }
//
//   TableRow _buildHeaderRow() {
//     return TableRow(
//       children: [
//         _buildHeaderCell('S No.', 1),
//         _buildHeaderCell('Name', 2),
//         _buildHeaderCell('Division/Range', 3),
//         _buildHeaderCell('OIO', 4),
//         _buildHeaderCell('Date', 5),
//         _buildHeaderCell('Day Count', 6),
//         _buildHeaderCell('Duty or Arrears', 7),
//         _buildHeaderCell('Penalty', 8),
//         _buildHeaderCell('Amount Recovered', 9),
//         _buildHeaderCell('Pre Deposit', 10),
//         _buildHeaderCell('Total Arrears Pending', 11),
//         _buildHeaderCell('Brief Facts', 12),
//         _buildHeaderCell('Status', 13),
//         _buildHeaderCell('Appeal No.', 14),
//         _buildHeaderCell('Stay Order No and Date', 15),
//         _buildHeaderCell('Change Data', 16),
//       ],
//     );
//   }
//
//   TableRow _buildDataRow(AddNewCase provider, int index) {
//     // String day = _calculateDayCount(provider.mainCaseData[index].date).toString();
//     return TableRow(
//       children: [
//         _multiLineText('${index+1}', 1),
//         _multiLineText(provider.mainCaseData[index].name ?? 'N/A', 2),
//         _multiLineText(provider.mainCaseData[index].formation ?? 'N/A', 3),
//         _multiLineText(provider.mainCaseData[index].oio?? 'N/A', 4),
//         _multiLineText(provider.mainCaseData[index].date ?? 'N/A', 5),
//         _multiLineText('1', 6),
//         _multiLineText(provider.mainCaseData[index].dutyOfArrear ?? 'N/A', 7),
//         _multiLineText(provider.mainCaseData[index].penalty ?? 'N/A', 8),
//         _multiLineText(provider.mainCaseData[index].amountRecovered ?? 'N/A', 9),
//         _multiLineText(provider.mainCaseData[index].preDeposit ?? 'N/A', 10),
//         _multiLineText(provider.mainCaseData[index].totalArrearPending ?? 'N/A', 11),
//         _multiLineText(provider.mainCaseData[index].briefFact ?? 'N/A', 12),
//         _multiLineText(provider.mainCaseData[index].status?? 'N/A', 13),
//         _multiLineText(provider.mainCaseData[index].apealNo ?? 'N/A', 14),
//         _multiLineText(provider.mainCaseData[index].stayOrderNumberAndDate ?? 'N/A', 15),
//         _buildTransferButton(index,{}),
//       ],
//     );
//   }
//
//   Widget _buildTransferButton(int i,Map<String, dynamic> data) {
//     return Container(
//       color: Colors.blue.withOpacity(0.2),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         child: ElevatedButton(
//           onPressed: () async {
//             print(data['complete_track']?.map<Widget>((track) => Text(track)).toList() ?? [Text('No track available')],);
//             bool? shouldRefresh = await Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => UpdateUniversalDetails(index: i),
//               ),
//             );
//
//             if (shouldRefresh == true) {
//               Provider.of<AsseserProvider>(context, listen: false).fetchAssesers();
//             }
//           },
//           child: const Text("Transfer Case"),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeaderCell(String text, int i) {
//     return Container(
//       color: i % 2 == 0 ? Colors.blue.withOpacity(0.2) : Colors.blue.withOpacity(0.3),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           text,
//           style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
//
//   Widget _multiLineText(String text, int i) {
//     return Container(
//       height: 70,
//       color: i % 2 == 0 ? Colors.blue.withOpacity(0.2) : Colors.blue.withOpacity(0.3),
//       padding: const EdgeInsets.all(8.0),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Text(
//           text,
//           style: const TextStyle(fontSize: 15),
//           overflow: TextOverflow.visible,
//           softWrap: true,
//         ),
//       ),
//     );
//   }
//
//   int _calculateDayCount(String dateStr) {
//     List<String> parts = dateStr.split('-');
//
//     if (parts.length != 3) {
//       return 0;
//     }
//
//     int day = int.parse(parts[0]);
//     int month = int.parse(parts[1]);
//     int year = int.parse(parts[2]);
//
//     DateTime dateTime;
//     try {
//       dateTime = DateTime(year, month, day);
//     } catch (e) {
//       return 0;
//     }
//
//     final now = DateTime.now();
//     final difference = now.difference(dateTime);
//
//     return difference.inDays;
//   }
//
//   void getData()async {
//
//     final asseserProvider = Provider.of<AddNewCase>(context, listen: false);
//     final userinfo = Provider.of<UserInformation>(context,listen: false);
//    await asseserProvider.getMainCasesInformation(formation: userinfo.formation, isAdmin: false);
//
//     print('dipu landka hai ${asseserProvider.mainCaseData[0].name}');
//   }
// }
