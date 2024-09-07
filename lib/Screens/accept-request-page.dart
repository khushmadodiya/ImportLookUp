// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:import_lookup/Backend/AddUniversalDetails.dart';
import 'package:import_lookup/Screens/universal-update-details-page.dart';
import 'package:import_lookup/excael-download-option.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import 'AcceptRequestPage.dart';

class AcceptRequests extends StatefulWidget {
  const AcceptRequests({super.key});

  @override
  State<AcceptRequests> createState() => _AcceptRequestsState();
}

class _AcceptRequestsState extends State<AcceptRequests> {
  @override
  void initState() {
    super.initState();
    print("heeeli if i am callled ");
    final asseserProvider = Provider.of<AsseserProvider>(context, listen: false);
    asseserProvider.fetchAssesers();
    final requestedasseserProvider = Provider.of<RequestedAsseserProvider>(context, listen: false);
    getData();
    requestedasseserProvider.fetchAssesers();
     // Fetch data on widget initialization
  }

  //getdata is here
  void getData()async{
      print("i am dipuuuuu");
    final requestedasseserProvider = Provider.of<RequestedAsseserProvider>(context, listen: false);
     await requestedasseserProvider.fetchAssesers();
   print("khushwant madarchod uskii ${await requestedasseserProvider.assesers()}");
  }

  int num = 0;
  List<Map<String, dynamic>> myData = [];

  @override
  Widget build(BuildContext context) {
    // final asseserProvider = Provider.of<AsseserProvider>(context);
    final requestedasseserProvider = Provider.of<RequestedAsseserProvider>(
        context);

    if (requestedasseserProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (requestedasseserProvider.assesers == null || requestedasseserProvider
        .assesers()
        .isEmpty) {
      return Center(child: Text('No data found'));
    }

    List<TableRow> rows = [];
 for (int i = 0; i < requestedasseserProvider.assesers().length; i++) {
  final request = requestedasseserProvider.assesers()[i];

  // Print the request data for debugging
  num++;
  print("Request data is here: ${request.toString()}");

  // Separate fields that start with 'up'
  final requestUpFields = Map<String, dynamic>.fromEntries(
    request.entries.where((entry) => entry.key.startsWith('up'))
  );
  // print("heeelo re")
  // Separate fields that do not start with 'up'
  final requestNonUpFields = Map<String, dynamic>.fromEntries(
    request.entries.where((entry) => !entry.key.startsWith('up'))
  );

  // Add rows with non-'up' fields
  rows.add(_buildDataRow(requestNonUpFields, num, i, up: ''));

  // Add rows with 'up' fields
  if (requestUpFields.isNotEmpty) {
    rows.add(_buildDataRow(requestUpFields, num, i, up: 'up'));
  }

  // Increment num if needed (you can uncomment this line if num is used elsewhere)
  // num++;
}

    return Scaffold(
      appBar: AppBar(title: const Text('Accept Request')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [

              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
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
                        14: FixedColumnWidth(180),
                        15: FixedColumnWidth(180),
                      },
                      children: [
                        _buildHeaderRow(),
                        ...rows,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
      ],
    );
  }

  TableRow _buildDataRow(Map<String, dynamic> data, int i, int index, {String up = ''}) {
    String day = _calculateDayCount(data['date'] ?? '01-01-1970').toString();
    return TableRow(
      children: [
        _multiLineText((i).toString() + up, 1),
        _multiLineText(data['${up}name'] ?? 'N/A', 2),
        _multiLineText(data['${up}division_range'] ?? 'N/A', 3),
        _multiLineText(data['${up}oio'] ?? 'N/A', 4),
        _multiLineText(data['${up}date'] ?? 'N/A', 5),
        _multiLineText(day, 6),
        _multiLineText(data['${up}duty_or_arear'] ?? 'N/A', 7),
        _multiLineText(data['${up}penalty'] ?? 'N/A', 8),
        _multiLineText(data['${up}amount_recovered'] ?? 'N/A', 9),
        _multiLineText(data['${up}pre_deposit'] ?? 'N/A', 10),
        _multiLineText(data['${up}total_arrears_pending'] ?? 'N/A', 11),
        _multiLineText(data['${up}brief_facts'] ?? 'N/A', 12),
        _multiLineText(data['${up}status'] ?? 'N/A', 13),
        _multiLineText(data['${up}appeal_no'] ?? 'N/A', 14),
        _multiLineText(data['${up}stay_order_no_and_date'] ?? 'N/A', 15),
        _buildTransferButton(index,data['uid']??'N/A', title: up.isEmpty ? 'Accept' : 'Reject'),
      ],
    );
  }

  Widget _buildTransferButton(int i,String uid,{String title = 'Transfer Case'}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(15),
            color: title=="Accept"? Colors.green : Colors.redAccent
          ),

          child: InkWell(
            onTap: ()async{
              final asseserProvider = Provider.of<AsseserProvider>(context, listen: false);
              final requestedAsseserProvider = Provider.of<RequestedAsseserProvider>(context, listen: false);

              if (title == "Accept") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AcceptRequestPage(index: i ~/ 2),
                  ),
                ).then((_) {

                  asseserProvider.fetchAssesers();
                  requestedAsseserProvider.fetchAssesers();
                });
              } else {
                await AddUniversalDetails().rejectRequest(uid);
                asseserProvider.fetchAssesers(); // Trigger provider data refresh
                requestedAsseserProvider.fetchAssesers();
              }
            },
            child: Center(child: Text(title,style: TextStyle(fontSize:15,color: Colors.black,fontWeight: FontWeight.bold),)),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, int i) {
    return Container(
      color: i % 2 == 0 ? Colors.blue.withOpacity(0.2) : Colors.blue.withOpacity(0.3),
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
      color: i % 2 == 0 ? Colors.blue.withOpacity(0.2) : Colors.blue.withOpacity(0.3),
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
