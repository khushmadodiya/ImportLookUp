import 'package:flutter/material.dart';
import 'package:import_lookup/Screens/complete-track.dart';
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
  var asseserProvider;
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
          ||brief_facts.toLowerCase().contains(_searchQuery.toLowerCase());

    }).toList();

    List<TableRow> rows = [];
    for (int i = 0; i < filteredAssesers.length; i++) {
      final asseser = filteredAssesers[i];
      // print("here data of complere ${asseser['complete_track'].length}");
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
        setState(() {
          
        });
       
    }
    void sortBasedofToatlArrearsPending(){
      filteredAssesers=asseserProvider.assesers();
      filteredAssesers.sort((a,b){
        if(int.parse(a['total_arrears_pending'])>int.parse(b['total_arrears_pending'])){
          return 1;
        }
        return 0;
      }
        );
        setState(() {
          
        });
       
    }



    return Scaffold(
      appBar: AppBar(title: const Text('Search Cases')),
      body: Column(
        children: [
          Row(children: [
            ElevatedButton(onPressed:(){
            sortBasedofDate();
          }, child:const Text("Sort Based On Date")),
           ElevatedButton(onPressed:(){
            sortBasedofToatlArrearsPending();
          }, child:const Text("Sort Based On arrears pending")),
          ],),
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
                      2:FixedColumnWidth(300),
                      3:FixedColumnWidth(180),
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
                      16: FixedColumnWidth(180),
                      17: FixedColumnWidth(180),
                      18: FixedColumnWidth(180),

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
        _buildHeaderCell('category', 2),
        _buildHeaderCell('subcategory', 3),
        _buildHeaderCell('Name', 4),
        _buildHeaderCell('Division/Range', 5),
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
        _buildHeaderCell('Change Data', 18),
        _buildHeaderCell('Complete Track', 18),
      ],
    );
  }

  TableRow _buildDataRow(Map<String, dynamic> data, int i) {
    String day = _calculateDayCount(data['date']).toString();
    return TableRow(
      children: [
        _multiLineText((i + 1).toString(), 1),
        _multiLineText(data['category'], 2),
        _multiLineText(data['subcategory'], 3),
        _multiLineText(data['name'] ?? 'N/A', 4),
        _multiLineText(data['division_range'] ?? 'N/A', 5),
        _multiLineText(data['oio'] ?? 'N/A', 6),
        _multiLineText(data['date'] ?? 'N/A', 7),
        _multiLineText(day, 8),
        _multiLineText(data['duty_or_arear'] ?? 'N/A', 9),
        _multiLineText(data['penalty'] ?? 'N/A', 10),
        _multiLineText(data['amount_recovered'] ?? 'N/A', 11),
        _multiLineText(data['pre_deposit'] ?? 'N/A', 12),
        _multiLineText(data['total_arrears_pending'] ?? 'N/A', 13),
        _multiLineText(data['brief_facts'] ?? 'N/A', 14),
        _multiLineText(data['status'] ?? 'N/A', 15),
        _multiLineText(data['appeal_no'] ?? 'N/A', 16),
        _multiLineText(data['stay_order_no_and_date'] ?? 'N/A', 17),
        _buildTransferButton(i,'Transfer Case', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateUniversalDetails(index: i)));
          },
          ),
          // ElevatedButton(onPressed:(){
          //   // print("dipu is here ${data['complete_track'].length}");
          // }, child:Text('Dipu'))
        _buildTransferButton(i,'Complete Track',
         () {
          // print("divuansh ${data['complete_track'].lenght}");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CompleteTrackScreen(complete_track:data['complete_track'],)));
          },
          // complete_track:data['complete_track'],
        ),
      ],
    );
  }

  Widget _buildTransferButton(int i,String title,VoidCallback ontap,{List<String>complete_track=const []}) {
    return Container(
      color: Colors.blue.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: ElevatedButton(
          onPressed:ontap,
          child: Text(title),
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
