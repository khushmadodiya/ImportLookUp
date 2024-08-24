import 'package:flutter/material.dart';
import 'package:import_lookup/Screens/universal-update-details-page.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = ''; // Add a variable to store the search query

  @override
  void initState() {
    super.initState();
    final asseserProvider = Provider.of<AsseserProvider>(context, listen: false);
    asseserProvider.fetchAssesers(); // Fetch data on widget initialization
  }

  int num = 0;

  @override
  Widget build(BuildContext context) {
    final asseserProvider = Provider.of<AsseserProvider>(context);

    if (asseserProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (asseserProvider.assesers == null || asseserProvider.assesers()!.isEmpty) {
      return Center(child: Text('No data found'));
    }
    // for(int i=0;i<asseserProvider.assesers().length;i++){
      
      // filteredAssesers=list.s
    // }

    // Filter the list based on the search query
    var filteredAssesers = asseserProvider.assesers().where((asseser) {
      final status = asseser['status']??'';
      final category = asseser['category'] ?? '';
      final subcategory = asseser['subcategory'] ?? '';
      final name = asseser['name'] ?? '';
      final brief_facts = asseser['brief_facts'] ?? '';

      return category.toLowerCase().contains(_searchQuery.toLowerCase())
          ||subcategory.toLowerCase().contains(_searchQuery.toLowerCase())
          ||name.toLowerCase().contains(_searchQuery.toLowerCase())
          ||status.toLowerCase().contains(_searchQuery.toLowerCase())
          ||brief_facts.toLowerCase().contains(_searchQuery.toLowerCase())
      ;
    }).toList();

    List<TableRow> rows = [];
    for (int i = 0; i < filteredAssesers.length; i++) {
      final asseser = filteredAssesers[i];
        num++;
        rows.add(_buildDataRow(asseser, i));

    }
    void sortBasedofDate(){
      filteredAssesers=asseserProvider.assesers();
      filteredAssesers.sort((a,b)=> DateTime(
        int.parse(a['date'].toString().substring(6,10)),
        int.parse(a['date'].toString().substring(3,5)),
        int.parse(a['date'].toString().substring(0,2))
        ).compareTo(DateTime(
          int.parse(b['date'].toString().substring(6,10)),
        int.parse(b['date'].toString().substring(3,5)),
        int.parse(b['date'].toString().substring(0,2))
        )
        ));
        for(int i=0;i<filteredAssesers.length;i++){
          print("sorted data ${filteredAssesers.toString()}");
        }
        setState(() {
          
        });
    }


    return Scaffold(
      appBar: AppBar(title: const Text('Search Cases')),
      body: Column(
        children: [
          ElevatedButton(onPressed:(){
            sortBasedofDate();
          }, child:const Text("Sort Based On Date")),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by Category',
                hintText: 'Enter "Supreme Court" to filter...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value; // Update the search query when user types
                });
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
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
                      // Header Row
                      _buildHeaderRow(),
                      ...rows
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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

  TableRow _buildDataRow(Map<String, dynamic> data, int i) {
    String day = _calculateDayCount(data['date']).toString();
    return TableRow(
      children: [
        _multiLineText((i + 1).toString(), 1),
        _multiLineText(data['name'] ?? 'N/A', 2),
        _multiLineText(data['division_range'] ?? 'N/A', 3),
        _multiLineText(data['oio'] ?? 'N/A', 4),
        _multiLineText(data['date'] ?? 'N/A', 5),
        _multiLineText(day, 6),
        _multiLineText(data['duty_or_arear'] ?? 'N/A', 7),
        _multiLineText(data['penalty'] ?? 'N/A', 8),
        _multiLineText(data['amount_recovered'] ?? 'N/A', 9),
        _multiLineText(data['pre_deposit'] ?? 'N/A', 10),
        _multiLineText(data['total_arrears_pending'] ?? 'N/A', 11),
        _multiLineText(data['brief_facts'] ?? 'N/A', 12),
        _multiLineText(data['status'] ?? 'N/A', 13),
        _multiLineText(data['appeal_no'] ?? 'N/A', 14),
        _multiLineText(data['stay_order_no_and_date'] ?? 'N/A', 15),
        _buildTransferButton(i),
      ],
    );
  }

  Widget _buildTransferButton(int i) {
    return Container(
      color: Colors.blue.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateUniversalDetails(index: i)));
          },
          child: const Text("Transfer Case"),
        ),
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
}
