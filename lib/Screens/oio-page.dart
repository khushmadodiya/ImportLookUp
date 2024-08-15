import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:intl/intl.dart';
import 'package:import_lookup/Screens/Custom%20code/textfiled.dart';
import 'package:intl/intl.dart';

import '../Backend/add_asessee_data.dart';
// Adjust import path as necessary

class AddAsseserDetails extends StatefulWidget {
  const AddAsseserDetails({super.key});

  @override
  State<AddAsseserDetails> createState() => _AddAsseserDetailsState();
}

class _AddAsseserDetailsState extends State<AddAsseserDetails> {
  // Controllers for each text field
  final TextEditingController _assesseeNameController = TextEditingController();
  final TextEditingController _divisionRangeController = TextEditingController();
  final TextEditingController _oioNoDateController = TextEditingController();
  final TextEditingController _totalDutyOfArrearController = TextEditingController();
  final TextEditingController _penaltyController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _amountRecoveredController = TextEditingController();
  final TextEditingController _preDepositController = TextEditingController();
  final TextEditingController _totalArrearsPendingController =TextEditingController();
  final TextEditingController _briefFactsController = TextEditingController();
  final TextEditingController _presentStatusController = TextEditingController();
  final TextEditingController _appealNoController = TextEditingController();
  final TextEditingController _stayOrderNoDateController = TextEditingController();
  final TextEditingController _effortsMadeRemarksController = TextEditingController();
  final TextEditingController _IECController = TextEditingController();
  final TextEditingController _GSTINController = TextEditingController();
  final TextEditingController _PANController = TextEditingController();


  String date='Select OIO Date';

  @override
  void dispose() {
    _assesseeNameController.dispose();
    _divisionRangeController.dispose();
    _oioNoDateController.dispose();
    _totalDutyOfArrearController.dispose();
    _penaltyController.dispose();
    _interestController.dispose();
    _amountRecoveredController.dispose();
    _preDepositController.dispose();
    _totalArrearsPendingController.dispose();
    _briefFactsController.dispose();
    _presentStatusController.dispose();
    _appealNoController.dispose();
    _stayOrderNoDateController.dispose();
    _effortsMadeRemarksController.dispose();
    _IECController.dispose();
    _GSTINController.dispose();
    _PANController.dispose();
    super.dispose();

  }

  void adddetail() async {

      Map<String, dynamic> asseserDetails = {
        'name': _assesseeNameController.text,
        'division_range': _divisionRangeController.text,
        'OIO_and_date': _oioNoDateController.text,
        'Date':date,
        'duty_or_arear': _totalDutyOfArrearController.text,
        'penalty': _penaltyController.text,
        'amount_recovered': _amountRecoveredController.text,
        'pre_deposit': _preDepositController.text,
        'total_arrears_pending': _totalArrearsPendingController.text,
        'brief_facts': _briefFactsController.text,
        'status': _presentStatusController.text,
        'appeal_no': _appealNoController.text,
        'stay_order_no_and_date': _stayOrderNoDateController.text,
        'remark': _amountRecoveredController.text,
        'IEC':_IECController.text,
        'GSTIN':_GSTINController.text,
        'PAN':_PANController.text,
        'complete_track': ['${date} OIO is filed'],
        'category':"apeal period not over",
        'isshifted':1,
      };
      String res=  await AddAsesse().addDetails(asseserDetails);
     if(res=="s") {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('$res Details added successfully!')),
       );
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appeal Period Not Over'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              buildRow(
                _assesseeNameController,
                _divisionRangeController,
                'Name of the Assessee',
                'Division / Range',
              ),
              // buildRow(
              //   _oioNoDateController,
              //   _totalDutyOfArrearController,
              //   'OIO No. & Date',
              //   'Total Duty of Arrear',
              // ),
              SizedBox(
                height: 51,
                // width:,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      // TextField(),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.24,
                          child: TextField(
                            controller: _oioNoDateController,
                            decoration:const InputDecoration(
                              hintText:'OIO Number',
                              labelText: 'OIO Number',
                              border: OutlineInputBorder(),
                            ),
                          )
                          ),
                         const SizedBox(width:20,),
                          SizedBox(
                            height: 51,
                            width:300,
                            child: InkWell(
                              onTap:()async {
                                DateTime? dat=await showDatePicker(context: context, firstDate:DateTime(1500), lastDate:DateTime.now());
                                if(dat!=null){
                                  date=DateFormat('dd-MM-yyyy').format(dat);
                                  setState(() {

                                  });
                                }
                              },
                              child: Container(
                                decoration:BoxDecoration(
                                  border:Border.all(
                                    color:Colors.grey
                                  ),
                                ),
                              width: MediaQuery.of(context).size.width * 0.3,
                              child:Center(child: Text(date)),
                              ),
                            ),
                          ),
                          const SizedBox(width:20,),
                          SizedBox(
                          width: MediaQuery.of(context).size.width * 0.518,
                          child: TextField(
                            controller: _totalDutyOfArrearController,
                            decoration:const InputDecoration(
                              hintText:'Total Duty Arrear',
                              labelText: 'Total Duty Arrear',
                              border: OutlineInputBorder(),
                            ),
                          )
                          ),
                    ],
                  ),
                ),
              ),
              buildRow(
                _penaltyController,
                _interestController,
                'Penalty',
                'Interest',
              ),
              buildRow(
                _amountRecoveredController,
                _preDepositController,
                'Amount Recovered so far',
                'Pre-deposit(if any)',
              ),
              buildRow(
                _totalArrearsPendingController,
                _appealNoController,
                'Total Arrears Pending',
                'Appeal No.',
              ),
              buildRow(
                _stayOrderNoDateController,
                _PANController,
                'Stay order no. & date',
                'PAN',
              ),
              buildRow(
                _IECController,
                _GSTINController,
                'IEC',
                'GSTIN',
              ),
              buildRow(
                  _briefFactsController,
                  _presentStatusController,
                  'Present Status of the case',
                  'Brief facts of the case',
                  maxLines: 10
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _effortsMadeRemarksController,
                  decoration: InputDecoration(
                    hintText: 'Efort Made/Remark',
                    border:OutlineInputBorder(),
                  ),
                  maxLines: 10,
                ),
              ),
              ElevatedButton(
                onPressed: () {adddetail();},
                child: const SizedBox(
                  height: 50,
                  width: 300,
                  child: Center(
                      child: Text(
                    'Save Data',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(TextEditingController controller1,
      TextEditingController controller2, String label1, String label2,
      {int? maxLines}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          maxLines == null
              ? Expanded(
            child: CustomTextField(
              controller: controller1,
              hintText: label1,
              labelText: label1,
              width: 300,
            ),
          )
              : Expanded(
            child: CustomTextField(
              controller: controller1,
              hintText: label1,
              labelText: label1,
              width: 300,
              height: 100,
              maxLines: maxLines,
            ),
          ),
          const SizedBox(width: 8),
          maxLines == null
              ? Expanded(
                  child: CustomTextField(
                    controller: controller2,
                    hintText: label2,
                    labelText: label2,
                    width: 300,
                  ),
                )
              : Expanded(
                  child: CustomTextField(
                    controller: controller2,
                    hintText: label2,
                    labelText: label2,
                    width: 300,
                    height: 100,
                    maxLines: maxLines,
                  ),
                ),
        ],
      ),
    );
  }
}
