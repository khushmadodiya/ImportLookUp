// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class RevenueTable extends StatefulWidget {
//   RevenueTable({Key? key}) : super(key: key);
//
//   @override
//   State<RevenueTable> createState() => _RevenueTableState();
// }
//
// class _RevenueTableState extends State<RevenueTable> {
//   final ScrollController horizontalController = ScrollController();
//   double sliderValue = 0;
//
//   @override
//   void dispose() {
//     horizontalController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SingleChildScrollView(
//               controller: horizontalController,
//               scrollDirection: Axis.horizontal,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(8),
//                       color: Colors.yellow[100],
//                       child: Text(
//                         'Table- A: CASES OF ARREARS OF REVENUE PENDING LITIGATION ( LEGAL FORUM)',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Table(
//                       border: TableBorder.all(),
//                       columnWidths: {
//                         0: FixedColumnWidth(40),
//                         1: FixedColumnWidth(160),
//                         2: FixedColumnWidth(160),
//                         3: FixedColumnWidth(300),
//                         4: FixedColumnWidth(160),
//                         5: FixedColumnWidth(300),
//                         6: FixedColumnWidth(300),
//                         7: FixedColumnWidth(300),
//                         8: FixedColumnWidth(300),
//                         9: FixedColumnWidth(300),
//                         10: FixedColumnWidth(300),
//                       },
//                       children: [
//                         // Header row with subcolumns
//                         TableRow(
//                           decoration: BoxDecoration(color: Colors.yellow[100]),
//                           children: [
//                             _buildHeaderCell('Sl. No.'),
//                             _buildHeaderCell('A. Arrears under litigation'),
//                             _buildHeaderCellWithSubcolumns('Opening balance', ['No', 'Amt']),
//                             _buildHeaderCellWithSubcolumnsSubColumn('Receipts', ['No', 'Amt'],['During the month', 'Upto the month']),
//                             _buildHeaderCellWithSubcolumns('Total', ['No', 'Amt']),
//                             _buildHeaderCellWithSubcolumnsSubColumn('Decided Fully/Partially in favour', ['No', 'Amt'], ['During the month', 'Upto the month']),
//                             _buildHeaderCellWithSubcolumnsSubColumn('Decided Fully/Partially against', ['No', 'Amt'], ['During the month', 'Upto the month']),
//                             _buildHeaderCellWithSubcolumnsSubColumn('Order for Denovo', ['No', 'Amt'], ['During the month', 'Upto the month']),
//                             _buildHeaderCellWithSubcolumnsSubColumn('Arrears transferred to other formations /category', ['No', 'Amt'], ['During the month', 'Upto the month']),
//                             _buildHeaderCellWithSubcolumns('Arrears Realised', ['No', 'Amt'],['During the month', 'Upto the month']),
//                             _buildHeaderCellWithSubcolumns('Closing Balance', ['No', 'Amt'],['During the month', 'Upto the month']),
//
//                           ],
//                         ),
//                         // Data rows
//                         // _buildDataRow('1', 'Supreme Court cases', '6', '93505.46', '0', '0', '6', '93505.46', '0', '0', '0'),
//                         // _buildDataRow('2', 'High Court cases', '20', '9098.68', '0', '0', '20', '9098.68', '0', '0', '0'),
//                         // _buildDataRow('3', 'CESTAT cases', '77', '28138.37', '1', '2', '78', '29779.37', '0', '0', '0'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         // Slider to control horizontal scrolling
//         Padding(
//           padding:  EdgeInsets.zero,
//           child: Slider(
//             activeColor: Colors.grey[400],
//             value: sliderValue,
//             onChanged: (val) {
//               setState(() {
//                 sliderValue = val;
//                 // Convert slider value (0 to 1) to a scroll position
//                 double maxScrollExtent = horizontalController.position.maxScrollExtent;
//                 horizontalController.jumpTo(val * maxScrollExtent);
//
//               });
//             },
//           ),
//         )
//       ],
//     );
//   }
//
//   // Builds a header cell without subcolumns
//   Widget _buildHeaderCell(String text) {
//     return TableCell(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: Text(
//             text,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Builds a header cell with subcolumns
//   Widget _buildHeaderCellWithSubcolumns(String text, List<String> subcolumns, [List<String>? subSubColumns]) {
//     return TableCell(
//       child: Column(
//         children: [
//           Text(text, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
//           Table(
//             border: TableBorder.all(),
//             children: [
//               TableRow(
//                 children: subcolumns
//                     .map(
//                       (subCol) => TableCell(
//                     child: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Center(child: Text(subCol, textAlign: TextAlign.center)),
//                     ),
//                   ),
//                 )
//                     .toList(),
//               ),
//               if (subSubColumns != null)
//                 TableRow(
//                   children: subSubColumns
//                       .map(
//                         (subSubCol) => TableCell(
//                       child: Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Center(child: Text(subSubCol, textAlign: TextAlign.center)),
//                       ),
//                     ),
//                   )
//                       .toList(),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//   Widget _buildHeaderCellWithSubcolumnsSubColumn(String text, List<String> subcolumns, List<String>? subSubColumns) {
//     return TableCell(
//       child: Column(
//         children: [
//           Text(text, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
//           Table(
//
//             border: TableBorder.all(),
//             children: [
//               TableRow(
//                 children: subcolumns
//                     .map(
//                       (subCol) => TableCell(
//                     child: Column(
//                       children: [
//                         Center(child: Text(subCol, textAlign: TextAlign.center)),
//                         Table(
//                           border: TableBorder.all(),
//                           children: [
//                             TableRow(children: subSubColumns!.map((val) => TableCell(child: Text(val,textAlign: TextAlign.center,style: TextStyle(fontSize: 13),))).toList()),
//                              // TableRow(children: subSubColumns!.map((val) => TableCell(child: Text(val))).toList()),
//                         ],
//                         )
//                       ],
//                     )
//                   ),
//                 )
//                     .toList(),
//               ),
//
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Builds a data row with consistent columns
//   TableRow _buildDataRow(
//       String slNo,
//       String arrearsUnderLitigation,
//       String openingBalanceNo,
//       String openingBalanceAmt,
//       String receiptsDuringMonth,
//       String receiptsUptoMonth,
//       String totalNo,
//       String totalAmt,
//       String decidedInFavor,
//       String decidedAgainst,
//       String orderForDenovo) {
//     return TableRow(
//       children: [
//         _buildDataCell(slNo),
//         _buildDataCell(arrearsUnderLitigation),
//         _buildDataCellWithSubcolumns([openingBalanceNo, openingBalanceAmt]),
//         _buildDataCellWithSubcolumns([receiptsDuringMonth, receiptsUptoMonth]),
//         _buildDataCellWithSubcolumns([totalNo, totalAmt]),
//         _buildDataCellWithSubcolumns([decidedInFavor, decidedAgainst]),
//         _buildDataCellWithSubcolumns([decidedInFavor, decidedAgainst]),
//         _buildDataCellWithSubcolumns([orderForDenovo, '0']),
//       ],
//     );
//   }
//
//   // Builds a single data cell
//   Widget _buildDataCell(String text) {
//     return TableCell(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: Text(text, textAlign: TextAlign.center),
//         ),
//       ),
//     );
//   }
//
//   // Builds a data cell with subcolumns
//   Widget _buildDataCellWithSubcolumns(List<String> data) {
//     return TableCell(
//       child: Table(
//         border: TableBorder.all(),
//         children: [
//           TableRow(
//             children: data
//                 .map(
//                   (cell) => TableCell(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(child: Text(cell)),
//                 ),
//               ),
//             )
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RevenueTable extends StatefulWidget {
  RevenueTable({Key? key}) : super(key: key);

  @override
  State<RevenueTable> createState() => _RevenueTableState();
}

