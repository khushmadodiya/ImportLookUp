import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:import_lookup/Screens/Custom%20code/textfiled.dart';
import 'package:import_lookup/global.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../Backend/AddUniversalDetails.dart';
import '../Backend/add_asessee_data.dart';
import '../provider/provider.dart';

class UpdateUniversalDetails extends StatefulWidget {
  final index;
  const UpdateUniversalDetails({super.key, this.index});

  @override
  State<UpdateUniversalDetails> createState() => _UpdateUniversalDetailsState();
}

class _UpdateUniversalDetailsState extends State<UpdateUniversalDetails> {
  // Controllers for each text field
  final TextEditingController _assesseeNameController = TextEditingController();
  final TextEditingController _divisionRangeController =
      TextEditingController();
  final TextEditingController _oioNoDateController = TextEditingController();
  final TextEditingController _totalDutyOfArrearController =
      TextEditingController();
  final TextEditingController _penaltyController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _amountRecoveredController =
      TextEditingController();
  final TextEditingController _preDepositController = TextEditingController();
  final TextEditingController _totalArrearsPendingController =
      TextEditingController();
  final TextEditingController _briefFactsController = TextEditingController();
  final TextEditingController _presentStatusController =
      TextEditingController();
  final TextEditingController _appealNoController = TextEditingController();
  final TextEditingController _stayOrderNoDateController =
      TextEditingController();
  final TextEditingController _effortsMadeRemarksController =
      TextEditingController();
  final TextEditingController _IECController = TextEditingController();
  final TextEditingController _GSTINController = TextEditingController();
  final TextEditingController _PANController = TextEditingController();

  String date = 'Select OIO Date';
  String? selectedCategory;
  String? selectedSubCategory;

  final Map<String, List<String>> categorySubCategoryMap = {
    "Arrear in Litigation/Appeal": [
      "SC", "HC",
      "CESTAT",
      "Commissioner Appeal",
      // "Additional Secretary (Revision Application)"
    ],
    "Restrained Arrear": ["OL", "DRT", "BIFR", "NCLT"],
    "Arrear where appeal period is not over": [],
    "Recoverable Arrear": [
      "Appeal period over but no appeal filed",
      "Settlement Commission cases",
      "Units closed/defaulters not traceable",
      "Arrear under Section -11 of Central Excise Act 1944",
      "Arrear under Section 142 (1)(c)(i) & (ii)",
      "Arrears fit for Write-off"
    ],
  };
  List<Map<String, dynamic>>? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final asseserProvider =
        Provider.of<AsseserProvider>(context, listen: false);
    data = asseserProvider.assesers();
    print(data![widget.index].toString());
    _assesseeNameController.text = data![widget.index]['name'].toString();
    _divisionRangeController.text =
        data![widget.index]['division_range'].toString();
    _oioNoDateController.text = data![widget.index]['oio'].toString();
    date = data![widget.index]['date'].toString(); // Date value
    _totalDutyOfArrearController.text =
        data![widget.index]['duty_or_arear'].toString();
    _penaltyController.text = data![widget.index]['penalty'].toString();
    _interestController.text = data![widget.index]['interest'].toString();
    _amountRecoveredController.text =
        data![widget.index]['amount_recovered'].toString();
    _preDepositController.text = data![widget.index]['pre_deposit'].toString();
    _totalArrearsPendingController.text =
        data![widget.index]['total_arrears_pending'].toString();
    _briefFactsController.text = data![widget.index]['brief_facts'].toString();
    _presentStatusController.text = data![widget.index]['status'].toString();
    _appealNoController.text = data![widget.index]['appeal_no'].toString();
    _stayOrderNoDateController.text =
        data![widget.index]['stay_order_no_and_date'].toString();
    _effortsMadeRemarksController.text =
        data![widget.index]['remark'].toString();
    _IECController.text = data![widget.index]['iec'].toString();
    _GSTINController.text = data![widget.index]['gstin'].toString();
    _PANController.text = data![widget.index]['pan'].toString();
    selectedCategory = data![widget.index]['category'].toString();
    selectedSubCategory = data![widget.index]['subcategory']?.toString();
  }

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

  void addDetail() async {
    var uid = data![widget.index]['uid'];
    Map<String, dynamic> asseserDetails = {
      'uid': uid,
      'name': _assesseeNameController.text,
      'division_range': _divisionRangeController.text,
      'oio': _oioNoDateController.text,
      'date': date,
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
      'iec': _IECController.text,
      'gstin': _GSTINController.text,
      'pan': _PANController.text,
      'complete_track':
          selectedCategory == "Arrear where appeal period is not over"
              ? ['${date} OIO is filed']
              : ['${date} shifted to $selectedCategory : $selectedSubCategory'],
      'category': selectedCategory ?? "None",
      'subcategory': selectedSubCategory ?? "None",
      'isshifted':
          selectedCategory == "Arrear where appeal period is not over" ? 0 : 1,
    };
    String trackEntry =
        selectedCategory == "Arrear where appeal period is not over"
            ? '${date} OIO is filed'
            : '${date} shifted to $selectedCategory : $selectedSubCategory';

    String res =
        await AddUniversalDetails().addDetails(asseserDetails, uid, trackEntry);
    if (res == "s") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$res Details added successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transfer Case'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Column(
                  children: categorySubCategoryMap.keys.map((category) {
                    return RadioListTile<String>(
                      title: Text(category),
                      value: category,
                      groupValue: selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                          selectedSubCategory = null; // Reset subcategory
                        });
                      },
                    );
                  }).toList(),
                ),
                if (selectedCategory != null && categorySubCategoryMap[selectedCategory]!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: selectedSubCategory,
                      hint: Text('Select Subcategory'),
                      isExpanded: true,
                      items: categorySubCategoryMap[selectedCategory]!
                          .map((subCategory) {
                        return DropdownMenuItem<String>(
                          value: subCategory,
                          child: Text(subCategory),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSubCategory = value;
                        });
                      },
                    ),
                  ),
                buildRow(
                  _assesseeNameController,
                  _divisionRangeController,
                  'Name of the Assessee',
                  'Division / Range',
                ),
                SizedBox(
                  height: 51,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: _oioNoDateController,
                            decoration: const InputDecoration(
                              hintText: 'OIO Number',
                              labelText: 'OIO Number',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              DateTime? dat = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1500),
                                lastDate: DateTime.now(),
                                initialDate: DateTime.now(),
                              );
                              if (dat != null) {
                                date = DateFormat('dd-MM-yyyy').format(dat);
                                setState(() {});
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(child: Text(date)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 2,
                          child: TextField(
                            controller: _totalDutyOfArrearController,
                            decoration: const InputDecoration(
                              hintText: 'Total Duty Arrear',
                              labelText: 'Total Duty Arrear',
                              border: OutlineInputBorder(),
                            ),
                          ),
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
                  maxLines: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _effortsMadeRemarksController,
                    decoration: const InputDecoration(
                      hintText: 'Effort Made/Remark',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 10,
                  ),
                ),
                ElevatedButton(
                  onPressed: addDetail,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ));
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
