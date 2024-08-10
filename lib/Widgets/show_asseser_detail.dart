import 'package:flutter/material.dart';

class ShowAsseser extends StatefulWidget {
  final Map<String, dynamic> snap;
  final int index;

  const ShowAsseser({super.key, required this.snap, required this.index});

  @override
  State<ShowAsseser> createState() => _ShowAsseserState();
}

class _ShowAsseserState extends State<ShowAsseser> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,  // Make the whole page scrollable horizontally
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              // Display the header row only if the index is 0
              widget.index == 0
                  ? Table(
                columnWidths: {
                  0: FixedColumnWidth(100.0),
                  1: FixedColumnWidth(100.0),
                  2: FixedColumnWidth(100.0),
                  3: FixedColumnWidth(100.0),
                  4: FixedColumnWidth(100.0),
                  5: FixedColumnWidth(100.0),
                  6: FixedColumnWidth(100.0),
                  7: FixedColumnWidth(100.0),
                  8: FixedColumnWidth(100.0),
                  9: FixedColumnWidth(300.0), // Brief Facts column
                  10: FixedColumnWidth(300.0), // Status column
                  11: FixedColumnWidth(100.0),
                  12: FixedColumnWidth(100.0),
                },
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(
                    children: [
                      _buildHeaderCell('Name'),
                      _buildHeaderCell('Division/Range'),
                      _buildHeaderCell('OIO and Date'),
                      _buildHeaderCell('Date'),
                      _buildHeaderCell('Duty or Arrears'),
                      _buildHeaderCell('Penalty'),
                      _buildHeaderCell('Amount Recovered'),
                      _buildHeaderCell('Pre Deposit'),
                      _buildHeaderCell('Total Arrears Pending'),
                      _buildHeaderCell('Brief Facts'),
                      _buildHeaderCell('Status'),
                      _buildHeaderCell('Appeal No.'),
                      _buildHeaderCell('Stay Order No and Date'),
                    ],
                  ),
                ],
              )
                  : SizedBox(height: 0),
              // Divider(thickness: 1, color: Colors.white, height: 0),
              // Display the data row
              Table(
                columnWidths: {
                  0: FixedColumnWidth(100.0),
                  1: FixedColumnWidth(100.0),
                  2: FixedColumnWidth(100.0),
                  3: FixedColumnWidth(100.0),
                  4: FixedColumnWidth(100.0),
                  5: FixedColumnWidth(100.0),
                  6: FixedColumnWidth(100.0),
                  7: FixedColumnWidth(100.0),
                  8: FixedColumnWidth(100.0),
                  9: FixedColumnWidth(300.0), // Brief Facts column
                  10: FixedColumnWidth(300.0), // Status column
                  11: FixedColumnWidth(100.0),
                  12: FixedColumnWidth(100.0),
                },
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(
                    children: [
                      _buildDataCell(widget.snap['name']),
                      _buildDataCell(widget.snap['division_range']),
                      _buildDataCell(widget.snap['OIO_and_date']),
                      _buildDataCell(widget.snap['Date']),
                      _buildDataCell(widget.snap['duty_or_arear']),
                      _buildDataCell(widget.snap['penalty']),
                      _buildDataCell(widget.snap['amount_recovered']),
                      _buildDataCell(widget.snap['pre_deposit']),
                      _buildDataCell(widget.snap['total_arrears_pending']),
                      _buildDataCell(widget.snap['brief_facts']),
                      _buildDataCell(widget.snap['status']),
                      _buildDataCell(widget.snap['appeal_no']),
                      _buildDataCell(widget.snap['stay_order_no_and_date']),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 15),
        overflow: TextOverflow.visible, // Allow text to wrap
      ),
    );
  }
}
