import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowAsserDetails extends StatefulWidget {
  const ShowAsserDetails({super.key});

  @override
  State<ShowAsserDetails> createState() => _ShowAsserDetailsState();
}

class _ShowAsserDetailsState extends State<ShowAsserDetails> {
  @override
  Widget build(BuildContext context) {
    int num=0;
    return Scaffold(
      appBar: AppBar(title: Text('Show Area Date')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('assesers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No data available."),
            );
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
                    10: FixedColumnWidth(300),
                    11: FixedColumnWidth(300),
                    12: FixedColumnWidth(250),
                    13: FixedColumnWidth(150),
                    14: FixedColumnWidth(150),
                  },
                  children: [
                    // Header Row
                    TableRow(
                      children: [
                        _buildHeaderCell('S No.'),
                        _buildHeaderCell('Name'),
                        _buildHeaderCell('Division/Range'),
                        _buildHeaderCell('OIO'),
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
                        _buildHeaderCell('Change Data'),
                      ],
                    ),
                    // Data Rows
                    ...snapshot.data!.docs.map((doc) {
                      
                      final data = doc.data() as Map<String, dynamic>;
                      num=num+1;
                      return TableRow(
                        children: [
                          _multiLineText(num.toString()),
                          _multiLineText(data['name'] ?? ''),
                          _multiLineText(data['division_range'] ?? ''),
                          _multiLineText(data['oio_and_date'] ?? ''),
                          _multiLineText(data['date'] ?? ''),
                          _multiLineText(data['duty_or_arrears'] ?? ''),
                          _multiLineText(data['penalty'] ?? ''),
                          _multiLineText(data['amount_recovered'] ?? ''),
                          _multiLineText(data['pre_deposit'] ?? ''),
                          _multiLineText(data['total_arrears_pending']??''),
                          _multiLineText(data['brief_facts'] ?? ''),
                          
                          
                          _multiLineText(data['status'] ?? ''),
                          _multiLineText(data['appeal_no'] ?? ''),
                          _multiLineText(data['stay_order_no_and_date'] ?? ''),
                          // _multiLineText('Update Data'),
                          ElevatedButton(onPressed:(){}, child:const Text("Transfer Case"))
                          // _buildHeaderCell('Change Data'),
                        ],
                      );
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
      height:70,
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
}
