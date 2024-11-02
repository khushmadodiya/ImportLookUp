import 'package:flutter/material.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
import 'package:import_lookup/Widgets/Widgets-New/custom-textfield.dart';
import 'package:import_lookup/Widgets/custom-button.dart';
import 'package:provider/provider.dart';

import '../../Model-New/main-case-model.dart';

class DisposalScreen extends StatelessWidget {
   MainCaseModel model;
   DisposalScreen({super.key,required this.model});

  List<String> disposalValues = ['In favor of Department','Against Department','Order of Denovo','Arrear Transfor to other formation'];

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralPurposeProvider>(
      builder: (context,pro,child)=>
      Scaffold(
        appBar: AppBar(
         title: Text('Disposal'),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width*.5,
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
                    _dispose();
                  }, isLoading: false),
                )

              ],
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

   _dispose()async{

   }
}

