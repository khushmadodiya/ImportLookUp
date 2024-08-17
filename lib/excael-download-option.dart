// ignore_for_file: file_names

import 'dart:convert';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;

class ExcelDonwloadOption{
  Future<void> exportToExcel(List<Map<String,dynamic>>myList,String excelFor) async {
    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];
    // Set headers in the first row
sheet.getRangeByIndex(1, 1).setText("UID");
sheet.getRangeByIndex(1, 2).setText("Name");
sheet.getRangeByIndex(1, 3).setText("Division Range");
sheet.getRangeByIndex(1, 4).setText("OIO");
sheet.getRangeByIndex(1, 5).setText("Date");
sheet.getRangeByIndex(1, 6).setText("Duty or Arrear");
sheet.getRangeByIndex(1, 7).setText("Penalty");
sheet.getRangeByIndex(1, 8).setText("Amount Recovered");
sheet.getRangeByIndex(1, 9).setText("Pre Deposit");
sheet.getRangeByIndex(1, 10).setText("Total Arrears Pending");
sheet.getRangeByIndex(1, 11).setText("Brief Facts");
sheet.getRangeByIndex(1, 12).setText("Status");
sheet.getRangeByIndex(1, 13).setText("Appeal No");
sheet.getRangeByIndex(1, 14).setText("Stay Order No and Date");
sheet.getRangeByIndex(1, 15).setText("GSTIN");
sheet.getRangeByIndex(1, 16).setText("IEC");
sheet.getRangeByIndex(1, 17).setText("PAN");
sheet.getRangeByIndex(1, 18).setText("Age");
sheet.getRangeByIndex(1, 19).setText("Complete Track");
sheet.getRangeByIndex(1, 20).setText("Is Shifted");
sheet.getRangeByIndex(1, 21).setText("Category");
sheet.getRangeByIndex(1, 22).setText("Remark");
sheet.getRangeByIndex(1, 23).setText("Subcategory");

// Populate the data rows starting from the second row
for (var i = 0; i < myList.length; i++) {
  final item = myList[i]; // Assuming item is a map-like object

  sheet.getRangeByIndex(i + 2, 1).setText(item["uid"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 2).setText(item["name"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 3).setText(item["division_range"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 4).setText(item["oio"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 5).setText(item["date"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 6).setText(item["duty_or_arear"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 7).setText(item["penalty"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 8).setText(item["amount_recovered"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 9).setText(item["pre_deposit"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 10).setText(item["total_arrears_pending"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 11).setText(item["brief_facts"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 12).setText(item["status"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 13).setText(item["apeal_no"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 14).setText(item["stay_order_no_and_data"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 15).setText(item["gstin"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 16).setText(item["iec"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 17).setText(item["pan"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 18).setText(item["age"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 19).setText(item["complete_track"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 20).setText(item["isshifted"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 21).setText(item["category"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 22).setText(item["remark"]?.toString() ?? '');
  sheet.getRangeByIndex(i + 2, 23).setText(item["subcategory"]?.toString() ?? '');
}


    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if (kIsWeb) {
      AnchorElement(
          href:
              'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', '$excelFor.xlsx')
        ..click();
    } else {}
  }
}