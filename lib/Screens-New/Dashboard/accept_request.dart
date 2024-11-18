import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Backend/authmethos.dart';
import 'package:import_lookup/Provider-New/add-new-cases.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
import 'package:import_lookup/Provider-New/get-user-deatils.dart';
import 'package:import_lookup/Widgets/custom-button.dart';
import 'package:provider/provider.dart';
import 'package:import_lookup/excael-download-option.dart';
import 'accept-request-case-textfield.dart';

class AcceptRequestCase extends StatefulWidget {
  final title;

  const AcceptRequestCase({super.key, required this.title});

  @override
  State<AcceptRequestCase> createState() => _AcceptRequestCaseState();
}

class _AcceptRequestCaseState extends State<AcceptRequestCase> {
  ScrollController _scrollController = ScrollController();
  final ScrollController horizontalController = ScrollController();
  final ScrollController verticalController = ScrollController();
  int index = 0;
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

    return Consumer<UserInformation>(
      builder: (context, userInfo, child) =>
          Consumer<AddNewCase>(builder: (context, provider, child) {
        if (!provider.isLoading || provider.requestCaseData.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                IconButton(
                    onPressed: () {
                      AuthMethods().signOut(context);
                      setState(() {});
                    },
                    icon: Icon(Icons.logout))
              ],
            ),
            // body: Text('hell0'),
            body: Focus(
              autofocus: true,
              skipTraversal: true,
              onKeyEvent: (FocusNode node, KeyEvent event) {
                _handleKeyEvent(event);
                return KeyEventResult.handled;
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      controller: verticalController,
                      child: Scrollbar(
                        controller: horizontalController,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: horizontalController,
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
                                  15: FixedColumnWidth(200),
                                  16: FixedColumnWidth(180),
                                },
                                children: [
                                  // Header Row
                                  _buildHeaderRow(userInfo),
                                  // Data Rows
                                  for (int i = 0;
                                      i < provider.requestCaseData.length * 2;
                                      i++)
                                    if (i % 2 == 0)
                                      _buildDataRow(provider, userInfo, i ~/ 2,
                                          true) // First pass for index
                                    else
                                      _buildDataRow(provider, userInfo, i ~/ 2,
                                          false) // Second pass for the same index

                                  // _buildDataRow(provider, userInfo, i, true)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (userInfo.userType == USERTYPE[0])
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<GeneralPurposeProvider>(
                        builder: (context, generalProvider, child) => Row(
                          children: List.generate(
                              FORMATION.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: Container(
                                        color:
                                            generalProvider.selectedIndex == index
                                                ? Colors.blue
                                                : Colors.green,
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
                                        generalProvider
                                            .updateSelectedIndex(index);
                                        provider.getRequestCasesInformation(
                                            formation: FORMATION[index],
                                            isAdmin: false);
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
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }

  TableRow _buildHeaderRow(UserInformation provider) {
    return TableRow(
      children: [
        _buildHeaderCell('S No.', 1),
        _buildHeaderCell('Name', 2),
        _buildHeaderCell('Category', 3),
        _buildHeaderCell('SubCategory', 4),
        _buildHeaderCell('OIO', 5),
        _buildHeaderCell('Date', 6),
        _buildHeaderCell('Day Count', 7),
        _buildHeaderCell('Duty or Arrears', 8),
        _buildHeaderCell('Penalty', 9),
        _buildHeaderCell('Amount Recovered', 10),
        _buildHeaderCell('Pre Deposit', 11),
        _buildHeaderCell('Total Arrears Pending', 12),
        _buildHeaderCell('Brief Facts', 13),
        _buildHeaderCell('Status', 14),
        _buildHeaderCell('Appeal No.', 15),
        _buildHeaderCell('Stay Order No and Date', 16),
        if (provider.userType == USERTYPE[0])
          _buildHeaderCell('Change Data', 17),
      ],
    );
  }

  TableRow _buildDataRow(
      AddNewCase provider, UserInformation userInfo, int index, flag) {
    String day = _calculateDayCount(provider.requestCaseData[index].date ?? "")
        .toString();
    if (flag) {
      return TableRow(
        children: [
          _multiLineText('${index + 1} New', 1),
          _multiLineText(provider.requestCaseData[index].name, 2),
          _multiLineText(provider.requestCaseData[index].category, 3),
          _multiLineText(provider.requestCaseData[index].subcategory, 4),
          _multiLineText(provider.requestCaseData[index].oio, 5),
          _multiLineText(provider.requestCaseData[index].date, 6),
          _multiLineText(day, 7),
          _multiLineText(provider.requestCaseData[index].dutyOfArrear, 8),
          _multiLineText(provider.requestCaseData[index].penalty, 9),
          _multiLineText(provider.requestCaseData[index].amountRecovered, 10),
          _multiLineText(provider.requestCaseData[index].preDeposit, 11),
          _multiLineText(
              provider.requestCaseData[index].totalArrearPending, 12),
          _multiLineText(provider.requestCaseData[index].briefFact, 13),
          _multiLineText(provider.requestCaseData[index].status, 14),
          _multiLineText(provider.requestCaseData[index].apealNo, 15),
          _multiLineText(
              provider.requestCaseData[index].stayOrderNumberAndDate, 16),
          if (userInfo.userType == USERTYPE[0])
            _buildTransferButton(
                provider.requestCaseData[index].uid,
                provider.requestCaseData[index].formation,
                provider.requestCaseData[index].oldDataMode!.uid == ''),
        ],
      );
    }
    // else if(!flag && provider.requestCaseData[index].oldData!={})

    return TableRow(
      children: [
        _multiLineText('${index + 1} Old', 1),
        _multiLineText(provider.requestCaseData[index].oldDataMode!.name, 2),
        _multiLineText(
            provider.requestCaseData[index].oldDataMode!.category, 3),
        _multiLineText(
            provider.requestCaseData[index].oldDataMode!.subcategory, 4),
        _multiLineText(provider.requestCaseData[index].oldDataMode!.oio, 5),
        _multiLineText(provider.requestCaseData[index].oldDataMode!.date, 6),
        _multiLineText(day, 7),
        _multiLineText(
            provider.requestCaseData[index].oldDataMode!.dutyOfArrear, 8),
        _multiLineText(provider.requestCaseData[index].oldDataMode!.penalty, 9),
        _multiLineText(
            provider.requestCaseData[index].oldDataMode!.amountRecovered, 10),
        _multiLineText(
            provider.requestCaseData[index].oldDataMode!.preDeposit, 11),
        _multiLineText(
            provider.requestCaseData[index].oldDataMode!.totalArrearPending,
            12),
        _multiLineText(
            provider.requestCaseData[index].oldDataMode!.briefFact, 13),
        _multiLineText(provider.requestCaseData[index].oldDataMode!.status, 14),
        _multiLineText(
            provider.requestCaseData[index].oldDataMode!.apealNo, 15),
        _multiLineText(
            provider.requestCaseData[index].oldDataMode!.stayOrderNumberAndDate,
            16),
        if (userInfo.userType == USERTYPE[0])
          _buildRejectButton(provider.requestCaseData[index].uid,
              provider.requestCaseData[index].formation),
      ],
    );

  }

  Widget _buildRejectButton(String uid, String formation) {
  var  pro=  Provider.of<AddNewCase>(context,listen: false);
    print(uid);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple[50]!, Colors.deepPurple[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CustomButton(
            textcolor: Colors.red,
              color: Colors.redAccent,
              text: 'Reject Request',
              onpress: () async {
                pro.rejectRequest(uid: uid, formation: formation);
                getData();
                Fluttertoast.showToast(msg: 'Rejected',timeInSecForIosWeb: 3);
                print('rejected');
              },
              isLoading: false)),
    );
  }

  Widget _buildTransferButton(String uid, String formation, bool isnewdata) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple[50]!, Colors.deepPurple[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CustomButton(
              text: 'Accept Request',
              onpress: () async {
                final res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AcceptRequestCaseTextFields(
                              isNewRequest: isnewdata,
                              uid: uid,
                              formation: formation,
                            )));
                if (res) {
                  getData();
                }
              },
              isLoading: false)),
    );
  }

  Widget _buildHeaderCell(String text, int i) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple[50]!, Colors.deepPurple[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
      ),
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
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple[50]!, Colors.deepPurple[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
      ),
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

  void getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final asseserProvider = Provider.of<AddNewCase>(context, listen: false);
      final userinfo = Provider.of<UserInformation>(context, listen: false);

      if (userinfo.userType == USERTYPE[0]) {
        asseserProvider.updateLoader();
        var res = await asseserProvider.getRequestCasesInformation(
            formation: FORMATION[0], isAdmin: false);
        asseserProvider.updateLoader();
      } else {
        asseserProvider.updateLoader();
        var res = await asseserProvider.getRequestCasesInformation(
            formation: userinfo.formation, isAdmin: false);
        asseserProvider.updateLoader();
      }
    });
  }
}
