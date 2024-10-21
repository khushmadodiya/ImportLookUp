import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Backend-New/main-cases-details.dart';
import 'package:import_lookup/Model-New/main-case-model.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
import 'package:import_lookup/Provider-New/get-user-deatils.dart';
import 'package:import_lookup/Widgets/custom-button.dart';
import 'package:import_lookup/Widgets/formation-dropdown.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Provider-New/add-new-cases.dart';
import '../../Widgets/Widgets-New/custom-textfield.dart';

class AcceptRequestCaseTextFields extends StatefulWidget {
  String uid;
  String formation;
  bool isNewRequest;
  AcceptRequestCaseTextFields(
      {super.key,
      required this.uid,
      required this.formation,
      this.isNewRequest = false});

  @override
  State<AcceptRequestCaseTextFields> createState() =>
      _AcceptRequestCaseTextFieldsState();
}

class _AcceptRequestCaseTextFieldsState
    extends State<AcceptRequestCaseTextFields> {
  Map<String, dynamic> oldData = {};
  String? selectedCategory = CATEGORY[2];
  String? selectedSubcategory = SUBCATEGORY[CATEGORY[2]]![0];
  String? formation = FORMATION[0];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setValues();
  }

  @override
  void adddetail(var pro) async {
    var pro = Provider.of<AddNewCase>(context, listen: false);
    pro.updateLoader();
    var userInfo = Provider.of<UserInformation>(context, listen: false);
    print(
        '${pro.subcategory.text} ${widget.formation} $selectedCategory ${widget.uid}');

    Map<String, dynamic> res;
    if (userInfo.userType == USERTYPE[0]) {
      print("Objectsssssssssssss");
      res = await pro.acceptRequestByAdmin(
          uid: widget.uid, formation: formation!, isRequest: true);

      print('dddddddddddddddddddddddddddddddddddddddd${res['res']}');
    } else {
      res = await pro.addRequestCase(false,
          uid: widget.uid, oldData: oldData, isShifted: true);
      print("here is resp[onse ${res["res"]}");
    }
    if (res['res'] == 'success') {
      if (userInfo.userType == USERTYPE[0]) {
        Fluttertoast.showToast(msg: 'Updated case', timeInSecForIosWeb: 3);
        Navigator.pop(context, true);
      } else {
        Fluttertoast.showToast(
            msg: 'Request submit to the admin', timeInSecForIosWeb: 3);
        Navigator.pop(context, true);
      }
      pro.clear();
    } else {
      Fluttertoast.showToast(
          msg: 'Some error occur ${res['res']}', timeInSecForIosWeb: 3);
    }
    pro.updateLoader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appeal Period Not Over'),
      ),
      body: Consumer<GeneralPurposeProvider>(
        builder: (context, date, child) => Consumer<UserInformation>(
          builder: (context, userInfo, child) => Consumer<AddNewCase>(
            builder: (context, pro, child) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Column(
                          children: CATEGORY.map((category) {
                            return RadioListTile<String>(
                              title: Text(category),
                              value: category,
                              groupValue: selectedCategory,
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value;
                                  if (value != null) {
                                    pro.setCategory(value);
                                    selectedSubcategory =
                                        SUBCATEGORY[value]![0];
                                    pro.updateSubcategory(
                                        SUBCATEGORY[value]![0]);
                                  }
                                  // subcategoryKey.currentState?.getSelectedItems = null; // Reset subcategory when category changes
                                });
                              },
                            );
                          }).toList(),
                        ),

                        // Show DropdownSearch for subcategories only when a category is selected
                        if (selectedCategory != null &&
                            SUBCATEGORY[selectedCategory]!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GlobleDropdown(
                              label: "Select Subcategory",
                              listofvalues: SUBCATEGORY[selectedCategory]!,
                              fun: (String? value) {
                                selectedSubcategory = value;
                                pro.updateSubcategory(value!);
                                print("vailue is here $value");
                              },
                              selectedItem: selectedSubcategory!,
                            ),
                          ),
                      ],
                    ),
                    buildRow(
                      pro.name,
                      pro.oio,
                      'Name of the Assessee',
                      'OIO Number',
                    ),
                    // if(userInfo.userType==USERTYPE[1]) buildRow(, controller2, label1, label2),

                    SizedBox(
                      height: 60,
                      // width:,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            // TextField(),
                            if (userInfo.userType == USERTYPE[0])
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.269,
                                child: GlobleDropdown(
                                  listofvalues: FORMATION,
                                  label: 'Select formation',
                                  fun: (value) {
                                    formation = value;
                                  },
                                  selectedItem: formation!,
                                ),
                              ),
                            // const SizedBox(width:20,),
                            SizedBox(
                              height: 60,
                              width: userInfo.userType == USERTYPE[1]
                                  ? MediaQuery.of(context).size.width / 2.1
                                  : MediaQuery.of(context).size.width / 5,
                              child: InkWell(
                                onTap: () async {
                                  DateTime? dat = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1500),
                                      lastDate: DateTime.now());
                                  if (dat != null) {
                                    String datt =
                                        DateFormat('dd-MM-yyyy').format(dat);
                                    date.updateDate(datt);
                                    pro.setDate(datt);
                                  }
                                },
                                child: Card(
                                  elevation: 8,
                                  color: Colors.blue[50],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    // width: MediaQuery.of(context).size.width * 0.48,
                                    child: Center(child: Text(date.date)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: SizedBox(
                                    // width: MediaQuery.of(context).size.width,
                                    child: CustomTextField(
                                  controller: pro.dutyOfArrear,
                                  hintText: 'Total Duty Arrear',
                                  labelText: 'Total Duty Arrear',
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    buildRow(
                      pro.penalty,
                      pro.interest,
                      'Penalty',
                      'Interest',
                    ),
                    buildRow(
                      pro.amountRecovered,
                      pro.preDeposit,
                      'Amount Recovered so far',
                      'Pre-deposit(if any)',
                    ),
                    buildRow(
                      pro.totalArrearPending,
                      pro.appealNo,
                      'Total Arrears Pending',
                      'Appeal No.',
                    ),
                    buildRow(
                      pro.stayOrderNumberAndDate,
                      pro.pan,
                      'Stay order no. & date',
                      'PAN',
                    ),
                    buildRow(
                      pro.iec,
                      pro.gstin,
                      'IEC',
                      'GSTIN',
                    ),
                    buildRow(
                      pro.status,
                      pro.briefFact,
                      'Present Status of the case',
                      'Brief facts of the case',
                      maxLines: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: pro.effortMade,
                        hintText: 'Efort Made/Remark',
                        maxLines: 10,
                        height: 100,
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 5,
                        child: CustomButton(
                            onpress: () {
                              if (pro.name.text.isEmpty ||
                                  pro.dutyOfArrear.text.isEmpty ||
                                  pro.totalArrearPending.text.isEmpty ||
                                  date == 'Select OIO Date') {
                                Fluttertoast.showToast(
                                    msg:
                                        'Pleas fill name, duty of arrear, total arrear pending and date',
                                    timeInSecForIosWeb: 3);
                              } else {
                                adddetail(pro);
                              }
                            },
                            text: 'Accept Request',
                            isLoading: pro.isLoading))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(TextEditingController controller1,
      TextEditingController controller2, String label1, String label2,
      {int? maxLines, bool isvalid = false}) {
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

  void setValues() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var date = Provider.of<GeneralPurposeProvider>(context, listen: false);
      if (!widget.isNewRequest) {
        print('Maincasedetail');
        var res = (await MainCasesInformation().getRequestCaseDetailByDocument(
            formation: widget.formation, uid: widget.uid));
        if (res['res'] == 'success') {
          var pro = Provider.of<AddNewCase>(context, listen: false);
          MainCaseModel model = res['model'];
          print(model.category);
          print(model.subcategory);
          oldData = model.toJson();
          pro.setName(model.name);
          pro.setCategory(model.category);
          pro.setSubcategory(model.subcategory);
          pro.setDutyOfArrear(model.dutyOfArrear);
          pro.setFormation(model.formation);
          pro.setOio(model.oio);
          pro.setDate(model.date);
          pro.setPenalty(model.penalty);
          pro.setAmountRecovered(model.amountRecovered);
          pro.setPreDeposit(model.preDeposit);
          pro.setInterest(model.intrest);
          pro.setTotalArrearPending(model.totalArrearPending);
          pro.setBriefFact(model.briefFact);
          pro.setStatus(model.status);
          pro.setAppealNo(model.apealNo);
          pro.setStayOrderNumberAndDate(model.stayOrderNumberAndDate);
          pro.setIec(model.iec);
          pro.setGstin(model.gstin);
          pro.setPan(model.pan);
          pro.setAge(model.age.toString());
          pro.setEffortMade(model.effortMade);
          pro.setRemark(model.remark);
          selectedCategory = model.category;
          selectedSubcategory = model.subcategory;
          formation = model.formation;
          date.updateDate(model.date);
        } else {
          Fluttertoast.showToast(msg: '${res['res']}', timeInSecForIosWeb: 4);
          Navigator.pop(context);
          print(res['res']);
        }
      } else {
        print('objectREqusstttttttttttttt');
        var res = (await MainCasesInformation().getRequestCaseDetailByDocument(
            formation: widget.formation, uid: widget.uid));
        if (res['res'] == 'success') {
          var pro = Provider.of<AddNewCase>(context, listen: false);
          MainCaseModel model = res['model'];
          print(model.category);
          oldData = model.toJson();
          pro.setName(model.name);
          pro.setCategory(model.category);
          pro.setSubcategory(model.subcategory);
          pro.setDutyOfArrear(model.dutyOfArrear);
          pro.setFormation(model.formation);
          pro.setOio(model.oio);
          pro.setDate(model.date);
          pro.setPenalty(model.penalty);
          pro.setAmountRecovered(model.amountRecovered);
          pro.setPreDeposit(model.preDeposit);
          pro.setInterest(model.intrest);
          pro.setTotalArrearPending(model.totalArrearPending);
          pro.setBriefFact(model.briefFact);
          pro.setStatus(model.status);
          pro.setAppealNo(model.apealNo);
          pro.setStayOrderNumberAndDate(model.stayOrderNumberAndDate);
          pro.setIec(model.iec);
          pro.setGstin(model.gstin);
          pro.setPan(model.pan);
          pro.setAge(model.age.toString());
          pro.setEffortMade(model.effortMade);
          pro.setRemark(model.remark);
          selectedCategory = model.category;
          selectedSubcategory = model.subcategory;
          formation = model.formation;
          date.updateDate(model.date);
        } else {
          Fluttertoast.showToast(msg: '${res['res']}', timeInSecForIosWeb: 4);
          Navigator.pop(context);
          print(res['res']);
        }
      }
    });
  }
}
