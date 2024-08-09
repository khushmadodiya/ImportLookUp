import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:import_lookup/Backend/add_asessee_data.dart';
import 'package:import_lookup/Widgets/controllers.dart';

import '../Widgets/text_field.dart';




class InsertDataScreen extends StatefulWidget {
  const InsertDataScreen({Key? key}) : super(key: key);

  @override
  State<InsertDataScreen> createState() => _InsertDataScreenState();
}

class _InsertDataScreenState extends State<InsertDataScreen> {

  final _formkey = GlobalKey<FormState>();


  void initState() {
    super.initState();

  }




  void adddetail() async {
    if (_formkey.currentState!.validate()) {
      Map<String, dynamic> asseserDetails = {
        'name': nameOfAsseser.text,
        'division_range': Division.text,
        'OIO_and_date': OIONOAndDate.text,
        'duty_or_arear': TotalDutyOfArear.text,
        'penalty': Penlty.text,
        'amount_recovered': AmmountRecoverSofar.text,
        'pre_deposit': PredepositIfAny.text,
        'total_arrears_pending': TotalArearsForPending.text,
        'brief_facts': BrifFectOftheCase.text,
        'status': PresentStatusOfCase.text,
        'appeal_no': ApealNo.text,
        'stay_order_no_and_date': StayOrderNoAndDate.text,
        'remark': PresentStatusOfCase.text,
      };
      String res=  await AddAsesse().addDetails(asseserDetails,OIONOAndDate.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$res Details added successfully!')),
      );
      _formkey.currentState!.reset();
    } else {
      print('error');
    }
  }


  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('House Details'),
      // ),
        body: Container(
          padding: Width > 600
              ? EdgeInsets.symmetric(horizontal: Width / 4)
              : const EdgeInsets.symmetric(horizontal: 5),
          child: Form(
            key: _formkey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),

                TextFieldInput(
                  hintText: 'Enter Asseser Name',
                  textInputType: TextInputType.text,
                  textEditingController: nameOfAsseser,

                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldInput(
                  hintText: 'Enter Division/Range',
                  textInputType: TextInputType.text,
                  textEditingController: Division,

                ),
                const SizedBox(
                  height: 10,
                ),
             TextFieldInput(
                  hintText: 'Enter OIO NO. & Date',
                  textInputType: TextInputType.text,
                  textEditingController: OIONOAndDate,

                ),
                const SizedBox(
                  height: 10,
                ),
             TextFieldInput(
                  hintText: 'Enter Total Duty of Arrear',
                  textInputType: TextInputType.text,
                  textEditingController: TotalDutyOfArear,

                ),
                const SizedBox(
                  height: 10,
                ),
             TextFieldInput(
                  hintText: 'Enter Penalty',
                  textInputType: TextInputType.text,
                  textEditingController: Penlty,

                ),
                const SizedBox(
                  height: 10,
                ),
             TextFieldInput(
                  hintText: 'Enter Amount recoverd',
                  textInputType: TextInputType.text,
                  textEditingController: AmmountRecoverSofar,

                ),
                const SizedBox(
                  height: 10,
                ),
             TextFieldInput(
                  hintText: 'Enter Pre-deposit (If any)',
                  textInputType: TextInputType.text,
                  textEditingController: PredepositIfAny,

                ),
                const SizedBox(
                  height: 10,
                ),
             TextFieldInput(
                  hintText: 'Enter Total Arrears Pending',
                  textInputType: TextInputType.text,
                  textEditingController: TotalArearsForPending,

                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldInput(
                  hintText: 'Enter Brief facts of the case',
                  textInputType: TextInputType.text,
                  textEditingController: BrifFectOftheCase,

                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldInput(
                  hintText: 'Enter Present status of the case (recovered or pending)',
                  textInputType: TextInputType.text,
                  textEditingController: PresentStatusOfCase,

                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                  hintText: 'Enter Appeal No',
                  textInputType: TextInputType.text,
                  textEditingController: ApealNo,

                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                  hintText: 'Enter Stay Order NO and Date',
                  textInputType: TextInputType.text,
                  textEditingController: StayOrderNoAndDate,

                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                  hintText: 'Enter Remark',
                  maxlines: 4,
                  textInputType: TextInputType.text,
                  textEditingController: PresentStatusOfCase,

                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                    onPressed: (){
                  adddetail();
                }, child: Text("Submit",style: TextStyle(color: Colors.white),)),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }

}