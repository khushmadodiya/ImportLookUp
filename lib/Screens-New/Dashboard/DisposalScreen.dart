import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Backend-New/main-cases-details.dart';
import 'package:import_lookup/Provider-New/add-new-cases.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
import 'package:import_lookup/Widgets/Widgets-New/custom-textfield.dart';
import 'package:import_lookup/Widgets/custom-button.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/js.dart';

import '../../Model-New/main-case-model.dart';

class DisposalScreen extends StatelessWidget {
   MainCaseModel model;
   DisposalScreen({super.key,required this.model});

  List<String> disposalValues =  [
    "disposal in favour of the department",
    "disposal against the department",
    "disposal order for denovo",
    "disposal formations changed",
    "arrearss realised"
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewCase>(
      builder: (context, provider,child)=>
       Consumer<GeneralPurposeProvider>(
        builder: (context,pro,child)=>
        Scaffold(
          appBar: AppBar(
           title: Text('Disposal'),
          ),
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width>600?MediaQuery.of(context).size.width*.5:double.infinity,
              child: Column(

                children: [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: disposalValues.map((value) {
                      return RadioListTile<String>(
                        title: Text(value),
                        value: value,
                        groupValue: pro.selectedDisposalValue,
                        onChanged: (value) {
                          pro.updateSelectedDisposlaValue(value!);
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20,),
                  CustomText('Name ${model.name}'),
                  SizedBox(height: 20,),
                  CustomText('OIO ${model.oio}'),
                  SizedBox(height: 20,),
                  CustomText('Ammount ${model.totalArrearPending}'),
                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 200.0),
                    child: CustomButton(text: 'Dispose', onpress: (){
                      dispose(context,);
                    }, isLoading: provider.isLoading),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomText(String text){
    return Card(
      color: Colors.deepPurple[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 55,
        width:double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.deepPurple[50]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 30),
          child: Text(text,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        )
      ),
    );
  }

   dispose(BuildContext context)async{
     GeneralPurposeProvider userInfo= Provider.of<GeneralPurposeProvider>(context,listen: false);
     var pro= Provider.of<AddNewCase>(context,listen: false);
            pro.updateLoader();
            var res =   await MainCasesInformation().deleteMainCase(formation: model.formation, uid:model.uid,docName: userInfo. selectedDisposalValue);
            pro.updateLoader();
            if(res['res']=='success'){
              Fluttertoast.showToast(msg: "Disposed",timeInSecForIosWeb: 3);
              Navigator.pop(context);
            }
            print('This is khush ${res['res']}');
   }
}

