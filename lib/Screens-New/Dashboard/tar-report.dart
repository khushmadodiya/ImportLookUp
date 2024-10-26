import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Provider-New/add-new-cases.dart';
import 'package:provider/provider.dart';

import '../../Backend/authmethos.dart';
import '../../excael-download-option.dart';
import '../Auth-Screens/login-screen.dart';

class RevenueTable extends StatefulWidget {
  RevenueTable({Key? key}) : super(key: key);

  @override
  State<RevenueTable> createState() => _RevenueTableState();
}

class _RevenueTableState extends State<RevenueTable> {
  final ScrollController horizontalController = ScrollController();
  final ScrollController verticalController = ScrollController();
  double sliderValue = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(!isloaded){
      getData();
      isloaded = true;
    }

  }

  @override
  void dispose() {
    horizontalController.dispose();
    super.dispose();
  }

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

    return Consumer<AddNewCase>(
      builder: (context, pro, child) {
        if(pro.litigationCompleteData.isEmpty) {
          const Center(child: CircularProgressIndicator(),);
        }
          return Focus(
        autofocus: true,
        skipTraversal: true,
        onKeyEvent: (FocusNode node, KeyEvent event) {
          _handleKeyEvent(event);
          return KeyEventResult.handled;
        },
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Scrollbar(
                  controller: horizontalController,
                  thickness: 13,
                  child: SingleChildScrollView(
                    dragStartBehavior: DragStartBehavior.down,
                    controller: horizontalController,
                    scrollDirection: Axis.horizontal,
                    child: Scrollbar(
                      controller: verticalController,
                      thickness: 10,
                      scrollbarOrientation: ScrollbarOrientation.left,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        controller: verticalController,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              // if(pro.writeOffCompleteData.isNotEmpty)
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width*.9,
                                  child: Row(

                                    children: [
                                      InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Container(
                                            height: 40,
                                            width: 150,
                                            color: Colors.amber.withOpacity(0.3),
                                            child: const Center(child: Text("Download Excel")),
                                          ),
                                        ),
                                        onTap: () {
                                          // ExcelDonwloadOption().downloadExcelForTar(pro.mainCaseData, 'OIO DETAILS');
                                        },
                                      ),

                                      InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 40,
                                            width: 150,
                                            color: Colors.amber.withOpacity(0.3),
                                            child: const Center(child: Text("Refresh")),
                                          ),
                                        ),
                                        onTap: () {
                                           getData();
                                        },
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            AuthMethods().signOut(context);
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => LoginPage()));
                                          },
                                          icon: Icon(Icons.logout))

                                    ],
                                  ),
                                ),
                              if(pro.litigationCompleteData.isNotEmpty)
                                _buildCustomTable('Litigation', [
                                  _buildDataRow(
                                      '1',
                                      'Supreme Court cases',
                                      '1',
                                      '2',
                                      pro.litigationCompleteData[0]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.litigationCompleteData[0]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.litigationCompleteData[0]!.amountOfTheMonth.toString() ?? '5',
                                      pro.litigationCompleteData[0]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.litigationCompleteData[1]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.litigationCompleteData[1]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.litigationCompleteData[1]!.amountOfTheMonth.toString() ?? '11',
                                      pro.litigationCompleteData[1]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.litigationCompleteData[2]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.litigationCompleteData[2]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.litigationCompleteData[2]!.amountOfTheMonth.toString() ?? '15',
                                      pro.litigationCompleteData[2]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.litigationCompleteData[3]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.litigationCompleteData[3]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.litigationCompleteData[3]!.amountOfTheMonth.toString() ?? '19',
                                      pro.litigationCompleteData[3]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.litigationCompleteData[4]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.litigationCompleteData[4]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.litigationCompleteData[4]!.amountOfTheMonth.toString() ?? '23',
                                      pro.litigationCompleteData[4]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.litigationCompleteData[5]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.litigationCompleteData[5]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.litigationCompleteData[5]!.amountOfTheMonth.toString() ?? '27',
                                      pro.litigationCompleteData[5]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),
                                  _buildDataRow(
                                      '2',
                                      'High Court',
                                      '1',
                                      '2',
                                      pro.litigationCompleteData[6]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.litigationCompleteData[6]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.litigationCompleteData[6]!.amountOfTheMonth.toString() ?? '5',
                                      pro.litigationCompleteData[6]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.litigationCompleteData[7]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.litigationCompleteData[7]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.litigationCompleteData[7]!.amountOfTheMonth.toString() ?? '11',
                                      pro.litigationCompleteData[7]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.litigationCompleteData[8]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.litigationCompleteData[8]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.litigationCompleteData[8]!.amountOfTheMonth.toString() ?? '15',
                                      pro.litigationCompleteData[8]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.litigationCompleteData[9]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.litigationCompleteData[9]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.litigationCompleteData[9]!.amountOfTheMonth.toString() ?? '19',
                                      pro.litigationCompleteData[9]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.litigationCompleteData[10]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.litigationCompleteData[10]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.litigationCompleteData[10]!.amountOfTheMonth.toString() ?? '23',
                                      pro.litigationCompleteData[10]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.litigationCompleteData[11]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.litigationCompleteData[11]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.litigationCompleteData[11]!.amountOfTheMonth.toString() ?? '27',
                                      pro.litigationCompleteData[11]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),
                                  _buildDataRow(
                                      '3',
                                      'CESTAT',
                                      '1',
                                      '2',
                                      pro.litigationCompleteData[12]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.litigationCompleteData[12]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.litigationCompleteData[12]!.amountOfTheMonth.toString() ?? '5',
                                      pro.litigationCompleteData[21]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.litigationCompleteData[13]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.litigationCompleteData[13]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.litigationCompleteData[13]!.amountOfTheMonth.toString() ?? '11',
                                      pro.litigationCompleteData[13]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.litigationCompleteData[14]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.litigationCompleteData[14]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.litigationCompleteData[14]!.amountOfTheMonth.toString() ?? '15',
                                      pro.litigationCompleteData[14]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.litigationCompleteData[15]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.litigationCompleteData[15]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.litigationCompleteData[15]!.amountOfTheMonth.toString() ?? '19',
                                      pro.litigationCompleteData[15]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.litigationCompleteData[16]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.litigationCompleteData[16]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.litigationCompleteData[16]!.amountOfTheMonth.toString() ?? '23',
                                      pro.litigationCompleteData[16]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.litigationCompleteData[17]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.litigationCompleteData[17]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.litigationCompleteData[17]!.amountOfTheMonth.toString() ?? '27',
                                      pro.litigationCompleteData[17]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),
                                  _buildDataRow(
                                      '4',
                                      'Comm. Appeal',
                                      '1',
                                      '2',
                                      pro.litigationCompleteData[18]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.litigationCompleteData[18]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.litigationCompleteData[18]!.amountOfTheMonth.toString() ?? '5',
                                      pro.litigationCompleteData[18]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.litigationCompleteData[19]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.litigationCompleteData[19]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.litigationCompleteData[19]!.amountOfTheMonth.toString() ?? '11',
                                      pro.litigationCompleteData[19]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.litigationCompleteData[20]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.litigationCompleteData[20]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.litigationCompleteData[20]!.amountOfTheMonth.toString() ?? '15',
                                      pro.litigationCompleteData[20]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.litigationCompleteData[21]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.litigationCompleteData[21]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.litigationCompleteData[21]!.amountOfTheMonth.toString() ?? '19',
                                      pro.litigationCompleteData[21]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.litigationCompleteData[22]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.litigationCompleteData[22]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.litigationCompleteData[22]!.amountOfTheMonth.toString() ?? '23',
                                      pro.litigationCompleteData[22]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.litigationCompleteData[23]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.litigationCompleteData[23]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.litigationCompleteData[23]!.amountOfTheMonth.toString() ?? '27',
                                      pro.litigationCompleteData[23]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),                            ]),
                              SizedBox(height: 15,),
                              if(pro.restrainedCompleteData.isNotEmpty)
                                _buildCustomTable('Restrained', [
                                  _buildDataRow(
                                      '1',
                                      'OL cases',
                                      '1',
                                      '2',
                                      pro.restrainedCompleteData[0]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.restrainedCompleteData[0]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.restrainedCompleteData[0]!.amountOfTheMonth.toString() ?? '5',
                                      pro.restrainedCompleteData[0]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.restrainedCompleteData[1]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.restrainedCompleteData[1]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.restrainedCompleteData[1]!.amountOfTheMonth.toString() ?? '11',
                                      pro.restrainedCompleteData[1]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.restrainedCompleteData[2]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.restrainedCompleteData[2]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.restrainedCompleteData[2]!.amountOfTheMonth.toString() ?? '15',
                                      pro.restrainedCompleteData[2]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.restrainedCompleteData[3]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.restrainedCompleteData[3]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.restrainedCompleteData[3]!.amountOfTheMonth.toString() ?? '19',
                                      pro.restrainedCompleteData[3]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.restrainedCompleteData[4]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.restrainedCompleteData[4]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.restrainedCompleteData[4]!.amountOfTheMonth.toString() ?? '23',
                                      pro.restrainedCompleteData[4]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.restrainedCompleteData[5]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.restrainedCompleteData[5]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.restrainedCompleteData[5]!.amountOfTheMonth.toString() ?? '27',
                                      pro.restrainedCompleteData[5]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),
                                  _buildDataRow(
                                      '2',
                                      'DRT Cases',
                                      '1',
                                      '2',
                                      pro.restrainedCompleteData[6]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.restrainedCompleteData[6]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.restrainedCompleteData[6]!.amountOfTheMonth.toString() ?? '5',
                                      pro.restrainedCompleteData[6]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.restrainedCompleteData[7]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.restrainedCompleteData[7]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.restrainedCompleteData[7]!.amountOfTheMonth.toString() ?? '11',
                                      pro.restrainedCompleteData[7]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.restrainedCompleteData[8]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.restrainedCompleteData[8]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.restrainedCompleteData[8]!.amountOfTheMonth.toString() ?? '15',
                                      pro.restrainedCompleteData[8]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.restrainedCompleteData[9]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.restrainedCompleteData[9]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.restrainedCompleteData[9]!.amountOfTheMonth.toString() ?? '19',
                                      pro.restrainedCompleteData[9]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.restrainedCompleteData[10]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.restrainedCompleteData[10]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.restrainedCompleteData[10]!.amountOfTheMonth.toString() ?? '23',
                                      pro.restrainedCompleteData[10]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.restrainedCompleteData[11]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.restrainedCompleteData[11]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.restrainedCompleteData[11]!.amountOfTheMonth.toString() ?? '27',
                                      pro.restrainedCompleteData[11]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),
                                  _buildDataRow(
                                      '3',
                                      'CESTAT',
                                      '1',
                                      '2',
                                      pro.restrainedCompleteData[12]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.restrainedCompleteData[12]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.restrainedCompleteData[12]!.amountOfTheMonth.toString() ?? '5',
                                      pro.restrainedCompleteData[12]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.restrainedCompleteData[13]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.restrainedCompleteData[13]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.restrainedCompleteData[13]!.amountOfTheMonth.toString() ?? '11',
                                      pro.restrainedCompleteData[13]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.restrainedCompleteData[14]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.restrainedCompleteData[14]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.restrainedCompleteData[14]!.amountOfTheMonth.toString() ?? '15',
                                      pro.restrainedCompleteData[14]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.restrainedCompleteData[15]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.restrainedCompleteData[15]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.restrainedCompleteData[15]!.amountOfTheMonth.toString() ?? '19',
                                      pro.restrainedCompleteData[15]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.restrainedCompleteData[16]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.restrainedCompleteData[16]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.restrainedCompleteData[16]!.amountOfTheMonth.toString() ?? '23',
                                      pro.restrainedCompleteData[16]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.restrainedCompleteData[17]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.restrainedCompleteData[17]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.restrainedCompleteData[17]!.amountOfTheMonth.toString() ?? '27',
                                      pro.restrainedCompleteData[17]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),
                                  _buildDataRow(
                                      '4',
                                      'NCLT units',
                                      '1',
                                      '2',
                                      pro.restrainedCompleteData[18]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.restrainedCompleteData[18]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.restrainedCompleteData[18]!.amountOfTheMonth.toString() ?? '5',
                                      pro.restrainedCompleteData[18]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.restrainedCompleteData[19]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.restrainedCompleteData[19]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.restrainedCompleteData[19]!.amountOfTheMonth.toString() ?? '11',
                                      pro.restrainedCompleteData[19]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.restrainedCompleteData[20]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.restrainedCompleteData[20]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.restrainedCompleteData[20]!.amountOfTheMonth.toString() ?? '15',
                                      pro.restrainedCompleteData[20]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.restrainedCompleteData[21]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.restrainedCompleteData[21]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.restrainedCompleteData[21]!.amountOfTheMonth.toString() ?? '19',
                                      pro.restrainedCompleteData[21]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.restrainedCompleteData[22]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.restrainedCompleteData[22]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.restrainedCompleteData[22]!.amountOfTheMonth.toString() ?? '23',
                                      pro.restrainedCompleteData[22]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.restrainedCompleteData[23]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.restrainedCompleteData[23]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.restrainedCompleteData[23]!.amountOfTheMonth.toString() ?? '27',
                                      pro.restrainedCompleteData[23]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),                            ]),
                              SizedBox(height: 15,),
                              if(pro.apealPeiodNotOverCompleteData.isNotEmpty)
                                _buildCustomTable("Where Appeal Period not Over", [
                                  _buildDataRow(
                                      '4',
                                      'Appeal Period not over',
                                      '1',
                                      '2',
                                      pro.apealPeiodNotOverCompleteData[0]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.apealPeiodNotOverCompleteData[0]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.apealPeiodNotOverCompleteData[0]!.amountOfTheMonth.toString() ?? '5',
                                      pro.apealPeiodNotOverCompleteData[0]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.apealPeiodNotOverCompleteData[1]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.apealPeiodNotOverCompleteData[1]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.apealPeiodNotOverCompleteData[1]!.amountOfTheMonth.toString() ?? '11',
                                      pro.apealPeiodNotOverCompleteData[1]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.apealPeiodNotOverCompleteData[2]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.apealPeiodNotOverCompleteData[2]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.apealPeiodNotOverCompleteData[2]!.amountOfTheMonth.toString() ?? '15',
                                      pro.apealPeiodNotOverCompleteData[2]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.apealPeiodNotOverCompleteData[3]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.apealPeiodNotOverCompleteData[3]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.apealPeiodNotOverCompleteData[3]!.amountOfTheMonth.toString() ?? '19',
                                      pro.apealPeiodNotOverCompleteData[3]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.apealPeiodNotOverCompleteData[4]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.apealPeiodNotOverCompleteData[4]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.apealPeiodNotOverCompleteData[4]!.amountOfTheMonth.toString() ?? '23',
                                      pro.apealPeiodNotOverCompleteData[4]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.apealPeiodNotOverCompleteData[5]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.apealPeiodNotOverCompleteData[5]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.apealPeiodNotOverCompleteData[5]!.amountOfTheMonth.toString() ?? '27',
                                      pro.apealPeiodNotOverCompleteData[5]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),                               ]),
                              SizedBox(height: 15,),
                              if(pro.recoverableCompleteData.isNotEmpty)
                                _buildCustomTable('Recoverable', [
                                  _buildDataRow(
                                      '1',
                                      'OL cases',
                                      '1',
                                      '2',
                                      pro.recoverableCompleteData[0]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.recoverableCompleteData[0]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.recoverableCompleteData[0]!.amountOfTheMonth.toString() ?? '5',
                                      pro.recoverableCompleteData[0]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.recoverableCompleteData[1]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.recoverableCompleteData[1]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.recoverableCompleteData[1]!.amountOfTheMonth.toString() ?? '11',
                                      pro.recoverableCompleteData[1]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.recoverableCompleteData[2]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.recoverableCompleteData[2]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.recoverableCompleteData[2]!.amountOfTheMonth.toString() ?? '15',
                                      pro.recoverableCompleteData[2]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.recoverableCompleteData[3]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.recoverableCompleteData[3]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.recoverableCompleteData[3]!.amountOfTheMonth.toString() ?? '19',
                                      pro.recoverableCompleteData[3]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.recoverableCompleteData[4]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.recoverableCompleteData[4]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.recoverableCompleteData[4]!.amountOfTheMonth.toString() ?? '23',
                                      pro.recoverableCompleteData[4]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.recoverableCompleteData[5]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.recoverableCompleteData[5]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.recoverableCompleteData[5]!.amountOfTheMonth.toString() ?? '27',
                                      pro.recoverableCompleteData[5]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),
                                  _buildDataRow(
                                      '2',
                                      'DRT Cases',
                                      '1',
                                      '2',
                                      pro.recoverableCompleteData[6]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.recoverableCompleteData[6]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.recoverableCompleteData[6]!.amountOfTheMonth.toString() ?? '5',
                                      pro.recoverableCompleteData[6]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.recoverableCompleteData[7]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.recoverableCompleteData[7]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.recoverableCompleteData[7]!.amountOfTheMonth.toString() ?? '11',
                                      pro.recoverableCompleteData[7]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.recoverableCompleteData[8]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.recoverableCompleteData[8]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.recoverableCompleteData[8]!.amountOfTheMonth.toString() ?? '15',
                                      pro.recoverableCompleteData[8]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.recoverableCompleteData[9]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.recoverableCompleteData[9]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.recoverableCompleteData[9]!.amountOfTheMonth.toString() ?? '19',
                                      pro.recoverableCompleteData[9]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.recoverableCompleteData[10]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.recoverableCompleteData[10]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.recoverableCompleteData[10]!.amountOfTheMonth.toString() ?? '23',
                                      pro.recoverableCompleteData[10]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.recoverableCompleteData[11]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.recoverableCompleteData[11]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.recoverableCompleteData[11]!.amountOfTheMonth.toString() ?? '27',
                                      pro.recoverableCompleteData[11]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),
                                  _buildDataRow(
                                      '3',
                                      'CESTAT',
                                      '1',
                                      '2',
                                      pro.recoverableCompleteData[12]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.recoverableCompleteData[12]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.recoverableCompleteData[12]!.amountOfTheMonth.toString() ?? '5',
                                      pro.recoverableCompleteData[12]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.recoverableCompleteData[13]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.recoverableCompleteData[13]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.recoverableCompleteData[13]!.amountOfTheMonth.toString() ?? '11',
                                      pro.recoverableCompleteData[13]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.recoverableCompleteData[14]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.recoverableCompleteData[14]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.recoverableCompleteData[14]!.amountOfTheMonth.toString() ?? '15',
                                      pro.recoverableCompleteData[14]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.recoverableCompleteData[15]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.recoverableCompleteData[15]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.recoverableCompleteData[15]!.amountOfTheMonth.toString() ?? '19',
                                      pro.recoverableCompleteData[15]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.recoverableCompleteData[16]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.recoverableCompleteData[16]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.recoverableCompleteData[16]!.amountOfTheMonth.toString() ?? '23',
                                      pro.recoverableCompleteData[16]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.recoverableCompleteData[17]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.recoverableCompleteData[17]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.recoverableCompleteData[17]!.amountOfTheMonth.toString() ?? '27',
                                      pro.recoverableCompleteData[17]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),
                                  _buildDataRow(
                                      '4',
                                      'NCLT units',
                                      '1',
                                      '2',
                                      pro.recoverableCompleteData[18]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.recoverableCompleteData[18]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.recoverableCompleteData[18]!.amountOfTheMonth.toString() ?? '5',
                                      pro.recoverableCompleteData[18]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.recoverableCompleteData[19]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.recoverableCompleteData[19]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.recoverableCompleteData[19]!.amountOfTheMonth.toString() ?? '11',
                                      pro.recoverableCompleteData[19]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.recoverableCompleteData[20]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.recoverableCompleteData[20]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.recoverableCompleteData[20]!.amountOfTheMonth.toString() ?? '15',
                                      pro.recoverableCompleteData[20]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.recoverableCompleteData[21]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.recoverableCompleteData[21]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.recoverableCompleteData[21]!.amountOfTheMonth.toString() ?? '19',
                                      pro.recoverableCompleteData[21]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.recoverableCompleteData[22]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.recoverableCompleteData[22]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.recoverableCompleteData[22]!.amountOfTheMonth.toString() ?? '23',
                                      pro.recoverableCompleteData[22]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.recoverableCompleteData[23]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.recoverableCompleteData[23]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.recoverableCompleteData[23]!.amountOfTheMonth.toString() ?? '27',
                                      pro.recoverableCompleteData[23]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),                            ]),
                              SizedBox(height: 15,),
                              if(pro.writeOffCompleteData.isNotEmpty)
                                _buildCustomTable('Writer off', [
                                  _buildDataRow(
                                      '1',
                                      'Write off',
                                      '1',
                                      '2',
                                      pro.writeOffCompleteData[0]!.noOfCasesOfTheMonth.toString() ??'3',
                                      pro.writeOffCompleteData[0]!.noOfCasesUpToTheMonth.toString() ?? '4',
                                      pro.writeOffCompleteData[0]!.amountOfTheMonth.toString() ?? '5',
                                      pro.writeOffCompleteData[0]!.amountUpTotheMonth.toString() ?? '6',
                                      '7',
                                      '8',
                                      pro.writeOffCompleteData[1]!.noOfCasesOfTheMonth.toString() ?? '9',
                                      pro.writeOffCompleteData[1]!.noOfCasesUpToTheMonth.toString() ?? '10',
                                      pro.writeOffCompleteData[1]!.amountOfTheMonth.toString() ?? '11',
                                      pro.writeOffCompleteData[1]!.amountUpTotheMonth.toString() ?? '12',
                                      pro.writeOffCompleteData[2]!.noOfCasesOfTheMonth.toString() ?? '13',
                                      pro.writeOffCompleteData[2]!.noOfCasesUpToTheMonth.toString() ?? '14',
                                      pro.writeOffCompleteData[2]!.amountOfTheMonth.toString() ?? '15',
                                      pro.writeOffCompleteData[2]!.amountUpTotheMonth.toString() ?? '16',
                                      pro.writeOffCompleteData[3]!.noOfCasesOfTheMonth.toString() ?? '17',
                                      pro.writeOffCompleteData[3]!.noOfCasesUpToTheMonth.toString() ?? '18',
                                      pro.writeOffCompleteData[3]!.amountOfTheMonth.toString() ?? '19',
                                      pro.writeOffCompleteData[3]!.amountUpTotheMonth.toString() ?? '20',
                                      pro.writeOffCompleteData[4]!.noOfCasesOfTheMonth.toString() ?? '21',
                                      pro.writeOffCompleteData[4]!.noOfCasesUpToTheMonth.toString() ?? '22',
                                      pro.writeOffCompleteData[4]!.amountOfTheMonth.toString() ?? '23',
                                      pro.writeOffCompleteData[4]!.amountUpTotheMonth.toString() ?? '24',
                                      pro.writeOffCompleteData[5]!.noOfCasesOfTheMonth.toString() ?? '25',
                                      pro.writeOffCompleteData[5]!.noOfCasesUpToTheMonth.toString() ?? '26',
                                      pro.writeOffCompleteData[5]!.amountOfTheMonth.toString() ?? '27',
                                      pro.writeOffCompleteData[5]!.amountUpTotheMonth.toString() ?? '28',
                                      '29',
                                      '30'),
                                ]),
                              SizedBox(height: 30,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Slider to control horizontal scrolling
          ],
        ),
      );

      },
    );
  }

  Widget _buildCustomTable(String title, List<TableRow> rows) {
    Offset? _startDragPosition;

    // Handle the drag update for scrolling in both directions
    void _handleDragUpdate(DragUpdateDetails details) {
      if (_startDragPosition != null) {
        // Scroll horizontally
        horizontalController.jumpTo(
          horizontalController.offset - details.delta.dx,
        );
        // Scroll vertically
        verticalController.jumpTo(
          verticalController.offset - details.delta.dy,
        );
      }
    }

    // When user starts dragging, capture the initial position
    void _handleDragStart(DragStartDetails details) {
      _startDragPosition = details.globalPosition;
    }

    // Reset the drag position when the user stops dragging
    void _handleDragEnd(DragEndDetails details) {
      _startDragPosition = null;
    }

    return GestureDetector(
      onPanStart: _handleDragStart,
      onPanUpdate: _handleDragUpdate,
      onPanEnd: _handleDragEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            alignment: Alignment.topLeft,
            color: Colors.yellow[100],
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Table(
            border: TableBorder.all(),
            columnWidths: const {
              0: FixedColumnWidth(40),
              1: FixedColumnWidth(260),
              2: FixedColumnWidth(200),
              3: FixedColumnWidth(500),
              4: FixedColumnWidth(200),
              5: FixedColumnWidth(500),
              6: FixedColumnWidth(500),
              7: FixedColumnWidth(500),
              8: FixedColumnWidth(500),
              9: FixedColumnWidth(500),
              10: FixedColumnWidth(200),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.yellow[100]),
                children: [
                  _buildHeaderCell('Sl. No.'),
                  _buildHeaderCell('A. $title'),
                  _buildHeaderCellWithSubcolumns(
                      'Opening balance', ['No', 'Amt']),
                  _buildHeaderCellWithSubcolumnsSubColumn('Receipts',
                      ['No', 'Amt'], ['During the month', 'Upto the month']),
                  _buildHeaderCellWithSubcolumns('Total', ['No', 'Amt']),
                  _buildHeaderCellWithSubcolumnsSubColumn(
                      'Decided Fully/Partially in favour',
                      ['No', 'Amt'],
                      ['During the month', 'Upto the month']),
                  _buildHeaderCellWithSubcolumnsSubColumn(
                      'Decided Fully/Partially against',
                      ['No', 'Amt'],
                      ['During the month', 'Upto the month']),
                  _buildHeaderCellWithSubcolumnsSubColumn('Order for Denovo',
                      ['No', 'Amt'], ['During the month', 'Upto the month']),
                  _buildHeaderCellWithSubcolumnsSubColumn(
                      'Arrears transferred to other formations /category',
                      ['No', 'Amt'],
                      ['During the month', 'Upto the month']),
                  _buildHeaderCellWithSubcolumnsSubColumn('Arrears Realised',
                      ['No', 'Amt'], ['During the month', 'Upto the month']),
                  _buildHeaderCellWithSubcolumns(
                      'Closing Balance', ['No', 'Amt']),
                ],
              ),
              ...rows
            ],
          ),
        ],
      ),
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
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(text,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: subcolumns.map((subCol) {
                  return TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
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
      String arrearsRealisedNoofcasesOftheMonth,
      String arrearsRealisedNoofcasesuptotheMonth,
      String arrearsRealisedAmtofcasesoftheMonth,
      String arrearsRealisedAmtofcasesuptotheMonth,
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
        _buildDataCellWithSubcolumnsSubCol(
          [
            arrearsRealisedNoofcasesOftheMonth,
            arrearsRealisedNoofcasesOftheMonth
          ],
          [
            arrearsRealisedAmtofcasesoftheMonth,
            arrearsRealisedAmtofcasesuptotheMonth
          ],
        ),
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
                columnWidths: const {0: FixedColumnWidth(90)},
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
                columnWidths: const {0: FixedColumnWidth(90)},
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

  getData() async {
    var pro = Provider.of<AddNewCase>(context, listen: false);
    await pro.tarArrearLitigation();
    await pro.tarRestrainded();
    await pro.tarAppealPeriodNotOver();
    await pro.tarRecoverable();
    await pro.tarWriteOff();

    print('hellooerfe');
    print({
      'hello i am khush ${pro.litigationCompleteData[0]!.amountOfTheMonth}'
    });

  }
}
