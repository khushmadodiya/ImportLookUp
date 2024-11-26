import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Backend-New/financial-year.dart';
import 'package:import_lookup/Backend-New/tar-report.dart';
import 'package:import_lookup/Model-New/main-case-model.dart';
import 'package:import_lookup/Model-New/tar-model.dart';
import 'package:import_lookup/Provider-New/add-new-cases.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
import 'package:import_lookup/Screens-New/Auth-Screens/signup-screeb.dart';
import 'package:import_lookup/Screens/dashboard.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Backend-New/authentication.dart';
import '../../excael-download-option.dart';
import '../Auth-Screens/login-screen.dart';

class RevenueTable extends StatefulWidget {
  RevenueTable({Key? key}) : super(key: key);

  @override
  State<RevenueTable> createState() => _RevenueTableState();
}

class _RevenueTableState extends State<RevenueTable> {
  final ScrollController horizontalController = ScrollController();
  final ScrollController verticalController = ScrollController();
  List<List<String>> excelData = [];
  double sliderValue = 0;
  String? month;

  List<List<String>> removeDuplicates(List<List<String>> excelData) {
    final uniqueRows = <String>{};
    final result = <List<String>>[];

    for (var row in excelData) {
      final rowString = row.join(',');
      if (uniqueRows.add(rowString)) {
        result.add(row);
      }
    }
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!isloaded) {
      getData();
      isloaded = true;
    }
  }

  @override
  void dispose() {
    horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _handleKeyEvent(KeyEvent event) {
      if (event is KeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          verticalController.animateTo(
            verticalController.offset - 100, // Adjust scroll amount as needed
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          verticalController.animateTo(
            verticalController.offset + 100, // Adjust scroll amount as needed
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          horizontalController.animateTo(
            horizontalController.offset - 300, // Adjust scroll amount as needed
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          horizontalController.animateTo(
            horizontalController.offset + 300, // Adjust scroll amount as needed
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        }
      }
    }

    String _toStringOrDefault(dynamic value, [String defaultValue = '0']) {
      return value?.toString() ?? defaultValue;
    }

    return SafeArea(

      child:   Consumer<AddNewCase>(
        builder: (context, pro, child)=>
         Scaffold(
          appBar: AppBar(
            title: Text("Tar Report",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            leading: IconButton(onPressed: (){
              showDialogg();
            }, icon: Icon(Icons.menu,size: 30,)),
            actions: [
             Container(
               height: 45,
               width: 45,
               padding: EdgeInsets.all(10),
               child: InkWell(
                 child: pro.tarLoader? CircularProgressIndicator(
                   strokeWidth: 3,
                   color: Colors.black,
                 ):Icon(Icons.refresh,size: 30,color: Colors.black,),
                 onTap:!pro.tarLoader? (){
                   pro.clearAllTarReportData();
                   getData();
                 }:null,
               ),
             )
            ],
          ),
          body: Focus(
                  autofocus: true,
                  skipTraversal: true,
                  onKeyEvent: (FocusNode node, KeyEvent event) {
                    _handleKeyEvent(event);
                    return KeyEventResult.handled;
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Scrollbar(
                            controller: horizontalController,
                            thickness: 13,
                            child: SingleChildScrollView(
                              dragStartBehavior: DragStartBehavior.down,
                              controller: horizontalController,
                              scrollDirection: Axis.horizontal,
                              child: Scrollbar(
                                controller: verticalController,
                                thickness: 10,
                                scrollbarOrientation: ScrollbarOrientation.left,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  controller: verticalController,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      if (pro.litigationCompleteData.isNotEmpty)
                                        _buildCustomTable('Litigation', [
                                          row(
                                              pro.litigationCompleteData,
                                              pro.arrearTocLitgation,
                                              0,
                                              0,
                                              'Supreme Court cases',
                                              1),
                                          row(
                                              pro.litigationCompleteData,
                                              pro.arrearTocLitgation,
                                              6,
                                              1,
                                              "High Court",
                                              2),
                                          row(
                                              pro.litigationCompleteData,
                                              pro.arrearTocLitgation,
                                              12,
                                              2,
                                              "CESTAT",
                                              3),
                                          row(
                                              pro.litigationCompleteData,
                                              pro.arrearTocLitgation,
                                              18,
                                              3,
                                              "Comm. Appeal",
                                              4),
                                          //pending to change 3,4 params
                                          row(
                                              pro.litigationCompleteData,
                                              pro.arrearTocLitgation,
                                              18,
                                              3,
                                              "Additional secretary",
                                              5),
                                        ]),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      if (pro.restrainedCompleteData.isNotEmpty)
                                        _buildCustomTable('Restrained', [
                                          row(
                                              pro.restrainedCompleteData,
                                              pro.arrearTocRestrained,
                                              0,
                                              0,
                                              "OL Cases",
                                              1),
                                          row(
                                              pro.restrainedCompleteData,
                                              pro.arrearTocRestrained,
                                              6,
                                              1,
                                              "DRT Cases",
                                              2),
                                          row(
                                              pro.restrainedCompleteData,
                                              pro.arrearTocRestrained,
                                              12,
                                              2,
                                              "BIFR Cases",
                                              3),
                                          row(
                                              pro.restrainedCompleteData,
                                              pro.arrearTocRestrained,
                                              18,
                                              3,
                                              "NCLT Cases",
                                              4),
                                        ]),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      if (pro
                                          .apealPeiodNotOverCompleteData.isNotEmpty)
                                        _buildCustomTable(
                                            "Where Appeal Period not Over", [
                                          row(
                                              pro.apealPeiodNotOverCompleteData,
                                              [
                                                pro.arrearTocWhereApealPeriodNotOver
                                              ],
                                              0,
                                              0,
                                              "Appeal Period not over",
                                              1),
                                        ]),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      if (pro.recoverableCompleteData.isNotEmpty)
                                        _buildCustomTable('Recoverable', [
                                          row(
                                              pro.recoverableCompleteData,
                                              pro.arrearTocRecoverable,
                                              0,
                                              0,
                                              'Appeal period over but no appeal field',
                                              1),
                                          row(
                                              pro.recoverableCompleteData,
                                              pro.arrearTocRecoverable,
                                              6,
                                              1,
                                              'Settlement commision cases',
                                              2),
                                          //pending to change 3,4 params
                                          row(
                                              pro.recoverableCompleteData,
                                              pro.arrearTocRecoverable,
                                              6,
                                              1,
                                              'Unit closed',
                                              3),
                                          row(
                                              pro.recoverableCompleteData,
                                              pro.arrearTocRecoverable,
                                              12,
                                              2,
                                              'Arrear under section 11',
                                              4),
                                          row(
                                              pro.recoverableCompleteData,
                                              pro.arrearTocRecoverable,
                                              18,
                                              3,
                                              'Arrear under section 142',
                                              5),
                                        ]),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      if (pro.writeOffCompleteData.isNotEmpty)
                                        _buildCustomTable('Writer off', [
                                          row(
                                              pro.writeOffCompleteData,
                                              [pro.arrearTocPendingForWirteOff],
                                              0,
                                              0,
                                              "Write Off",
                                              1),
                                        ]),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Slider to control horizontal scrolling
                    ],
                  ),
                )

          ),

      ),

    );
  }

  Widget _buildCustomTable(String title, List<TableRow> rows) {
    Offset? _startDragPosition;

    // Handle the drag update for scrolling in both directions
    void _handleDragUpdate(DragUpdateDetails details) {
      if (_startDragPosition != null) {
        // Scroll horizontally
        horizontalController.jumpTo(
          horizontalController.offset - details.delta.dx,
        );
        // Scroll vertically
        verticalController.jumpTo(
          verticalController.offset - details.delta.dy,
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

    return GestureDetector(
      onPanStart: _handleDragStart,
      onPanUpdate: _handleDragUpdate,
      onPanEnd: _handleDragEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            alignment: Alignment.topLeft,
            color: Colors.yellow[100],
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Table(
            border: TableBorder.all(),
            columnWidths: const {
              0: FixedColumnWidth(40),
              1: FixedColumnWidth(270),
              2: FixedColumnWidth(400),
              3: FixedColumnWidth(700),
              4: FixedColumnWidth(400),
              5: FixedColumnWidth(700),
              6: FixedColumnWidth(700),
              7: FixedColumnWidth(700),
              8: FixedColumnWidth(700),
              9: FixedColumnWidth(700),
              10: FixedColumnWidth(400),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.yellow[100]),
                children: [
                  _buildHeaderCell('Sl. No.'),
                  _buildHeaderCell('A. $title'),
                  _buildHeaderCellWithSubcolumns(
                      'Opening balance', ['No', 'Amt']),
                  _buildHeaderCellWithSubcolumnsSubColumn('Receipts',
                      ['No', 'Amt'], ['During the month', 'Upto the month']),
                  _buildHeaderCellWithSubcolumns('Total', ['No', 'Amt']),
                  _buildHeaderCellWithSubcolumnsSubColumn(
                      'Decided Fully/Partially in favour',
                      ['No', 'Amt'],
                      ['During the month', 'Upto the month']),
                  _buildHeaderCellWithSubcolumnsSubColumn(
                      'Decided Fully/Partially against',
                      ['No', 'Amt'],
                      ['During the month', 'Upto the month']),
                  _buildHeaderCellWithSubcolumnsSubColumn('Order for Denovo',
                      ['No', 'Amt'], ['During the month', 'Upto the month']),
                  _buildHeaderCellWithSubcolumnsSubColumn(
                      'Arrears transferred to other formations /category',
                      ['No', 'Amt'],
                      ['During the month', 'Upto the month']),
                  _buildHeaderCellWithSubcolumnsSubColumn('Arrears Realised',
                      ['No', 'Amt'], ['During the month', 'Upto the month']),
                  _buildHeaderCellWithSubcolumns(
                      'Closing Balance', ['No', 'Amt']),
                ],
              ),
              ...rows
            ],
          ),
        ],
      ),
    );
  }

  // Builds a header cell without subcolumns
  Widget _buildHeaderCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // Builds a header cell with subcolumns
  Widget _buildHeaderCellWithSubcolumns(String text, List<String> subcolumns) {
    return TableCell(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text(text,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: subcolumns.map((subCol) {
                  return TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Center(
                          child: Text(subCol, textAlign: TextAlign.center)),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCellWithSubcolumnsSubColumn(
      String text, List<String> subcolumns, List<String> subSubColumns) {
    return TableCell(
      child: Column(
        children: [
          Text(text,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: subcolumns.map((subCol) {
                  return TableCell(
                    child: Column(
                      children: [
                        Center(
                            child: Text(subCol, textAlign: TextAlign.center)),
                        Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(
                              children: subSubColumns.map((subSubCol) {
                                return TableCell(
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(subSubCol,
                                        textAlign: TextAlign.center),
                                  )),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  row(List<TarReportModel?> data, List<TocModel> data2, int index, int index2,
      String title, int no) {

    return _buildDataRow(
      no.toString(),
      title,
      data2[index2].numberOfOpeningCases.toString(),
      (data2[index2].openingBalance.toString()+ (data2[index2].unit=="Lakh"?"L":'')),
      data[index]!.noOfCasesOfTheMonth.toString(),
      data[index]!.noOfCasesUpToTheMonth.toString(),
      data[index]!.amountOfTheMonth.toString(),
      data[index]!.amountUpTotheMonth.toString(),
      (data2[index2].numberOfOpeningCases + data[index]!.noOfCasesOfTheMonth)
          .toString(),
      (data2[index2].unit=="Lakh"?  (data2[index2].openingBalance + data[index]!.amountOfTheMonth).toString(): ((data2[index2].openingBalance + (data[index]!.amountOfTheMonth/100000)).toString()+ (data2[index2].unit=="Lakh"?"L":''))),
      data[index + 1]!.noOfCasesOfTheMonth.toString(),
      data[index + 1]!.noOfCasesUpToTheMonth.toString(),
      data[index + 1]!.amountOfTheMonth.toString(),
      data[index + 1]!.amountUpTotheMonth.toString(),
      data[index + 2]!.noOfCasesOfTheMonth.toString(),
      data[index + 2]!.noOfCasesUpToTheMonth.toString(),
      data[index + 2]!.amountOfTheMonth.toString(),
      data[index + 2]!.amountUpTotheMonth.toString(),
      data[index + 3]!.noOfCasesOfTheMonth.toString(),
      data[index + 3]!.noOfCasesUpToTheMonth.toString(),
      data[index + 3]!.amountOfTheMonth.toString(),
      data[index + 3]!.amountUpTotheMonth.toString(),
      data[index + 4]!.noOfCasesOfTheMonth.toString(),
      data[index + 4]!.noOfCasesUpToTheMonth.toString(),
      data[index + 4]!.amountOfTheMonth.toString(),
      data[index + 4]!.amountUpTotheMonth.toString(),
      data[index + 5]!.noOfCasesOfTheMonth.toString(),
      data[index + 5]!.noOfCasesUpToTheMonth.toString(),
      data[index + 5]!.amountOfTheMonth.toString(),
      data[index + 5]!.amountUpTotheMonth.toString(),
      data2[index2].numberOfClosingCases.toString(),
      data2[index2].closingBalance.toString(),
    );
  }

  TableRow _buildDataRow(
      String slNo,
      String arrearsUnderLitigation,
      String openingBalanceNo,
      String openingBalanceAmt,
      String receiptsNoDuringMonth,
      String receiptsNoUptoMonth,
      String receiptsAmtDuringMonth,
      String receiptsAmtUptoTheMonth,
      String totalNo,
      String totalAmt,
      String decidedInFavorNoDuringMonth,
      String decidedInFavorNoUptoMonth,
      String decidedInFavorAmtDuringMonth,
      String decidedInFavorAmtUptoMonth,
      String decidedAgainstFavorNoDuringMonth,
      String decidedAgainstFavorNoUptoMonth,
      String decidedAgainstFavorAmtDuringMonth,
      String decidedAgainstFavorAmtUptoMonth,
      String orderOfDenovoFavorNoDuringMonth,
      String orderOfDenovoFavorNoUptoMonth,
      String orderOfDenovoFavorAmtDuringMonth,
      String orderOfDenovoFavorAmtUptoMonth,
      String transferredAnotherFormationFavorNoDuringMonth,
      String transferredAnotherFormationFavorNoUptoMonth,
      String transferredAnotherFormationFavorAmtDuringMonth,
      String transferredAnotherFormationFavorAmtUptoMonth,
      String arrearsRealisedNoofcasesOftheMonth,
      String arrearsRealisedNoofcasesuptotheMonth,
      String arrearsRealisedAmtofcasesoftheMonth,
      String arrearsRealisedAmtofcasesuptotheMonth,
      String closingBalanceNo,
      String closingBalanceAMt) {
    excelData.add([
      arrearsUnderLitigation,
      openingBalanceNo,
      openingBalanceAmt,
      receiptsNoDuringMonth,
      receiptsNoUptoMonth,
      receiptsAmtDuringMonth,
      receiptsAmtUptoTheMonth,
      totalNo,
      totalAmt,
      decidedInFavorNoDuringMonth,
      decidedInFavorNoUptoMonth,
      decidedInFavorAmtDuringMonth,
      decidedInFavorAmtUptoMonth,
      decidedAgainstFavorNoDuringMonth,
      decidedAgainstFavorNoUptoMonth,
      decidedAgainstFavorAmtDuringMonth,
      decidedAgainstFavorAmtUptoMonth,
      orderOfDenovoFavorNoDuringMonth,
      orderOfDenovoFavorNoUptoMonth,
      orderOfDenovoFavorAmtDuringMonth,
      orderOfDenovoFavorAmtUptoMonth,
      transferredAnotherFormationFavorNoDuringMonth,
      transferredAnotherFormationFavorNoUptoMonth,
      transferredAnotherFormationFavorAmtDuringMonth,
      transferredAnotherFormationFavorAmtUptoMonth,
      arrearsRealisedNoofcasesOftheMonth,
      arrearsRealisedNoofcasesuptotheMonth,
      arrearsRealisedAmtofcasesoftheMonth,
      arrearsRealisedAmtofcasesuptotheMonth,
      closingBalanceNo,
      closingBalanceAMt
    ]);
    return TableRow(
      children: [
        _buildDataCell(slNo),
        _buildDataCell(arrearsUnderLitigation),
        _buildDataCellWithSubcolumns([openingBalanceNo, openingBalanceAmt]),
        _buildDataCellWithSubcolumnsSubCol(
            [receiptsNoDuringMonth, receiptsNoUptoMonth],
            [receiptsAmtDuringMonth, receiptsAmtUptoTheMonth]),
        _buildDataCellWithSubcolumns([totalNo, totalAmt]),
        _buildDataCellWithSubcolumnsSubCol(
            [decidedInFavorNoDuringMonth, decidedInFavorNoUptoMonth],
            [decidedInFavorAmtDuringMonth, decidedInFavorAmtUptoMonth]),
        _buildDataCellWithSubcolumnsSubCol([
          decidedAgainstFavorNoDuringMonth,
          decidedAgainstFavorNoUptoMonth
        ], [
          decidedAgainstFavorAmtDuringMonth,
          decidedAgainstFavorAmtUptoMonth
        ]),
        _buildDataCellWithSubcolumnsSubCol(
            [orderOfDenovoFavorNoDuringMonth, orderOfDenovoFavorNoUptoMonth],
            [orderOfDenovoFavorAmtDuringMonth, orderOfDenovoFavorAmtUptoMonth]),
        _buildDataCellWithSubcolumnsSubCol([
          transferredAnotherFormationFavorNoDuringMonth,
          transferredAnotherFormationFavorNoUptoMonth
        ], [
          transferredAnotherFormationFavorAmtDuringMonth,
          transferredAnotherFormationFavorAmtUptoMonth
        ]),
        _buildDataCellWithSubcolumnsSubCol(
          [
            arrearsRealisedNoofcasesOftheMonth,
            arrearsRealisedNoofcasesOftheMonth
          ],
          [
            arrearsRealisedAmtofcasesoftheMonth,
            arrearsRealisedAmtofcasesuptotheMonth
          ],
        ),
        _buildDataCellWithSubcolumns([closingBalanceNo, closingBalanceAMt]),
      ],
    );
  }

  // Builds a single data cell
  Widget _buildDataCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(text, textAlign: TextAlign.center),
        ),
      ),
    );
  }

  // Builds a data cell with subcolumns
  Widget _buildDataCellWithSubcolumns(List<String> data) {
    return TableCell(
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(
            children: data.map((cell) {
              return TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(cell)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDataCellWithSubcolumnsSubCol(
      List<String> data, List<String> subcoldata) {
    return TableCell(
      child: Table(
        border: TableBorder.all(color: Colors.black),
        children: [
          TableRow(
            children: [
              Table(
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child:
                                  Text(data[0], textAlign: TextAlign.center)),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child:
                                  Text(data[1], textAlign: TextAlign.center)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Table(

                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(subcoldata[0],
                                  textAlign: TextAlign.center)),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(subcoldata[1],
                                  textAlign: TextAlign.center)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var pro = Provider.of<AddNewCase>(context, listen: false);

      GeneralPurposeProvider generalPurposeProvider =
          Provider.of<GeneralPurposeProvider>(context, listen: false);
      pro.updateTarLoader();

      List<String> data = await generalPurposeProvider.getFinancialData();
      month = data[0];
      print('data from tar');
      await pro.getAllSubcategoryTocdata();
      print('data from tarrrrr');
      await pro.tarArrearLitigation();
      await pro.tarRestrainded();
      await pro.tarAppealPeriodNotOver();
      await pro.tarRecoverable();
      await pro.tarWriteOff();
      pro.updateTarLoader();
      //  print('hellooerfe');
      //  print({
      //  'hello i am dipu loda ${pro.litigationCompleteData[0]!.amountOfTheMonth}'
      //  });
    });
  }

  void shiftData() async {
    print("hello");
    GeneralPurposeProvider pro = Provider.of<GeneralPurposeProvider>(context, listen: false);
    AddNewCase promain = Provider.of<AddNewCase>(context, listen: false);
    List<String> data = await pro.getFinancialData();
    print(data[0]);
    if (data[0] != DateFormat("MMMM").format(DateTime.now())) {
      print("the month is not equal");

      String time = DateFormat('dd-MMMM-yyyy').format(DateTime.now());
      DateFormat format = DateFormat('dd-MMMM-yyyy');

      DateTime? heelo = format.parse(time);
      DateTime? heelo1 = format.parse(data[2]);
      print(
          "here is dat -> ${time} ${heelo.difference(heelo1).inDays} -> -> }");
      Fluttertoast.showToast(msg: "It will take some time please wait then refresh",timeInSecForIosWeb: 4);
      promain.updateShiftDataLoader();
      if (heelo.difference(heelo1).inDays >= 0) {
        print("Ïnside if");
        await TarReportInformation().transferCasesUpTheMonth(
            category: "", subcategory: "", docName: "");
        await TarReportInformation()
            .transferCasesYear(category: "", subcategory: "", docName: "");
        Fluttertoast.showToast(msg: "Updated financial year",timeInSecForIosWeb: 3);
      } else {
        print('Shift uptothemonth');
        var res = await TarReportInformation().transferCasesUpTheMonth(
            category: "", subcategory: "", docName: "");
        Fluttertoast.showToast(msg: "Updated upto the month",timeInSecForIosWeb: 3);
        print("this is khush${res['res']}");
      }
      promain.updateShiftDataLoader();

    }
    else{
      Fluttertoast.showToast(msg: "Already shifted",timeInSecForIosWeb: 3);
    }
    Navigator.pop(context);
  }

  void showDialogg() {
    showDialog(context: context,
        builder: (context){
          return Dialog(
            child: Consumer<AddNewCase>(
              builder: (context, pro,child)=>
               Container(
                width: MediaQuery.of(context).size.width*.27,
                height: MediaQuery.of(context).size.height*.55,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (pro.writeOffCompleteData.isNotEmpty)
                      customButton(fun: (){
                        print(
                            'this is excel${excelData![0][0]}');
                        List<List<String>> data =
                        removeDuplicates(excelData);
                        ExcelDonwloadOption()
                            .downloadExcelForTar(
                            data, 'OIO DETAILS');
                        Navigator.pop(context);
                      }, isloader: false, title: "Download Excel"),
                    if(pro.writeOffCompleteData.isNotEmpty)
                      customButton(fun: (){
                        shiftData();
                        // Navigator.pop(context);
                      }, isloader: pro.shiftDataLoader?true:false, title: "Shift Data"),
                    customButton(fun: (){
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                    }, isloader: false, title: "Create User"),
                    customButton(fun: (){
                      Authentication().logOut();
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage()));
                    }, isloader: false, title: "Log out")
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
  Widget customButton({required VoidCallback fun ,required bool isloader, required String title }){
    return InkWell(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(
              vertical: 8.0),
          child: Container(
            height: 40,
            width: MediaQuery.of(context)
                .size
                .width >
                600
                ? 140
                : 100,
            color: Colors.amber
                .withOpacity(0.3),
            child: isloader? Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.black,
                ),
              ),
            ): Center(
                child:
                Text(title)),
          ),
        ),
        onTap: fun,
    );
  }
}


//this is my data {sctoc: Instance of 'TocModel', hctoc: Instance of 'TocModel', cestattoc: Instance of 'TocModel', commissioner applealtoc: Instance of 'TocModel', oltoc: Instance of 'TocModel', drttoc: Instance of 'TocModel', bifrtoc: Instance of 'TocModel', nclt unitstoc: Instance of 'TocModel', casestoc: Instance of 'TocModel', appeal period over but no appeal fieldtoc: Instance of 'TocModel', settlement commision casestoc: Instance of 'TocModel', arrear under section 11toc: Instance of 'TocModel', arrear under section 142toc: Instance of 'TocModel', arrears pending for write-offtoc: Instance of 'TocModel'}