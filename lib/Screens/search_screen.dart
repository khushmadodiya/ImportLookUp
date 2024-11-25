import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:import_lookup/Model-New/main-case-model.dart';
import 'package:import_lookup/Provider-New/add-new-cases.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
import 'package:import_lookup/Screens-New/Dashboard/complete-track.dart';
import 'package:import_lookup/Widgets/custom-button.dart';
import 'package:provider/provider.dart';
import '../Backend-New/Golbal-Files/category-and-subcategory.dart';
import '../Backend-New/main-cases-details.dart';
import '../Provider-New/get-user-deatils.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final ScrollController horizontalController = ScrollController();
//   final ScrollController verticalController = ScrollController();
//   final TextEditingController _controller = TextEditingController();
//   var asseserProvider;
//   List<MainCaseModel> data=[];
//
//   @override
//   void initState() {
//     super.initState();
//     // getData(); // Fetch data on widget initialization
//   }
//
//   int num = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Consumer<GeneralPurposeProvider>(
//       builder: (context,generalProvider,child)=>
//      Consumer<UserInformation>(
//         builder: (context, userInfo, child) => Consumer<AddNewCase>(
//           builder: (context, provider, child) => Scaffold(
//             // appBar: AppBar(title: const Text('Search Cases')),
//             body: Column(
//               children: [
//                 Container(
//                   height: 70,
//                   child: Padding(
//                     padding: const EdgeInsets.all( 14.0),
//                     child: TextField(
//                       controller: _controller,
//                       decoration: const InputDecoration(
//                         labelText: 'Search by Category Subcategory name formation... to filter',
//                         hintText: 'Search by Category Subcategory name formation... to filter',
//                         border: OutlineInputBorder(),
//                       ),
//                       onSubmitted: (value) async{
//                         print("OnSubmit called");
//                       var res=  await MainCasesInformation().getReplicateMainCase( category: value);
//                       data = res['data'];
//                       setState(() {
//
//                       });
//                       print("This is record on submit${res['res']}");
//                       },
//                     ),
//                   ),
//                 ),
//                 Expanded(child: _buildTable()
//                 ),
//                 // if (userInfo.userType == USERTYPE[0])
//                 //   SingleChildScrollView(
//                 //     scrollDirection: Axis.horizontal,
//                 //     child: Consumer<GeneralPurposeProvider>(
//                 //       builder: (context, generalProvider, child) => Row(
//                 //         children: List.generate(
//                 //             FORMATION.length,
//                 //                 (index) => Padding(
//                 //               padding: const EdgeInsets.all(8.0),
//                 //               child: InkWell(
//                 //                 child: Container(
//                 //                   color:
//                 //                   generalProvider.selectedIndex == index
//                 //                       ? Colors.blue
//                 //                       : Colors.green,
//                 //                   child: Padding(
//                 //                     padding: const EdgeInsets.all(8.0),
//                 //                     child: Text(
//                 //                       FORMATION[index],
//                 //                       style: const TextStyle(
//                 //                           color: Colors.white,
//                 //                           fontWeight: FontWeight.bold),
//                 //                     ),
//                 //                   ),
//                 //                 ),
//                 //                 onTap: () {
//                 //                   provider.updateLoader();
//                 //                   generalProvider.updateSelectedIndex(index);
//                 //                   provider.getMainCasesInformation(
//                 //                       formation: FORMATION[index],
//                 //                       isAdmin: false);
//                 //                   provider.updateLoader();
//                 //                 },
//                 //               ),
//                 //             )),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // const SizedBox(
//                 //   height: 20,
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTable() {
//     Offset? _startDragPosition;
//
//     // Handle the drag update for scrolling in both directions
//     void _handleDragUpdate(DragUpdateDetails details) {
//       if (_startDragPosition != null) {
//         // Scroll horizontally
//         horizontalController.jumpTo(
//           horizontalController.offset - details.delta.dx,
//         );
//         // Scroll vertically
//         // verticalController.jumpTo(
//         //   verticalController.offset - details.delta.dy,
//         // );
//       }
//     }
//
//     // When user starts dragging, capture the initial position
//     void _handleDragStart(DragStartDetails details) {
//       _startDragPosition = details.globalPosition;
//     }
//
//     // Reset the drag position when the user stops dragging
//     void _handleDragEnd(DragEndDetails details) {
//       _startDragPosition = null;
//     }
//     void _handleKeyEvent(KeyEvent event) {
//       if (FocusManager.instance.primaryFocus?.context?.widget is! TextField) {
//         if (event is KeyDownEvent) {
//           if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
//             verticalController.animateTo(
//               verticalController.offset - 100, // Adjust scroll amount as needed
//               duration: Duration(milliseconds: 200),
//               curve: Curves.easeInOut,
//             );
//           } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
//             verticalController.animateTo(
//               verticalController.offset + 100, // Adjust scroll amount as needed
//               duration: Duration(milliseconds: 200),
//               curve: Curves.easeInOut,
//             );
//           } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
//             horizontalController.animateTo(
//               horizontalController.offset - 300,
//               // Adjust scroll amount as needed
//               duration: Duration(milliseconds: 200),
//               curve: Curves.easeInOut,
//             );
//           } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
//             horizontalController.animateTo(
//               horizontalController.offset + 300,
//               // Adjust scroll amount as needed
//               duration: Duration(milliseconds: 200),
//               curve: Curves.easeInOut,
//             );
//           }
//         }
//       }
//     }
//
//     final asseserProvider = Provider.of<AddNewCase>(context,listen: false);
//     final genralProvider = Provider.of<GeneralPurposeProvider>(context,listen: false);
//     if (asseserProvider.searchLoader) {
//       return Center(child: CircularProgressIndicator());
//     }
//
//     if (asseserProvider.mainCaseDataForSearching.isEmpty) {
//       return Center(child: Text('No data found'));
//     }
//     // var filteredAssesers = asseserProvider.mainCaseDataForSearching.where((asseser) {
//     //   final category = asseser.category ?? '';
//     //   final subcategory = asseser.subcategory ?? '';
//     //   final name = asseser.name ?? '';
//     //   final brief_facts = asseser.briefFact ?? '';
//     //   final formation = asseser.formation ?? '';
//     //
//     //   return category.toLowerCase().contains(genralProvider.searchQuery.toLowerCase()) ||
//     //        subcategory.toLowerCase().contains(genralProvider.searchQuery.toLowerCase()) ||
//     //       name.toLowerCase().contains(genralProvider.searchQuery.toLowerCase()) ||
//     //       formation.toLowerCase().contains(genralProvider.searchQuery.toLowerCase()) ;
//     //       // brief_facts.toLowerCase().contains(genralProvider.searchQuery.toLowerCase());
//     // }).toList();
//
//     List<TableRow> rows = [];
//     print('start time ${DateTime.timestamp()}');
//     for (int i = 0; i < data.length; i++) {
//       MainCaseModel mainCaseModel = data[i];
//       print("data from table ${data[i].name}");
//       // print("here data of complere ${asseser['complete_track'].length}");
//       num++;
//       rows.add(_buildDataRow(mainCaseModel, i));
//     }
//     print('end time ${DateTime.timestamp()}');
// //     void sortBasedofDate() {
// //       filteredAssesers = asseserProvider.mainCaseDataForSearching;
// //       filteredAssesers.sort((a, b) => DateTime(
// //           int.parse(a.date.toString().substring(6, 10)),
// //           int.parse(a.date.toString().substring(3, 5)),
// //           int.parse(a.date.toString().substring(0, 2)))
// //           .compareTo(DateTime(
// //           int.parse(b.date.toString().substring(6, 10)),
// //           int.parse(b.date.toString().substring(3, 5)),
// //           int.parse(b.date.toString().substring(0, 2)))));
// //       setState(() {
// //
// //       });
// //     }
// //     void sortBasedofToatlArrearsPending() {
// //       filteredAssesers = asseserProvider.mainCaseDataForSearching;
// //       filteredAssesers.sort((a, b) {
// //         int aId = int.parse(a.totalArrearPending);
// //         int bId = int.parse(b.totalArrearPending);
// //
// //         if (aId > bId) {
// //           return -1; // Descending order
// //         } else if (aId < bId) {
// //           return 1;
// //         } else {
// //           return 0; // Equal
// //         }
// //       });
// // setState(() {
// //
// // });
// //     }
//
//
//
//     // void sortBasedofToatlArrearsPending() {
//     //   filteredAssesers = asseserProvider.mainCaseDataForSearching;
//     //   filteredAssesers.sort((a, b) {
//     //     if (int.parse(a.totalArrearPending) > int.parse(b.totalArrearPending)) {
//     //       return 1;
//     //     }
//     //     return 0;
//     //   });
//     //   setState(() {
//     //     print('Called');
//     //   });
//     // }
//
//     return Focus(
//       // autofocus: true,
//       // skipTraversal: true,
//       // onKeyEvent: (FocusNode node, KeyEvent event) {
//       //   _handleKeyEvent(event);
//       //   return KeyEventResult.handled;
//       // },
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(children: [
//           // Container(
//           //   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
//           //   // height: 40,
//           //   // // width: MediaQuery.of(context).size.width/3,
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     children: [
//           //       Expanded(
//           //         child: GlobleDropdown(
//           //             listofvalues: FORMATION,
//           //             label: "Sort by Formation",
//           //             fun: (val){
//           //               print(val);
//           //               genralProvider.updateFormationSearch(val!);
//           //              var filter = asseserProvider.mainCaseDataForSearching;
//           //                  filter.where((ass){
//           //                 // return ass.formation.toLowerCase().trim()==genralProvider.formationSearch.toLowerCase().trim();
//           //                 return ass.subcategory.toLowerCase().trim()=='sc';
//           //               }).toList();
//           //                  setState(() {
//           //                    print("sorted by formation");
//           //                    print(filter.length);
//           //                  });
//           //             },
//           //
//           //             selectedItem: ''
//           //         )
//           //       ),
//           //       SizedBox(
//           //         width: 5,
//           //       ),
//           //       Expanded(
//           //         child: CustomButton(
//           //           onpress: () {
//           //             sortBasedofToatlArrearsPending();
//           //           },
//           //           text:
//           //           "Sort Based On arrears pending", isLoading: false,
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
//             // height: 40,
//             // // width: MediaQuery.of(context).size.width/3,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: CustomButton(
//                       onpress: () {
//                         // sortBasedofDate();
//                       },
//                       text: "Sort Based On Date", isLoading: false),
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 Expanded(
//                   child: CustomButton(
//                       onpress: () {
//                         // sortBasedofToatlArrearsPending();
//                       },
//                       text:
//                         "Sort Based On arrears pending", isLoading: false,
//                         ),
//                 ),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onPanStart: _handleDragStart,
//             onPanUpdate: _handleDragUpdate,
//             onPanEnd: _handleDragEnd,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               controller: verticalController,
//               child: Scrollbar(
//                 controller: horizontalController,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   controller: horizontalController,
//                   child: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: Table(
//                       border: TableBorder.all(width: 1.0, color: Colors.black),
//                       columnWidths: const {
//                         0: FixedColumnWidth(70),
//                         1: FixedColumnWidth(300),
//                         2: FixedColumnWidth(300),
//                         3: FixedColumnWidth(180),
//                         4: FixedColumnWidth(180),
//                         5: FixedColumnWidth(300),
//                         6: FixedColumnWidth(150),
//                         7: FixedColumnWidth(120),
//                         8: FixedColumnWidth(180),
//                         9: FixedColumnWidth(180),
//                         10: FixedColumnWidth(180),
//                         11: FixedColumnWidth(180),
//                         12: FixedColumnWidth(180),
//                         13: FixedColumnWidth(350),
//                         14: FixedColumnWidth(350),
//                         15: FixedColumnWidth(250),
//                         16: FixedColumnWidth(200),
//                         17: FixedColumnWidth(180),
//                       },
//                       children: [
//                         // Header Row
//                         _buildHeaderRow(),
//                         ...rows
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
//
//   TableRow _buildHeaderRow() {
//     return TableRow(
//       children: [
//         _buildHeaderCell('S No.', 1),
//         _buildHeaderCell('category', 2),
//         _buildHeaderCell('subcategory', 3),
//         _buildHeaderCell('Name', 4),
//         _buildHeaderCell('Formation', 5),
//         _buildHeaderCell('OIO', 6),
//         _buildHeaderCell('Date', 7),
//         _buildHeaderCell('Day Count', 8),
//         _buildHeaderCell('Duty or Arrears', 9),
//         _buildHeaderCell('Penalty', 10),
//         _buildHeaderCell('Amount Recovered', 11),
//         _buildHeaderCell('Pre Deposit', 12),
//         _buildHeaderCell('Total Arrears Pending', 13),
//         _buildHeaderCell('Brief Facts', 14),
//         _buildHeaderCell('Status', 15),
//         _buildHeaderCell('Appeal No.', 16),
//         _buildHeaderCell('Stay Order No and Date', 17),
//         _buildHeaderCell('Complete Track', 18),
//       ],
//     );
//   }
//
//   TableRow _buildDataRow(MainCaseModel data, int i) {
//     String day = _calculateDayCount(data.date).toString();
//     return TableRow(
//       children: [
//         _multiLineText((i + 1).toString(), 1),
//         _multiLineText(data.category.toString(), 2),
//         _multiLineText(data.subcategory.toString(), 3),
//         _multiLineText(data.name.toString() ?? 'N/A', 4),
//         _multiLineText(data.formation ?? 'N/A', 5),
//         _multiLineText(data.oio ?? 'N/A', 6),
//         _multiLineText(data.date ?? 'N/A', 7),
//         _multiLineText(day, 8),
//         _multiLineText(data.dutyOfArrear ?? 'N/A', 9),
//         _multiLineText(data.penalty ?? 'N/A', 10),
//         _multiLineText(data.amountRecovered ?? 'N/A', 11),
//         _multiLineText(data.preDeposit ?? 'N/A', 12),
//         _multiLineText(data.totalArrearPending ?? 'N/A', 13),
//         _multiLineText(data.briefFact ?? 'N/A', 14),
//         _multiLineText(data.status ?? 'N/A', 15),
//         _multiLineText(data.apealNo ?? 'N/A', 16),
//         _multiLineText(data.stayOrderNumberAndDate ?? 'N/A', 17),
//         _buildCompleteTrackButton(i,
//             completeTrack: data.completeTrack!.toList(), name: data.name),
//       ],
//     );
//   }
//
//   Widget _buildCompleteTrackButton(int i,
//       {required List<String> completeTrack, required String name}) {
//     return Container(
//       // color: Colors.blue.withOpacity(0.2),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.deepPurple[50]!, Colors.deepPurple[100]!],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         )
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//         child: CustomButton(
//           onpress: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => CompleteTrack(
//                       list: completeTrack,
//                       name: name,
//                     )));
//           },
//           text: 'Complete Track', isLoading: false,
//
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeaderCell(String text, int i) {
//     return Container(
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.deepPurple[50]!, Colors.deepPurple[100]!],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           )
//       ),
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
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.deepPurple[50]!, Colors.deepPurple[100]!],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           )
//       ),
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
//   void getData() async {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       final asseserProvider = Provider.of<AddNewCase>(context, listen: false);
//       asseserProvider.updateSearchLoader();
//      var res= await MainCasesInformation().getAllReplicationData();
//      data = res['data'];
//       asseserProvider.updateSearchLoader();
//     });
//   }
// }


class SearchScreenMain extends StatefulWidget {
  @override
  State<SearchScreenMain> createState() => _SearchScreenMainState();
}

class _SearchScreenMainState extends State<SearchScreenMain> {
  final ScrollController horizontalController = ScrollController();
  final ScrollController verticalController = ScrollController();

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GeneralPurposeProvider>(
        builder: (context, generalProvider, child) =>
            Consumer<UserInformation>(
              builder: (context, userInfo, child) =>
                  Consumer<AddNewCase>(
                    builder: (context, provider, child) => Scaffold(
                      body: Column(
                        children: [
                          Container(
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: TextField(
                                controller: _controller,
                                decoration: const InputDecoration(
                                  labelText: 'Search by Category Subcategory name formation... to filter',
                                  hintText: 'Search by Category Subcategory name formation... to filter',
                                  border: OutlineInputBorder(),
                                ),
                                onSubmitted: (value) async {
                                  print("OnSubmit called");
                                  provider.updateSearchLoader();
                                  var res = await MainCasesInformation()
                                      .searchInReplication(category: value);
                                  generalProvider.updateSearchDate(res['data']);

                                  provider.updateSearchLoader();
                                  print("This is record on submit ${res['res']}");
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: _buldTable(),
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
      ),
    );
  }

  Widget _buldTable() {
    Offset? _startDragPosition;

    // Handle the drag update for scrolling in both directions
    void _handleDragUpdate(DragUpdateDetails details) {
      if (_startDragPosition != null) {
        horizontalController.jumpTo(
          horizontalController.offset - details.delta.dx,
        );
      }
    }

    // When user starts dragging, capture the initial position
    void _handleDragStart(DragStartDetails details) {
      _startDragPosition = details.globalPosition;
    }

    // Reset the drag position when the user stops dragging
    void _handleDragEnd(DragEndDetails details) {
      _startDragPosition = null;
    }

    return Consumer<GeneralPurposeProvider>(
      builder: (context,genPro,child)=>
      Consumer<AddNewCase>(
        builder: (context,pro,child) {
          if(pro.searchLoader){
            return Center(
              child: CircularProgressIndicator(color: Colors.black,),
            );
          }
        return  SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomButton(
                            onpress: ()async {
                              pro.updateSearchLoader();
                              var res = await MainCasesInformation().sortReplicationCases(false);
                              genPro.updateSearchDate(res['data']);
                              pro.updateSearchLoader();
                            },
                            text: "Sort Based On Date",
                            isLoading: false),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: CustomButton(
                          onpress: () async{
                            pro.updateSearchLoader();
                            var res = await MainCasesInformation().sortReplicationCases(true);
                            genPro.updateSearchDate(res['data']);
                            pro.updateSearchLoader();
                          },
                          text: "Sort Based On arrears pending",
                          isLoading: false,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onPanStart: _handleDragStart,
                  onPanUpdate: _handleDragUpdate,
                  onPanEnd: _handleDragEnd,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    controller: verticalController,
                    child: Scrollbar(
                      controller: horizontalController,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: horizontalController,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Table(
                            border: TableBorder.all(
                                width: 1.0, color: Colors.black),
                            columnWidths: const {
                              0: FixedColumnWidth(70),
                              1: FixedColumnWidth(300),
                              2: FixedColumnWidth(300),
                              3: FixedColumnWidth(180),
                              4: FixedColumnWidth(180),
                              5: FixedColumnWidth(300),
                              6: FixedColumnWidth(150),
                              7: FixedColumnWidth(120),
                              8: FixedColumnWidth(180),
                              9: FixedColumnWidth(180),
                              10: FixedColumnWidth(180),
                              11: FixedColumnWidth(180),
                              12: FixedColumnWidth(180),
                              13: FixedColumnWidth(350),
                              14: FixedColumnWidth(350),
                              15: FixedColumnWidth(250),
                              16: FixedColumnWidth(200),
                              17: FixedColumnWidth(180),
                            },
                            children: [
                              // Header Row
                              _buildHeaderRow(),
                              // Data Rows
                              ...genPro.searchData
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int index = entry.key; // Get the index
                                MainCaseModel caseData = entry
                                    .value; // Get the data
                                return _buildDataRow(caseData, index + 1);
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildHeaderCell('S No.', 1),
        _buildHeaderCell('Category', 2),
        _buildHeaderCell('Subcategory', 3),
        _buildHeaderCell('Name', 4),
        _buildHeaderCell('Formation', 5),
        _buildHeaderCell('OIO', 6),
        _buildHeaderCell('Date', 7),
        _buildHeaderCell('Day Count', 8),
        _buildHeaderCell('Duty or Arrears', 9),
        _buildHeaderCell('Penalty', 10),
        _buildHeaderCell('Amount Recovered', 11),
        _buildHeaderCell('Pre Deposit', 12),
        _buildHeaderCell('Total Arrears Pending', 13),
        _buildHeaderCell('Brief Facts', 14),
        _buildHeaderCell('Status', 15),
        _buildHeaderCell('Appeal No.', 16),
        _buildHeaderCell('Stay Order No and Date', 17),
        _buildHeaderCell('Complete Track', 18),
      ],
    );
  }

  TableRow _buildDataRow(MainCaseModel data, int serialNumber) {
    String day = _calculateDayCount(data.date).toString();
    return TableRow(
      children: [
        _multiLineText(serialNumber.toString(), 1),
        _multiLineText(data.category.toString(), 2),
        _multiLineText(data.subcategory.toString(), 3),
        _multiLineText(data.name ?? 'N/A', 4),
        _multiLineText(data.formation ?? 'N/A', 5),
        _multiLineText(data.oio ?? 'N/A', 6),
        _multiLineText(data.date.toString() ?? 'N/A', 7),
        _multiLineText(day, 8),
        _multiLineText(data.dutyOfArrear ?? 'N/A', 9),
        _multiLineText(data.penalty ?? 'N/A', 10),
        _multiLineText(data.amountRecovered ?? 'N/A', 11),
        _multiLineText(data.preDeposit ?? 'N/A', 12),
        _multiLineText(data.totalArrearPending ?? 'N/A', 13),
        _multiLineText(data.briefFact ?? 'N/A', 14),
        _multiLineText(data.status ?? 'N/A', 15),
        _multiLineText(data.apealNo ?? 'N/A', 16),
        _multiLineText(data.stayOrderNumberAndDate ?? 'N/A', 17),
        _buildCompleteTrackButton(
          completeTrack: data.completeTrack!.toList(),
          name: data.name,
        ),
      ],
    );
  }

  Widget _buildCompleteTrackButton(
      {required List<String> completeTrack, required String name}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple[50]!, Colors.deepPurple[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: CustomButton(
          onpress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CompleteTrack(
                  list: completeTrack,
                  name: name,
                ),
              ),
            );
          },
          text: 'Complete Track',
          isLoading: false,
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, int i) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple[50]!, Colors.deepPurple[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _multiLineText(String text, int i) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple[50]!, Colors.deepPurple[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(
          text,
          style: const TextStyle(fontSize: 15),
          overflow: TextOverflow.visible,
          softWrap: true,
        ),
      ),
    );
  }

  int _calculateDayCount(String dateStr) {
    List<String> parts = dateStr.split('-');

    if (parts.length != 3) {
      return 0;
    }

    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    DateTime dateTime;
    try {
      dateTime = DateTime(year, month, day);
    } catch (e) {
      return 0;
    }

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    return difference.inDays;
  }


}
