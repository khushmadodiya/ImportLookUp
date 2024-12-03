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


class SearchScreenMain extends StatefulWidget {
  @override
  State<SearchScreenMain> createState() => _SearchScreenMainState();
}

class _SearchScreenMainState extends State<SearchScreenMain> {
  final ScrollController horizontalController = ScrollController();
  final ScrollController verticalController = ScrollController();

  TextEditingController _controller = TextEditingController();
  int _itemsPerPage = 5; // Number of items to load per page
   // Maximum items currently visible



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
   var genPro= Provider.of<GeneralPurposeProvider>(context);
    void _onScroll() {
      if (verticalController.position.pixels == verticalController.position.maxScrollExtent) {
          genPro.updateCurrentMax(_itemsPerPage);
      }
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollEndNotification &&
            verticalController.position.pixels >=
                verticalController.position.maxScrollExtent) {
          _onScroll();
        }
        return true;
      },
      child: Consumer<GeneralPurposeProvider>(
        builder: (context,genPro,child) {
          final searchdata = genPro.searchData;
          final visibleData = searchdata.take(genPro.currentMax).toList();
          return Consumer<AddNewCase>(
              builder: (context, pro, child) {
                if (pro.searchLoader) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.black,),
                  );
                }
                return SingleChildScrollView(
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
                                  onpress: () async {
                                    pro.updateSearchLoader();
                                    var res = await MainCasesInformation()
                                        .sortReplicationCases(false);
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
                                onpress: () async {
                                  pro.updateSearchLoader();
                                  var res = await MainCasesInformation()
                                      .sortReplicationCases(true);
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
                                    ...visibleData
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      int index = entry.key; // Get the index
                                      MainCaseModel caseData = entry
                                          .value;
                                      // if (index == visibleData.length) {
                                      //
                                      // }
                                      // return _buildDataRowWidget(visibleData[index], index + 1);
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
  TableRow _buildBlankDataRow(MainCaseModel data, int serialNumber) {
    String day = _calculateDayCount(data.date).toString();
    return TableRow(
      children: [
        _multiLineText('', 1),
        _multiLineText('', 2),
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
