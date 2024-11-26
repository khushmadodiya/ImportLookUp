
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
import '../../global.dart';

class UpdateCaseDetail extends StatefulWidget {
  String uid;
  String formation;
  UpdateCaseDetail({
    super.key,
    required this.uid,
    required this.formation,
  });

  @override
  State<UpdateCaseDetail> createState() => _UpdateCaseDetailState();
}

class _UpdateCaseDetailState extends State<UpdateCaseDetail> {
  Map<String, dynamic> oldData = {};
  String? selectedCategory = CATEGORY[2];
  String? selectedSubCategory = SUBCATEGORY[CATEGORY[2]]![0];
  String? formation = FORMATION[0];
  // oldData;
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
    print('${pro.subcategory.text} ${formation} $selectedCategory');

    // pro.subcategory.text = subcateCategory??"";
    pro.category.text = selectedCategory ?? "";
    pro.formation.text = formation ?? "";

    Map<String, dynamic> res;
    if (userInfo.userType == USERTYPE[0]) {
      res = await pro.updateMainCaseDetails(true,
          uid: widget.uid,
          isShifted: true,
          oldDataModel: MainCaseModel.fromJson(oldData));
    } else {
      res = await pro.addRequestCase(false,
          uid: widget.uid, oldData: oldData, isShifted: true);
    }
    print('dfihugihhffiheihufbiuhfriuwher');
    print(res['res']);
    if (res['res'] == 'success') {
      if (userInfo.userType == USERTYPE[0]) {
        Fluttertoast.showToast(msg: 'Updated case', timeInSecForIosWeb: 3);
        Navigator.pop(context, true);
      } else {
        Fluttertoast.showToast(
            msg: 'Request submit to the admin', timeInSecForIosWeb: 3);
        Navigator.pop(context);
      }

      pro.clear();
    } else {
      Fluttertoast.showToast(msg: res['res'], timeInSecForIosWeb: 3);
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
                            String text =capitalizeFirstLetter(category);

                            return RadioListTile<String>(
                              title: Text(text),
                              value: category,
                              groupValue: selectedCategory,
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value;
                                  selectedSubCategory = SUBCATEGORY[value]![0];
                                  pro.updateSubcategory(SUBCATEGORY[value]![0]);
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
                                selectedSubCategory = value;
                                pro.updateSubcategory(value!);
                                print("value is hererrrrrrrrrr $value");
                              },
                              selectedItem: selectedSubCategory!,
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
                                  selectedItem: FORMATION[0],
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
                                        gradient: LinearGradient(
                                          colors: [Colors.deepPurple[50]!, Colors.deepPurple[100]!],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        border: Border.all(color: Colors.deepPurple),
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
                      maxLines: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: pro.effortMade,
                        hintText: 'Efort Made/Remark',
                        labelText: 'Efort Made/Remark',
                        maxLines: 5,
                        height: 100,
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 3.5,
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
                            text: userInfo.userType==USERTYPE[0]?'Transfer Case':'Add Request Case',
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

  void setValues() async {
    var date = Provider.of<GeneralPurposeProvider>(context, listen: false);
    var res = (await MainCasesInformation().getMainCaseDetailByDocument(
        formation: widget.formation, uid: widget.uid));
    if (res['res'] == 'success') {
      var pro = Provider.of<AddNewCase>(context, listen: false);
      MainCaseModel model = res['model'];
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
      selectedSubCategory = model.subcategory;
      formation = pro.formation.text;
      date.updateDate(model.date);
    } else {
      Fluttertoast.showToast(msg: '${res['res']}', timeInSecForIosWeb: 4);
      Navigator.pop(context);
      print(res['res']);
    }
  }
}
