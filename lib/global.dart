
import 'dart:core';

String selectedcategory = "Arrear where appeal period is not over";
String value1 = "Air Cargo Complex Indore";
String value2 = "Customs Circle Bhopal";
String value3 = "Customs Circle Indore";
String value4 = "Customs Circle Raipur";
String value5 = "Customs Circle Ujjain";
String value6 = "Customs Circle Jabalpur";
String value7 = "Customs Hqrs Indore";
String value8 = "DABH International Airport Indore";
String value9 = "ICD Kheda";
String value10 = "ICD Malanpur";
String value11= "ICD Mandideep ";
String value12= "ICD Powerkheda ";
String value13 = "ICD Raipur";
String value14  = "ICD Tihi";
//
String selecteditem = value1;

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) return input; // Handle empty strings
  String output= '${input[0].toUpperCase()}${input.substring(1)}';
  print(output);
  return output;
}
