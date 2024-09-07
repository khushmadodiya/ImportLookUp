import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Backend/AddUniversalDetails.dart';
import '../main.dart';
import '../provider/provider.dart';
import 'package:import_lookup/Screens/Custom%20code/textfiled.dart';

class UpdateUniversalDetails extends StatefulWidget {
  final int index;
  const UpdateUniversalDetails({super.key, required this.index});

  @override
  State<UpdateUniversalDetails> createState() => _UpdateUniversalDetailsState();
}

class _UpdateUniversalDetailsState extends State<UpdateUniversalDetails> {
  late Map<String, dynamic> details;
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

  final TextEditingController _assesseeNameController = TextEditingController();
  final TextEditingController _divisionRangeController = TextEditingController();
  final TextEditingController _oioNoDateController = TextEditingController();
  final TextEditingController _totalDutyOfArrearController = TextEditingController();
  final TextEditingController _penaltyController = TextEditingController();
  final TextEditingController _amountRecoveredController = TextEditingController();
  final TextEditingController _preDepositController = TextEditingController();
  final TextEditingController _totalArrearsPendingController = TextEditingController();
  final TextEditingController _briefFactsController = TextEditingController();
  final TextEditingController _presentStatusController = TextEditingController();
  final TextEditingController _appealNoController = TextEditingController();
  final TextEditingController _stayOrderNoDateController = TextEditingController();
  final TextEditingController _effortsMadeRemarksController = TextEditingController();
  final TextEditingController _iecController = TextEditingController();
  final TextEditingController _gstinController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();

  String? selectedCategory;
  String? selectedSubCategory;
  String? date;


  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AsseserProvider>(context, listen: false);
    details = provider.assesers()[widget.index];

    _assesseeNameController.text = details['name'] ?? '';
    _divisionRangeController.text = details['division_range'] ?? '';
    _oioNoDateController.text = details['oio'] ?? '';
    _totalDutyOfArrearController.text = details['duty_or_arear'] ?? '';
    _penaltyController.text = details['penalty'] ?? '';
    _amountRecoveredController.text = details['amount_recovered'] ?? '';
    _preDepositController.text = details['pre_deposit'] ?? '';
    _totalArrearsPendingController.text = details['total_arrears_pending'] ?? '';
    _briefFactsController.text = details['brief_facts'] ?? '';
    _presentStatusController.text = details['status'] ?? '';
    _appealNoController.text = details['appeal_no'] ?? '';
    _stayOrderNoDateController.text = details['stay_order_no_and_date'] ?? '';
    _effortsMadeRemarksController.text = details['remark'] ?? '';
    _iecController.text = details['iec'] ?? '';
    _gstinController.text = details['gstin'] ?? '';
    _panController.text = details['pan'] ?? '';
    _ageController.text = details['age']?.toString() ?? '';
    selectedCategory = details['category'];
    selectedSubCategory = details['subcategory'];
    date = details['date'];
  }

  void addDetail() async {

    var uid = details['uid'];

    Map<String, dynamic> assesseeDetails = {
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
      'remark': _effortsMadeRemarksController.text,
      'iec': _iecController.text,
      'gstin': _gstinController.text,
      'pan': _panController.text,
      'age': double.tryParse(_ageController.text),
      'complete_track': selectedCategory == "Arrear where appeal period is not over"
          ? ['${date} OIO is filed']
          : ['${date} shifted to $selectedCategory : $selectedSubCategory'],
      'category': selectedCategory ?? "None",
      'subcategory': selectedSubCategory ?? "None",
      'isshifted': selectedCategory == "Arrear where appeal period is not over" ? 0 : 1,
    };
    String trackEntry =
    selectedCategory == "Arrear where appeal period is not over"
        ? '${date} OIO is filed'
        : '${date} shifted to $selectedCategory : $selectedSubCategory';

    if (isadmin) {

      String res = await AddUniversalDetails().addDetails(assesseeDetails, uid,trackEntry);
      if (res == "s") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Details updated successfully!')),
        );
        Navigator.pop(context, true);
      }
    } else {
      // If the user is not an admin, create a request in the requests collection
      Map<String, dynamic> requestDetails = {
        'uid': uid,
        'name': details['name'], // Original value
        'upname': _assesseeNameController.text, // Updated value
        'division_range': details['division_range'],
        'updivision_range': _divisionRangeController.text, // Updated value
        'oio': details['oio'],
        'upoio': _oioNoDateController.text, // Updated value
        'duty_or_arear': details['duty_or_arear'],
        'upduty_or_arear': _totalDutyOfArrearController.text, // Updated value
        'penalty': details['penalty'],
        'uppenalty': _penaltyController.text, // Updated value
        'amount_recovered': details['amount_recovered'],
        'upamount_recovered': _amountRecoveredController.text, // Updated value
        'pre_deposit': details['pre_deposit'],
        'uppre_deposit': _preDepositController.text, // Updated value
        'total_arrears_pending': details['total_arrears_pending'],
        'uptotal_arrears_pending': _totalArrearsPendingController.text, // Updated value
        'brief_facts': details['brief_facts'],
        'upbrief_facts': _briefFactsController.text, // Updated value
        'status': details['status'],
        'upstatus': _presentStatusController.text, // Updated value
        'appeal_no': details['appeal_no'],
        'upappeal_no': _appealNoController.text, // Updated value
        'stay_order_no_and_date': details['stay_order_no_and_date'],
        'upstay_order_no_and_date': _stayOrderNoDateController.text, // Updated value
        'iec': details['iec'],
        'upiec': _iecController.text, // Updated value
        'gstin': details['gstin'],
        'upgstin': _gstinController.text, // Updated value
        'pan': details['pan'],
        'uppan': _panController.text, // Updated value
        'age': details['age'],
        'upage': double.tryParse(_ageController.text), // Updated value
        'complete_track': details['complete_track'],
        'upcomplete_track': selectedCategory == "Arrear where appeal period is not over"
            ? ['${date} OIO is filed']
            : ['${date} shifted to $selectedCategory : $selectedSubCategory'],
      };

      String res = await AddUniversalDetails().addRequest(requestDetails,uid);
      if (res == "s") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update request submitted successfully!')),
        );
        Navigator.pop(context, true);
      }
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
                              child: Center(child: Text(date.toString())),
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
                  _panController,
                  'Stay order no. & date',
                  'PAN',
                ),
                buildRow(
                  _iecController,
                  _gstinController,
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
                  child: const SizedBox(
                    height: 50,
                    width: 300,
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
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