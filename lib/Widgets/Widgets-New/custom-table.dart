import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Backend/authmethos.dart';
import 'package:import_lookup/Model-New/main-case-model.dart';
import 'package:import_lookup/Provider-New/add-new-cases.dart';
import 'package:import_lookup/Provider-New/get-user-deatils.dart';
import 'package:import_lookup/Screens-New/Auth-Screens/login-screen.dart';
import 'package:import_lookup/Screens-New/Dashboard/DisposalScreen.dart';
import 'package:import_lookup/Screens-New/Dashboard/update-case-detail.dart';
import 'package:import_lookup/Widgets/custom-button.dart';
import 'package:provider/provider.dart';
import 'package:import_lookup/excael-download-option.dart';
import '../../Provider-New/general-pusrpose.dart';
import 'custom-pagging.dart';

class CustomTable extends StatefulWidget {
  final title;
  final String subcategory;
  final String category;
  const CustomTable(
      {super.key,
      required this.title,
      required this.subcategory,
      required this.category});

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  ScrollController _horigentalController = ScrollController();
  ScrollController _verticalController = ScrollController();
  List<Map<String, dynamic>> myData = [];


  @override
  void initState() {
    super.initState();
    // Fetch data on widget initialization
    getData();
  }
  @override
  @override
  void didUpdateWidget(CustomTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      if (oldWidget.title != widget.title) {
        final asseserProvider = Provider.of<AddNewCase>(context, listen: false);
        final userinfo = Provider.of<UserInformation>(context, listen: false);
        final pageindex =
        Provider.of<GeneralPurposeProvider>(context, listen: false);
        pageindex.updateSelectedIndex(0);
        print('updated to 0 khushz');
        asseserProvider.updateLoader();
        if (userinfo.userType == USERTYPE[0]) {
          await asseserProvider.getMainCasesInformation(
              formation: FORMATION[0], isAdmin: false);
        } else {
          await asseserProvider.getMainCasesInformation(
              formation: userinfo.formation, isAdmin: false);
        }
        asseserProvider.updateLoader();
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    return Consumer<AddNewCase>(
      builder: (context, provider, child) => Consumer<UserInformation>(
        builder: (context, userInfo, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          // body: Text('hell0'),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: 150,
                    color: Colors.amber.withOpacity(0.3),
                    child: provider.excelLoader?Center(child: Container(height:20,width:20,child: CircularProgressIndicator(strokeWidth: 3,))): Center(child: Text("Download Excel")),
                  ),
                ),
                onTap: () async{
                  final userinfo = Provider.of<UserInformation>(context, listen: false);
                  provider.updateExcelLoader();
                  if (userinfo.userType == USERTYPE[0]) {
                    await provider.getMainCasesInformation(
                        formation: FORMATION[0], isAdmin: true);
                  } else {
                    await provider.getMainCasesInformation(
                        formation: userinfo.formation, isAdmin: false);
                  }
                  provider.updateExcelLoader();
                  ExcelDonwloadOption().exportToExcel(provider.mainCaseData, 'OIO DETAILS');
                },
              ),
              Expanded(
                child: _buildTable(),
              ),

              if (userInfo.userType == USERTYPE[0]) CutomPagging()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTable() {
    Offset? _startDragPosition;

    // Handle the drag update for scrolling in both directions
    void _handleDragUpdate(DragUpdateDetails details) {
      if (_startDragPosition != null) {
        // Scroll horizontally
        _horigentalController.jumpTo(
          _horigentalController.offset - details.delta.dx,
        );
        // Scroll vertically
        _verticalController.jumpTo(
          _verticalController.offset - details.delta.dy,
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

    void _handleKeyEvent(KeyEvent event) {
      if (event is KeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          _verticalController.animateTo(
            _verticalController.offset - 100, // Adjust scroll amount as needed
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          _verticalController.animateTo(
            _verticalController.offset + 100, // Adjust scroll amount as needed
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          _horigentalController.animateTo(
              _horigentalController.offset - 300, // Adjust scroll amount as needed
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,);
        } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          _horigentalController.animateTo(
            _horigentalController.offset + 300, // Adjust scroll amount as needed
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,);        }
      }
    }
    return Consumer<GeneralPurposeProvider>(
      builder: (context,genPro,child)=>
       Consumer<UserInformation>(
        builder: (context,userInfo,child)=>
       Consumer<AddNewCase>(builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          int rowNumber = 1;
          return GestureDetector(
            onPanStart: _handleDragStart,
            onPanUpdate: _handleDragUpdate,
            onPanEnd: _handleDragEnd,
            child: Focus(
              autofocus: true,
              skipTraversal: true,
              onKeyEvent: (FocusNode node, KeyEvent event) {
                _handleKeyEvent(event);
                return KeyEventResult.handled;
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: _verticalController,
                child: Scrollbar(

                  // thickness: 15,
                  controller: _horigentalController,
                  child: Listener(
                    onPointerSignal: (pointerSignal) {
                      if (pointerSignal is PointerScrollEvent) {
                        _verticalController.jumpTo(
                          _verticalController.offset + pointerSignal.scrollDelta.dx,
                        );
                      }
                    },
                    child: SingleChildScrollView(
                      controller: _horigentalController,
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Card(
                          elevation: 12,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Table(
                            border: TableBorder.all(width: 1.0, color: Colors.black),
                            columnWidths: const {
                              0: FixedColumnWidth(70),
                              1: FixedColumnWidth(300),
                              2: FixedColumnWidth(180),
                              3: FixedColumnWidth(300),
                              4: FixedColumnWidth(150),
                              5: FixedColumnWidth(120),
                              6: FixedColumnWidth(180),
                              7: FixedColumnWidth(180),
                              8: FixedColumnWidth(180),
                              9: FixedColumnWidth(180),
                              10: FixedColumnWidth(180),
                              11: FixedColumnWidth(350),
                              12: FixedColumnWidth(350),
                              13: FixedColumnWidth(250),
                              14: FixedColumnWidth(200),
                              15: FixedColumnWidth(120),
                              16: FixedColumnWidth(120),
                            },
                            children: [
                              if(provider.mainCaseData.isNotEmpty)_buildHeaderRow(),

                              if(provider.mainCaseData.isNotEmpty)
                              for (int i = 0; i < provider.mainCaseData.length; i++)
                                if (provider.mainCaseData[i].subcategory ==
                                    widget.subcategory &&
                                    provider.mainCaseData[i].category ==
                                        widget.category)
                                  _buildDataRow(provider, i,rowNumber++),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }


  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildHeaderCell('S No.', 1),
        _buildHeaderCell('Name', 2),
        _buildHeaderCell('Division/Range', 3),
        _buildHeaderCell('OIO', 4),
        _buildHeaderCell('Date', 5),
        _buildHeaderCell('Day Count', 6),
        _buildHeaderCell('Duty or Arrears', 7),
        _buildHeaderCell('Penalty', 8),
        _buildHeaderCell('Amount Recovered', 9),
        _buildHeaderCell('Pre Deposit', 10),
        _buildHeaderCell('Total Arrears Pending', 11),
        _buildHeaderCell('Brief Facts', 12),
        _buildHeaderCell('Status', 13),
        _buildHeaderCell('Appeal No.', 14),
        _buildHeaderCell('Stay Order No and Date', 15),
        _buildHeaderCell('Change Data', 16),
        _buildHeaderCell('Disposal', 17),
      ],
    );
  }

  TableRow _buildDataRow(AddNewCase provider, int index, int rownumber) {
    String day =
        _calculateDayCount(provider.mainCaseData[index].date).toString();
    return TableRow(
      children: [
        _multiLineText('${rownumber}', 1),
        _multiLineText(provider.mainCaseData[index].name, 2),
        _multiLineText(provider.mainCaseData[index].formation, 3),
        _multiLineText(provider.mainCaseData[index].oio, 4),
        _multiLineText(provider.mainCaseData[index].date, 5),
        _multiLineText(day, 6),
        _multiLineText(provider.mainCaseData[index].dutyOfArrear, 7),
        _multiLineText(provider.mainCaseData[index].penalty, 8),
        _multiLineText(provider.mainCaseData[index].amountRecovered, 9),
        _multiLineText(provider.mainCaseData[index].preDeposit, 10),
        _multiLineText(provider.mainCaseData[index].totalArrearPending, 11),
        _multiLineText(provider.mainCaseData[index].briefFact, 12),
        _multiLineText(provider.mainCaseData[index].status, 13),
        _multiLineText(provider.mainCaseData[index].apealNo, 14),
        _multiLineText(provider.mainCaseData[index].stayOrderNumberAndDate, 15),
        _buildTransferButton(provider.mainCaseData[index].uid, provider.mainCaseData[index].formation),
        _buildDisposalButtton(provider.mainCaseData[index]),
      ],
    );
  }
  // TableRow _buildDataRowWithAllCases(AddNewCase provider, int index) {
  //   String day =
  //       _calculateDayCount(provider.allMainCaseData[index].date).toString();
  //   return TableRow(
  //     children: [
  //       _multiLineText('${index + 1}', 1),
  //       _multiLineText(provider.allMainCaseData[index].name, 2),
  //       _multiLineText(provider.allMainCaseData[index].formation, 3),
  //       _multiLineText(provider.allMainCaseData[index].oio, 4),
  //       _multiLineText(provider.allMainCaseData[index].date, 5),
  //       _multiLineText(day, 6),
  //       _multiLineText(provider.allMainCaseData[index].dutyOfArrear, 7),
  //       _multiLineText(provider.allMainCaseData[index].penalty, 8),
  //       _multiLineText(provider.allMainCaseData[index].amountRecovered, 9),
  //       _multiLineText(provider.allMainCaseData[index].preDeposit, 10),
  //       _multiLineText(provider.allMainCaseData[index].totalArrearPending, 11),
  //       _multiLineText(provider.allMainCaseData[index].briefFact, 12),
  //       _multiLineText(provider.allMainCaseData[index].status, 13),
  //       _multiLineText(provider.allMainCaseData[index].apealNo, 14),
  //       _multiLineText(provider.allMainCaseData[index].stayOrderNumberAndDate, 15),
  //       _buildTransferButton(provider.allMainCaseData[index].uid, provider.allMainCaseData[index].formation),
  //     ],
  //   );
  // }

  Widget _buildDisposalButtton(MainCaseModel model){
    return Container(
      color: Colors.blue.withOpacity(0.2),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CustomButton(
              text: 'Disposal',
              onpress: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DisposalScreen( model: model,)));
              },
              isLoading: false)
      ),
    );
  }



  Widget _buildTransferButton(String uid, String formation) {
    print(uid);
    return Container(
      color: Colors.blue.withOpacity(0.2),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CustomButton(
              text: 'Transfer',
              onpress: () async {
                final res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UpdateCaseDetail(uid: uid, formation: formation)));
                if (res) {
                  getData();
                }
              },
              isLoading: false)
          ),
    );
  }

  Widget _buildHeaderCell(String text, int i) {
    return Container(
      color: i % 2 == 0
          ? Colors.blue.withOpacity(0.2)
          : Colors.blue.withOpacity(0.3),
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
      color: i % 2 == 0
          ? Colors.blue.withOpacity(0.2)
          : Colors.blue.withOpacity(0.3),
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

  void getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final asseserProvider = Provider.of<AddNewCase>(context, listen: false);
      final userinfo = Provider.of<UserInformation>(context, listen: false);
      final pageindex =
          Provider.of<GeneralPurposeProvider>(context, listen: false);
      pageindex.updateSelectedIndex(0);
      print('updated to 0');
      asseserProvider.updateLoader();
      if (userinfo.userType == USERTYPE[0]) {
        await asseserProvider.getMainCasesInformation(
            formation: FORMATION[0], isAdmin: false);
      } else {
        await asseserProvider.getMainCasesInformation(
            formation: userinfo.formation, isAdmin: false);
      }
      asseserProvider.updateLoader();

    });
  }
}
