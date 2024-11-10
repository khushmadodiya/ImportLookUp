import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/Provider-New/add-new-cases.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/js.dart';

typedef VoidCallback = void Function();
Widget CustomButton(
    {Color color = Colors.deepPurple,
    required text,
    required VoidCallback onpress,
    required bool isLoading}) {
  return Consumer<AddNewCase>(
    builder: (context,pro,child)=>
     InkWell(
      onTap: !pro.isLoading?onpress:null,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: double.infinity,
          height: 40,
          alignment: Alignment.center,
          // padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(15)),
          child: !isLoading
              ? Text(
                  text.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              : const CircularProgressIndicator(
                  color: Colors.white,
                ),
        ),
      ),
    ),
  );
}