class _RevenueTableState extends State<RevenueTable> {
  final ScrollController horizontalController = ScrollController();
  double sliderValue = 0;

  @override
  void dispose() {
    horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              controller: horizontalController,
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.yellow[100],
                      child: const Text(
                        'Table- A: CASES OF ARREARS OF REVENUE PENDING LITIGATION (LEGAL FORUM)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Table(
                      border: TableBorder.all(),
                      columnWidths: {
                        0: const FixedColumnWidth(40),
                        1: const FixedColumnWidth(160),
                        2: const FixedColumnWidth(160),
                        3: const FixedColumnWidth(300),
                        4: const FixedColumnWidth(160),
                        5: const FixedColumnWidth(300),
                        6: const FixedColumnWidth(300),
                        7: const FixedColumnWidth(300),
                        8: const FixedColumnWidth(300),
                        9: const FixedColumnWidth(300),
                        10: const FixedColumnWidth(300),
                      },
                      children: [
                        // Header row with subcolumns
                        TableRow(
                          decoration: BoxDecoration(color: Colors.yellow[100]),
                          children: [
                            _buildHeaderCell('Sl. No.'),
                            _buildHeaderCell('A. Arrears under litigation'),
                            _buildHeaderCellWithSubcolumns(
                                'Opening balance', ['No', 'Amt']),
                            _buildHeaderCellWithSubcolumnsSubColumn(
                                'Receipts',
                                ['No', 'Amt'],
                                ['During the month', 'Upto the month']),
                            _buildHeaderCellWithSubcolumns(
                                'Total', ['No', 'Amt']),
                            _buildHeaderCellWithSubcolumnsSubColumn(
                                'Decided Fully/Partially in favour',
                                ['No', 'Amt'],
                                ['During the month', 'Upto the month']),
                            _buildHeaderCellWithSubcolumnsSubColumn(
                                'Decided Fully/Partially against',
                                ['No', 'Amt'],
                                ['During the month', 'Upto the month']),
                            _buildHeaderCellWithSubcolumnsSubColumn(
                                'Order for Denovo',
                                ['No', 'Amt'],
                                ['During the month', 'Upto the month']),
                            _buildHeaderCellWithSubcolumnsSubColumn(
                                'Arrears transferred to other formations /category',
                                ['No', 'Amt'],
                                ['During the month', 'Upto the month']),
                            _buildHeaderCellWithSubcolumns(
                                'Arrears Realised', ['No', 'Amt']),
                            _buildHeaderCellWithSubcolumns(
                                'Closing Balance', ['No', 'Amt']),
                          ],
                        ),
                        // Data rows
                        _buildDataRow(
                            '1',
                            'Supreme Court cases',
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            '8',
                            '9',
                            '10',
                            '11',
                            '12',
                            '13',
                            '14',
                            '15',
                            '16',
                            '17',
                            '18',
                            '19',
                            '20',
                            '21',
                            '22',
                            '23',
                            '24',
                            '25',
                            '26',
                            '27',
                            '28'), // _buildDataRow('2', 'High Court cases', '20', '9098.68', '0', '0', '20', '9098.68', '0', '0', '0','0'),
                        _buildDataRow(
                            '2',
                            'High Court',
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            '8',
                            '9',
                            '10',
                            '11',
                            '12',
                            '13',
                            '14',
                            '15',
                            '16',
                            '17',
                            '18',
                            '19',
                            '20',
                            '21',
                            '22',
                            '23',
                            '24',
                            '25',
                            '26',
                            '27',
                            '28'), // _buildDataRow('2', 'High Court cases', '20', '9098.68', '0', '0', '20', '9098.68', '0', '0', '0','0'),
                        _buildDataRow(
                            '3',
                            'CESTAT',
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            '8',
                            '9',
                            '10',
                            '11',
                            '12',
                            '13',
                            '14',
                            '15',
                            '16',
                            '17',
                            '18',
                            '19',
                            '20',
                            '21',
                            '22',
                            '23',
                            '24',
                            '25',
                            '26',
                            '27',
                            '28') // _buildDataRow('2', 'High Court cases', '20', '9098.68', '0', '0', '20', '9098.68', '0', '0', '0','0'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Slider to control horizontal scrolling
        Padding(
          padding: EdgeInsets.zero,
          child: Slider(
            activeColor: Colors.grey[400],
            value: sliderValue,
            onChanged: (val) {
              setState(() {
                sliderValue = val;
                // Convert slider value (0 to 1) to a scroll position
                double maxScrollExtent =
                    horizontalController.position.maxScrollExtent;
                horizontalController.jumpTo(val * maxScrollExtent);
              });
            },
          ),
        )
      ],
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
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
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
                                      child: Text(subSubCol,
                                          textAlign: TextAlign.center)),
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
      String arrearsRealisedNo,
      String arrearsRealisedAmt,
      String closingBalanceNo,
      String closingBalanceAMt) {
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
        _buildDataCellWithSubcolumns([arrearsRealisedNo, arrearsRealisedAmt]),
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
}
