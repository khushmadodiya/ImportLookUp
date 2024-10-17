import 'package:flutter/material.dart';

class RevenueTable extends StatelessWidget {
  const RevenueTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.yellow[100],
              child: Text(
                'Table- A: CASES OF ARREARS OF REVENUE PENDING LITIGATION ( LEGAL FORUM)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Table(
              border: TableBorder.all(),
              columnWidths: {
                0: FixedColumnWidth(40),
                1: FixedColumnWidth(100),
                2: FixedColumnWidth(100),
                3: FixedColumnWidth(200),
                4: FixedColumnWidth(100),
                5: FixedColumnWidth(400),
                6: FixedColumnWidth(200),
                7: FixedColumnWidth(200),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.yellow[100]),
                  children: [
                    _buildHeaderCell('Sl. No.'),
                    _buildHeaderCell('A. Arrears under litigation'),
                    _buildHeaderCell('Opening balance', subColumns: ['No', 'Amt']),
                    _buildHeaderCell('Receipts', subColumns: ['No', 'Amt'], subSubColumns: ['During the month', 'Upto the month']),
                    _buildHeaderCell('Total', subColumns: ['No', 'Amt']),
                    _buildHeaderCell('Disposal', subColumns: ['Decided Fully/ Partially in favour of the', 'Decided Fully/ Partially against the', 'Order for Denovo'],
                        subSubColumns: ['No', 'Amt'],
                        subSubSubColumns: ['During the month', 'Upto the month']),
                    _buildHeaderCell('Order for Denovo', subColumns: ['No', 'Amt'], subSubColumns: ['During the month', 'Upto the month']),
                    _buildHeaderCell('Arrears transferred to other formation', subColumns: ['No', 'Amt']),
                  ],
                ),
                _buildDataRow('1', 'Supreme Court cases', '6', '93505.46', '0', '0', '0.00', '0.00', '6', '93505.46',
                    '0', '0', '0.00', '0.00', '0', '0', '0.00', '0.00', '0', '0', '0.00', '0.00', '0', '1', '0.00'),
                _buildDataRow('2', 'High Court cases', '20', '9098.68', '0', '0', '0.00', '0.00', '20', '9098.68',
                    '0', '0', '0.00', '0.00', '0', '0', '0.00', '0.00', '0', '0', '0.00', '0.00', '0', '3', '0.00'),
                _buildDataRow('3', 'CESTAT cases', '77', '28138.37', '1', '2', '1641.00', '1732.67', '78', '29779.37',
                    '0', '0', '0.00', '0.00', '0', '0', '0.00', '0.00', '0', '0', '0.00', '0.00', '0', '8', '0.00'),
                _buildDataRow('4', 'Comm. (A) cases', '27', '2893.16', '0', '1', '0.00', '18.08', '27', '2893.16',
                    '0', '4', '0.00', '2159.50', '0', '0', '0.00', '0.00', '0', '0', '0.00', '0.00', '0', '1', '0.00'),
                _buildDataRow('5', 'JS (RA)', '0', '0.00', '1', '1', '245.00', '245.00', '1', '245.00',
                    '0', '0', '0.00', '0.00', '0', '0', '0.00', '0.00', '0', '0', '0.00', '0.00', '0', '0', '0.00'),
                _buildDataRow('6', 'Total (A1 to A5)', '130', '133635.67', '2', '4', '1886.00', '1995.75', '132', '135521.67',
                    '0', '4', '0.00', '2159.50', '0', '0', '0.00', '0.00', '0', '0', '0.00', '0.00', '0', '13', '0.00'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, {List<String>? subColumns, List<String>? subSubColumns, List<String>? subSubSubColumns}) {
    return TableCell(
      child: Column(
        children: [
          Text(text, textAlign: TextAlign.center),
          if (subColumns != null)
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: subColumns.map((subCol) => TableCell(
                    child: Center(child: Text(subCol, textAlign: TextAlign.center)),
                  )).toList(),
                ),
              ],
            ),
          if (subSubColumns != null)
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: subSubColumns.map((subSubCol) => TableCell(
                    child: Center(child: Text(subSubCol, textAlign: TextAlign.center)),
                  )).toList(),
                ),
              ],
            ),
          if (subSubSubColumns != null)
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: subSubSubColumns.map((subSubSubCol) => TableCell(
                    child: Center(child: Text(subSubSubCol, textAlign: TextAlign.center)),
                  )).toList(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  TableRow _buildDataRow(String slNo, String arrearsUnderLitigation,
      String openingBalanceNo, String openingBalanceAmt,
      String receiptsNo1, String receiptsNo2, String receiptsAmt1, String receiptsAmt2,
      String totalNo, String totalAmt,
      String decidedInFavorNo1, String decidedInFavorNo2, String decidedInFavorAmt1, String decidedInFavorAmt2,
      String decidedAgainstNo1, String decidedAgainstNo2, String decidedAgainstAmt1, String decidedAgainstAmt2,
      String orderForDenovoNo1, String orderForDenovoNo2, String orderForDenovoAmt1, String orderForDenovoAmt2,
      String arrearsTransferredNo, String arrearsTransferredNo2, String arrearsTransferredAmt) {
    return TableRow(
      children: [
        _buildDataCell(slNo),
        _buildDataCell(arrearsUnderLitigation),
        _buildNestedDataCell([openingBalanceNo, openingBalanceAmt]),
        _buildNestedDataCell([receiptsNo1, receiptsNo2, receiptsAmt1, receiptsAmt2], isDoubleNested: true),
        _buildNestedDataCell([totalNo, totalAmt]),
        _buildTripleNestedDataCell([
          [decidedInFavorNo1, decidedInFavorNo2, decidedInFavorAmt1, decidedInFavorAmt2],
          [decidedAgainstNo1, decidedAgainstNo2, decidedAgainstAmt1, decidedAgainstAmt2],
          [orderForDenovoNo1, orderForDenovoNo2, orderForDenovoAmt1, orderForDenovoAmt2],
        ]),
        _buildNestedDataCell([orderForDenovoNo1, orderForDenovoNo2, orderForDenovoAmt1, orderForDenovoAmt2], isDoubleNested: true),
        _buildNestedDataCell([arrearsTransferredNo, arrearsTransferredNo2, arrearsTransferredAmt]),
      ],
    );
  }

  Widget _buildDataCell(String text) {
    return TableCell(
      child: Center(child: Text(text, textAlign: TextAlign.center)),
    );
  }

  Widget _buildNestedDataCell(List<String> data, {bool isDoubleNested = false}) {
    if (isDoubleNested) {
      return TableCell(
        child: Table(
          border: TableBorder.all(),
          children: [
            TableRow(
              children: [
                TableCell(child: Center(child: Text(data[0]))),
                TableCell(child: Center(child: Text(data[1]))),
              ],
            ),
            TableRow(
              children: [
                TableCell(child: Center(child: Text(data[2]))),
                TableCell(child: Center(child: Text(data[3]))),
              ],
            ),
          ],
        ),
      );
    } else {
      return TableCell(
        child: Table(
          border: TableBorder.all(),
          children: [
            TableRow(
              children: data.map((cell) => TableCell(
                child: Center(child: Text(cell)),
              )).toList(),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTripleNestedDataCell(List<List<String>> data) {
    return TableCell(
      child: Table(
        border: TableBorder.all(),
        children: data.map((subData) => TableRow(
          children: [
            TableCell(
              child: Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text(subData[0]))),
                      TableCell(child: Center(child: Text(subData[1]))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text(subData[2]))),
                      TableCell(child: Center(child: Text(subData[3]))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )).toList(),
      ),
    );
  }
}