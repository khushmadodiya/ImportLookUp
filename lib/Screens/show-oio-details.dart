// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowAsserDetails extends StatefulWidget {
  const ShowAsserDetails({super.key});

  @override
  State<ShowAsserDetails> createState() => _ShowAsserDetailsState();
}

class _ShowAsserDetailsState extends State<ShowAsserDetails> {
  int num = 0;
  // String dayCount='0';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Show Area Date')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('assesers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No data available."));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Table(
                  border: TableBorder.all(width: 1.0, color: Colors.black),
                  columnWidths: const {
                    0: FixedColumnWidth(50),
                    1: FixedColumnWidth(150),
                    2: FixedColumnWidth(150),
                    3: FixedColumnWidth(150),
                    4: FixedColumnWidth(150),
                    5: FixedColumnWidth(150),
                    6: FixedColumnWidth(150),
                    7: FixedColumnWidth(150),
                    8: FixedColumnWidth(150),
                    9: FixedColumnWidth(150),
                    10: FixedColumnWidth(150),
                    11: FixedColumnWidth(300),
                    12: FixedColumnWidth(300),
                    13: FixedColumnWidth(250),
                    14: FixedColumnWidth(150),
                    15: FixedColumnWidth(150),
                  },
                  children: [
                    // Header Row
                    _buildHeaderRow(),
                    // Data Rows
                    ...snapshot.data!.docs.map((doc) {
                      num++;
                      final data = doc.data() as Map<String, dynamic>;
                      return _buildDataRow(data);
                    }).toList(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: [
        _buildHeaderCell('S No.'),
        _buildHeaderCell('Name'),
        _buildHeaderCell('Division/Range'),
        _buildHeaderCell('OIO'),
        _buildHeaderCell('Date'),
        _buildHeaderCell('Day Count'),
        _buildHeaderCell('Duty or Arrears'),
        _buildHeaderCell('Penalty'),
        _buildHeaderCell('Amount Recovered'),
        _buildHeaderCell('Pre Deposit'),
        _buildHeaderCell('Total Arrears Pending'),
        _buildHeaderCell('Brief Facts'),
        _buildHeaderCell('Status'),
        _buildHeaderCell('Appeal No.'),
        _buildHeaderCell('Stay Order No and Date'),
        _buildHeaderCell('Change Data'),
      ],
    );
  }

  TableRow _buildDataRow(Map<String, dynamic> data) {
    String day=_calculateDayCount(data['Date']).toString();
    return TableRow(
      children: [
        _multiLineText(num.toString()),
        _multiLineText(data['name'] ?? 'N/A'),
        _multiLineText(data['division_range'] ?? 'N/A'),
        _multiLineText(data['oio_and_date'] ?? 'N/A'),
        _multiLineText(data['Date'] ?? 'N/A'),
        _multiLineText(day),
        _multiLineText(data['duty_or_arrears'] ?? 'N/A'),
        _multiLineText(data['penalty'] ?? 'N/A'),
        _multiLineText(data['amount_recovered'] ?? 'N/A'),
        _multiLineText(data['pre_deposit'] ?? 'N/A'),
        _multiLineText(data['total_arrears_pending'] ?? 'N/A'),
        _multiLineText(data['brief_facts'] ?? 'N/A'),
        _multiLineText(data['status'] ?? 'N/A'),
        _multiLineText(data['appeal_no'] ?? 'N/A'),
        _multiLineText(data['stay_order_no_and_date'] ?? 'N/A'),
        _buildTransferButton(),
      ],
    );
  }

  Widget _buildTransferButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        onPressed: () {
          // Define your transfer case action here
          // For example, navigate to another screen or show a dialog
        },
        child: const Text("Transfer Case"),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _multiLineText(String text) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(
          text,
          style: const TextStyle(fontSize: 15),
          overflow: TextOverflow.visible,
          softWrap: true,
          maxLines: 5000,
        ),
      ),
    );
  }

 int _calculateDayCount(String dateStr) {
  
  List<String> parts = dateStr.split('-');
  
  if (parts.length != 3) {
    // print("hello i am dipuijjjmik ${parts.length}");
    return 0;
  }

  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);

  DateTime dateTime;
  try {
    dateTime = DateTime(year, month, day);
  } catch (e) {
    // print("hello i am");
    return 0; 
  }

  final now = DateTime.now();

  final difference = now.difference(dateTime);
  // difference.inDays.toString();
  print("hello i am dipu ${difference.inDays}");
  return difference.inDays;
}
}
