import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
import 'package:import_lookup/Provider-New/get-user-deatils.dart';
import 'package:import_lookup/Widgets/custom-button.dart';
import 'package:import_lookup/Widgets/formation-dropdown.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Provider-New/add-new-cases.dart';
import '../../Widgets/Widgets-New/custom-textfield.dart';

class AddCaseDeatil extends StatefulWidget {
  @override
  State<AddCaseDeatil> createState() => _AddCaseDeatilState();
}

class _AddCaseDeatilState extends State<AddCaseDeatil> {
  String selectedCategory = CATEGORY[2];
  String selectedSubCategory = SUBCATEGORY[CATEGORY[2]]![0];
  String formation = FORMATION[0];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var pro = Provider.of<AddNewCase>(context, listen: false);
    var userInfo = Provider.of<UserInformation>(context, listen: false);
    if(userInfo.userType==USERTYPE[1]){
      formation = userInfo.formation;
    }
    pro.updateSubcategory(SUBCATEGORY[CATEGORY[2]]![0]);
    print(pro.subcategory.text);
  }

  @override
  void adddetail(var pro) async {
    print("dhndhijdihn");
    var pro = Provider.of<AddNewCase>(context, listen: false);
    pro.updateLoader();
    var userInfo = Provider.of<UserInformation>(context, listen: false);

    print('${pro.subcategory.text} ${formation} $selectedCategory');

    // pro.subcategory.text = subcateCategory??"";
    pro.category.text = selectedCategory ?? "";
    pro.formation.text = formation ?? "";

    Map<String, dynamic> res;
    if (userInfo.userType == USERTYPE[0]) {
      res = await pro.addMainCase();
    } else {
      print("heeelo i ma divyansh ");
      res = await pro.addRequestCase(false,
          uid: '', oldData: {}, isShifted: false);
    }
    ;

    if (res['res'] == 'success') {
      if (userInfo.userType == USERTYPE[0]) {
        Fluttertoast.showToast(msg: 'Added new case', timeInSecForIosWeb: 3);
      } else {
        Fluttertoast.showToast(
            msg: 'Request submit to the admin', timeInSecForIosWeb: 3);
      }
      pro.clear();
    } else {
      print("heeelo i am here ${res["res"]}");
      Fluttertoast.showToast(msg: 'Some error occur', timeInSecForIosWeb: 3);
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
                                  selectedCategory = value!;
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
                                selectedSubCategory = value!;
                                pro.updateSubcategory(value!);
                                print("vailue is here $value");
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
                                    formation = value!;
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
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: CustomButton(
                            onpress: () {
                              print('DAteeeeeeeeeeeeeeeeeee');
                              print(date.date);
                              if (pro.name.text.isEmpty ||
                                  pro.dutyOfArrear.text.isEmpty ||
                                  pro.totalArrearPending.text.isEmpty ||
                                  date.date == 'Select OIO Date' ||
                                  date.date == '') {
                                Fluttertoast.showToast(
                                    msg:
                                        'Pleas fill name, duty of arrears, total arrears pending and date',
                                    timeInSecForIosWeb: 3);
                              } else {
                                adddetail(pro);
                              }
                            },
                            text: 'Add Case',
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
}
