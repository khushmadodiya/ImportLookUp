import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Backend/authmethos.dart';
import 'package:import_lookup/Model-New/main-case-model.dart';
import 'package:import_lookup/Provider-New/add-new-cases.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
import 'package:import_lookup/Provider-New/get-user-deatils.dart';
import 'package:import_lookup/Screens-New/Dashboard/update-case-detail.dart';
import 'package:import_lookup/Widgets/custom-button.dart';
import 'package:pagination_flutter/pagination.dart';
import 'package:provider/provider.dart';
import 'package:import_lookup/Backend/fetchAsseserData.dart';
import 'package:import_lookup/Screens/universal-update-details-page.dart';
import 'package:import_lookup/excael-download-option.dart';

import '../../provider/provider.dart';
import 'accept-request-case-textfield.dart';



class AcceptRequestCase extends StatefulWidget {
  final title;

  const AcceptRequestCase({super.key, required this.title});

  @override
  State<AcceptRequestCase> createState() => _AcceptRequestCaseState();
}

class _AcceptRequestCaseState extends State<AcceptRequestCase> {
  ScrollController _scrollController = ScrollController();
  int index=0;
  List<Map<String, dynamic>> myData = [];

  @override
  void initState() {
    super.initState();
    // Fetch data on widget initialization
    print('AceptRequested');
    getData();
  }

  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInformation>(
      builder: (context,userInfo,child)=>
       Consumer<AddNewCase>(
        builder: (context, provider, child) {
          if (!provider.isLoading || provider.requestCaseData.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
                actions: [
                  IconButton(onPressed: () {
                    AuthMethods().signOut(context);
                    setState(() {

                    });
                  }, icon: Icon(Icons.logout))
                ],
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
                        child: const Center(child: Text("Download Excel")),
                      ),
                    ),
                    onTap: () {
                      ExcelDonwloadOption().exportToExcel(myData, 'OIO DETAILS');
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Listener(
                        onPointerSignal: (pointerSignal) {
                          if (pointerSignal is PointerScrollEvent) {
                            // Horizontal scroll based on the mouse wheel's delta
                            _scrollController.jumpTo(
                              _scrollController.offset + pointerSignal.scrollDelta
                                  .dy, // Use dy for vertical mouse wheel mapped to horizontal scroll
                            );
                          }
                        },
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Card(
                              elevation: 12,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Table(
                                border: TableBorder.all(
                                    width: 1.0, color: Colors.black),
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
                                  _buildHeaderRow(userInfo),
                                  // Data Rows
          for (int i = 0; i < provider.requestCaseData.length*2 ; i++)

          if (i % 2 == 0)
          _buildDataRow(provider,userInfo ,i~/2, true) // First pass for index
           else
          _buildDataRow(provider,userInfo, i ~/ 2, false)  // Second pass for the same index

             // _buildDataRow(provider, userInfo, i, true)

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
               if(userInfo.userType==USERTYPE[0])  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Consumer<GeneralPurposeProvider>(
                      builder: (context, generalProvider, child) =>
                          Row(
                            children: List.generate(
                                FORMATION.length,
                                    (index) =>
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        child: Container(
                                          color: generalProvider.selectedIndex ==
                                              index ? Colors.blue : Colors.green,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              FORMATION[index],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          provider.updateLoader();
                                          generalProvider.updateSelectedIndex(index);
                                          provider.getRequestCasesInformation(formation: FORMATION[index] , isAdmin: false);
                                          provider.updateLoader();

                                        },
                                      ),
                                    )),
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),

            );
          }

            return Scaffold(body: Center(child: CircularProgressIndicator(),),);

        }
      ),
    );



  }

  TableRow _buildHeaderRow(UserInformation provider) {
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
       if(provider.userType==USERTYPE[0]) _buildHeaderCell('Change Data', 16),
      ],
    );
  }

  TableRow _buildDataRow(AddNewCase provider,UserInformation userInfo, int index,flag) {
    String day = _calculateDayCount(provider.requestCaseData[index].date??"").toString();
    if(flag) {
      return TableRow(
        children: [
          _multiLineText('${index + 1}', 1),
          _multiLineText(provider.requestCaseData[index].name, 2),
          _multiLineText(provider.requestCaseData[index].formation, 3),
          _multiLineText(provider.requestCaseData[index].oio, 4),
          _multiLineText(provider.requestCaseData[index].date, 5),
          _multiLineText(day, 6),
          _multiLineText(provider.requestCaseData[index].dutyOfArrear, 7),
          _multiLineText(provider.requestCaseData[index].penalty, 8),
          _multiLineText(provider.requestCaseData[index].amountRecovered, 9),
          _multiLineText(provider.requestCaseData[index].preDeposit, 10),
          _multiLineText(
              provider.requestCaseData[index].totalArrearPending, 11),
          _multiLineText(provider.requestCaseData[index].briefFact, 12),
          _multiLineText(provider.requestCaseData[index].status, 13),
          _multiLineText(provider.requestCaseData[index].apealNo, 14),
          _multiLineText(
              provider.requestCaseData[index].stayOrderNumberAndDate, 15),
         if(userInfo.userType ==USERTYPE[0]) _buildTransferButton(provider.requestCaseData[index].uid,
              provider.requestCaseData[index].formation),
        ],
      );
    }
    // else if(!flag && provider.requestCaseData[index].oldData!={})

    return TableRow(
    children: [
    _multiLineText('${index+1}', 1),
    _multiLineText(provider.requestCaseData[index]?.oldData?['name'] ?? '', 2),
    _multiLineText(provider.requestCaseData[index]?.oldData?['formation'] ?? '', 3),
    _multiLineText(provider.requestCaseData[index]?.oldData?['oio'] ?? '', 4),
    _multiLineText(provider.requestCaseData[index]?.oldData?['date'] ?? '', 5),
    _multiLineText(day ?? '', 6),
    _multiLineText(provider.requestCaseData[index]?.oldData?['dutyOfArrear'] ?? '', 7),
    _multiLineText(provider.requestCaseData[index]?.oldData?['penalty'] ?? '', 8),
    _multiLineText(provider.requestCaseData[index]?.oldData?['amountRecovered'] ?? '', 9),
    _multiLineText(provider.requestCaseData[index]?.oldData?['preDeposit'] ?? '', 10),
    _multiLineText(provider.requestCaseData[index]?.oldData?['totalArrearPending'] ?? '', 11),
    _multiLineText(provider.requestCaseData[index]?.oldData?['briefFact'] ?? '', 12),
    _multiLineText(provider.requestCaseData[index]?.oldData?['status'] ?? '', 13),
    _multiLineText(provider.requestCaseData[index]?.oldData?['apealNo'] ?? '', 14),
    _multiLineText(provider.requestCaseData[index]?.oldData?['stayOrderNumberAndDate'] ?? '', 15),
    if (userInfo?.userType == USERTYPE[0])
    _buildRejectButton(provider.requestCaseData[index]?.uid ?? '', provider.requestCaseData[index]?.formation ?? ''),
    ],
    );
    // else
    // return TableRow(
    //   children: [
    //     _multiLineText('${index + 1}', 1),
    //     _multiLineText('', 2),
    //     _multiLineText('', 3),
    //     _multiLineText('', 4),
    //     _multiLineText('', 5),
    //     _multiLineText(day, 6),
    //     _multiLineText('', 7),
    //     _multiLineText('', 8),
    //     _multiLineText('', 9),
    //     _multiLineText('', 10),
    //     _multiLineText(
    //        '', 11),
    //     _multiLineText('', 12),
    //     _multiLineText('', 13),
    //     _multiLineText('', 14),
    //     _multiLineText('', 15),
    //   ]
    // );

  }
  Widget _buildRejectButton(String uid,String formation) {
    print(uid);
    return Container(
      color: Colors.blue.withOpacity(0.2),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:
          CustomButton(
              color: Colors.redAccent,
              text: 'Reject Request', onpress: ()async{
            // Naprint('object $formation');

          }, isLoading: false)
      ),
    );
  }

  Widget _buildTransferButton(String uid,String formation) {
    print(uid);
    return Container(
      color: Colors.blue.withOpacity(0.2),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:
          CustomButton(text: 'Accept Request', onpress: ()async{
            print('object $formation');
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AcceptRequestCaseTextFields(uid: uid, formation: formation)));
          }, isLoading: false)
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

  void getData()async {

    final asseserProvider = Provider.of<AddNewCase>(context, listen: false);
    final userinfo = Provider.of<UserInformation>(context,listen: false);

    if(userinfo.userType==USERTYPE[0]){
      asseserProvider.updateLoader();
     var res= await asseserProvider.getRequestCasesInformation(formation: FORMATION[0], isAdmin: false);
      asseserProvider.updateLoader();

    }
    else{
      asseserProvider.updateLoader();
      var res= await asseserProvider.getRequestCasesInformation(formation: userinfo.formation, isAdmin: false);
      asseserProvider.updateLoader();
    }
  }
}
