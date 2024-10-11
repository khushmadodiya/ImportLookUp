

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
typedef VoidCallback = void Function();
Widget CustomButton({
  required text,
  required VoidCallback onpress ,required bool isLoading
}){
  return InkWell(
    onTap: onpress,
    child: Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Container(
        width: double.infinity,
        height: 40,
        alignment: Alignment.center,
        // padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(15)

        ),
        child: !isLoading
            ?  Text(
          text.toString(),
          style: TextStyle(color: Colors.white, fontSize: 16),
        )
            : const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    ),
  );
}