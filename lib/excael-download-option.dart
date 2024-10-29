// ignore_for_file: file_names

import 'dart:convert';
import 'package:import_lookup/Model-New/main-case-model.dart';
import 'package:universal_html/html.dart' show AnchorElement, File;
import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;

class ExcelDonwloadOption {
  final xcel.Workbook workbook = xcel.Workbook();

  Future<void> exportToExcel(List<MainCaseModel>myList, String excelFor) async {
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

      sheet.getRangeByIndex(i + 2, 1).setText(item.uid.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 2).setText(item.name.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 3).setText(item.formation.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 4).setText(item.oio.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 5).setText(item.date.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 6).setText(
          item.dutyOfArrear.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 7).setText(item.penalty.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 8).setText(
          item.amountRecovered.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 9).setText(item.preDeposit.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 10).setText(
          item.totalArrearPending.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 11).setText(item.briefFact.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 12).setText(item.status.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 13).setText(item.apealNo.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 14).setText(
          item.stayOrderNumberAndDate.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 15).setText(item.gstin.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 16).setText(item.iec.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 17).setText(item.pan.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 18).setText(item.age.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 19).setText(
          item.completeTrack?.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 20).setText(item.isshifted.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 21).setText(item.category.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 22).setText(item.remark.toString() ?? '');
      sheet.getRangeByIndex(i + 2, 23).setText(
          item.subcategory.toString() ?? '');
    }


    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if (kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64
              .encode(bytes)}')
        ..setAttribute('download', '$excelFor.xlsx')
        ..click();
    } else {}
  }

  Future<void> downloadExcelForTar(List<List<String>> myList, String excelFor) async {
    final xcel.Worksheet sheet = workbook.worksheets[0];

    // Merge cells and set text for headers in the first row, and center the text
    sheet.getRangeByIndex(1, 4, 1, 7).merge();
    sheet.getRangeByIndex(1, 4).setText('Receipt');
    sheet.getRangeByIndex(1, 4).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(1, 10, 1, 13).merge();
    sheet.getRangeByIndex(1, 10).setText('Decided Fully/Partially in favor');
    sheet.getRangeByIndex(1, 10).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(1, 14, 1, 17).merge();
    sheet.getRangeByIndex(1, 14).setText('Decided Fully/Partially against');
    sheet.getRangeByIndex(1, 14).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(1, 18, 1, 21).merge();
    sheet.getRangeByIndex(1, 18).setText('Order of Denovo');
    sheet.getRangeByIndex(1, 18).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(1, 22, 1, 25).merge();
    sheet.getRangeByIndex(1, 22).setText('Arrears Transferred to other formation');
    sheet.getRangeByIndex(1, 22).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(1, 26, 1, 29).merge();
    sheet.getRangeByIndex(1, 26).setText('Arrears Realised');
    sheet.getRangeByIndex(1, 26).cellStyle.hAlign = xcel.HAlignType.center;

    // Merge cells and set text for headers in the second row, and center the text
    sheet.getRangeByIndex(1, 2, 1, 3).merge();
    sheet.getRangeByIndex(1, 2).setText('Opening Balance');
    sheet.getRangeByIndex(1, 2).cellStyle.hAlign = xcel.HAlignType.center;


    sheet.getRangeByIndex(2, 4, 2, 5).merge();
    sheet.getRangeByIndex(2, 4).setText('During the month');
    sheet.getRangeByIndex(2, 4).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(2, 6, 2, 7).merge();
    sheet.getRangeByIndex(2, 6).setText('Upto the month');
    sheet.getRangeByIndex(2, 6).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(1, 8, 1, 9).merge();
    sheet.getRangeByIndex(1, 8).setText('Total');
    sheet.getRangeByIndex(1, 8).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(2, 10, 2, 11).merge();
    sheet.getRangeByIndex(2, 10).setText('During the month');
    sheet.getRangeByIndex(2, 10).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(2, 12, 2, 13).merge();
    sheet.getRangeByIndex(2, 12).setText('Upto the month');
    sheet.getRangeByIndex(2, 12).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(2, 14, 2, 15).merge();
    sheet.getRangeByIndex(2, 14).setText('During the month');
    sheet.getRangeByIndex(2, 14).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(2, 16, 2, 17).merge();
    sheet.getRangeByIndex(2, 16).setText('Upto the month');
    sheet.getRangeByIndex(2, 16).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(2, 18, 2, 19).merge();
    sheet.getRangeByIndex(2, 18).setText('During the month');
    sheet.getRangeByIndex(2, 18).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(2, 20, 2, 21).merge();
    sheet.getRangeByIndex(2, 20).setText('Upto the month');
    sheet.getRangeByIndex(2, 20).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(2, 22, 2, 23).merge();
    sheet.getRangeByIndex(2, 22).setText('During the month');
    sheet.getRangeByIndex(2, 22).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(2, 24, 2, 25).merge();
    sheet.getRangeByIndex(2, 24).setText('Upto the month');
    sheet.getRangeByIndex(2, 24).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(2, 26, 2, 27).merge();
    sheet.getRangeByIndex(2, 26).setText('During the month');
    sheet.getRangeByIndex(2, 26).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(2, 28, 2, 29).merge();
    sheet.getRangeByIndex(2, 28).setText('Upto the month');
    sheet.getRangeByIndex(2, 28).cellStyle.hAlign = xcel.HAlignType.center;

    sheet.getRangeByIndex(1, 30, 1, 31).merge();
    sheet.getRangeByIndex(1, 30).setText('Closing Balance');
    sheet.getRangeByIndex(1, 30).cellStyle.hAlign = xcel.HAlignType.center;

    // Set headers for the third row
    sheet.getRangeByIndex(1, 1).setText("Litigation");
    sheet.getRangeByIndex(3, 2).setText("No");
    sheet.getRangeByIndex(3, 3).setText("Amount");
    sheet.getRangeByIndex(3, 4).setText("NO");
    sheet.getRangeByIndex(3, 6).setText("NO");
    sheet.getRangeByIndex(3, 5).setText("Amount");
    sheet.getRangeByIndex(3, 7).setText("Amount");
    sheet.getRangeByIndex(3, 8).setText("NO");
    sheet.getRangeByIndex(3, 9).setText("Amount");
    sheet.getRangeByIndex(3, 10).setText("NO");
    sheet.getRangeByIndex(3, 12).setText("NO");
    sheet.getRangeByIndex(3, 11).setText("Amount");
    sheet.getRangeByIndex(3, 13).setText("Amount");
    sheet.getRangeByIndex(3, 14).setText("NO");
    sheet.getRangeByIndex(3, 16).setText("NO");
    sheet.getRangeByIndex(3, 15).setText("Amount");
    sheet.getRangeByIndex(3, 17).setText("Amount");
    sheet.getRangeByIndex(3, 18).setText("NO");
    sheet.getRangeByIndex(3, 20).setText("NO");
    sheet.getRangeByIndex(3, 19).setText("Amount");
    sheet.getRangeByIndex(3, 21).setText("Amount");
    sheet.getRangeByIndex(3, 22).setText("NO");
    sheet.getRangeByIndex(3, 24).setText("NO");
    sheet.getRangeByIndex(3, 23).setText("Amount");
    sheet.getRangeByIndex(3, 25).setText("Amount");
    sheet.getRangeByIndex(3, 26).setText("NO");
    sheet.getRangeByIndex(3, 28).setText("NO");
    sheet.getRangeByIndex(3, 27).setText("Amount");
    sheet.getRangeByIndex(3, 29).setText("Amount");
    sheet.getRangeByIndex(3, 30).setText("NO");
    sheet.getRangeByIndex(3, 31).setText("Amount");

    // Populate the data rows starting from the fourth row
    for (var i = 0; i < myList.length; i++) {
      final item = myList[i];

      sheet.getRangeByIndex(i + 4, 1).setText(item[0] ?? '');
      sheet.getRangeByIndex(i + 4, 2).setText(item[1] ?? '');
      sheet.getRangeByIndex(i + 4, 3).setText(item[2] ?? '');
      sheet.getRangeByIndex(i + 4, 4).setText(item[3] ?? '');
      sheet.getRangeByIndex(i + 4, 5).setText(item[4] ?? '');
      sheet.getRangeByIndex(i + 4, 6).setText(item[5] ?? '');
      sheet.getRangeByIndex(i + 4, 7).setText(item[6] ?? '');
      sheet.getRangeByIndex(i + 4, 8).setText(item[7] ?? '');
      sheet.getRangeByIndex(i + 4, 9).setText(item[8] ?? '');
      sheet.getRangeByIndex(i + 4, 10).setText(item[9] ?? '');
      sheet.getRangeByIndex(i + 4, 11).setText(item[10] ?? '');
      sheet.getRangeByIndex(i + 4, 12).setText(item[11] ?? '');
      sheet.getRangeByIndex(i + 4, 13).setText(item[12] ?? '');
      sheet.getRangeByIndex(i + 4, 14).setText(item[13] ?? '');
      sheet.getRangeByIndex(i + 4, 15).setText(item[14] ?? '');
      sheet.getRangeByIndex(i + 4, 16).setText(item[15] ?? '');
      sheet.getRangeByIndex(i + 4, 17).setText(item[16] ?? '');
      sheet.getRangeByIndex(i + 4, 18).setText(item[17] ?? '');
      sheet.getRangeByIndex(i + 4, 19).setText(item[18] ?? '');
      sheet.getRangeByIndex(i + 4, 20).setText(item[19] ?? '');
      sheet.getRangeByIndex(i + 4, 21).setText(item[20] ?? '');
      sheet.getRangeByIndex(i + 4, 22).setText(item[21] ?? '');
      sheet.getRangeByIndex(i + 4, 23).setText(item[22] ?? '');
      sheet.getRangeByIndex(i + 4, 24).setText(item[23] ?? '');
      sheet.getRangeByIndex(i + 4, 25).setText(item[24] ?? '');
      sheet.getRangeByIndex(i + 4, 26).setText(item[25] ?? '');
      sheet.getRangeByIndex(i + 4, 27).setText(item[26] ?? '');
      sheet.getRangeByIndex(i + 4, 28).setText(item[27] ?? '');
      sheet.getRangeByIndex(i + 4, 29).setText(item[28] ?? '');
      sheet.getRangeByIndex(i + 4, 30).setText(item[29] ?? '');
      sheet.getRangeByIndex(i + 4, 31).setText(item[30] ?? '');

    }

    // Save the workbook
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if (kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64
              .encode(bytes)}')
        ..setAttribute('download', '$excelFor.xlsx')
        ..click();
    } else {}
  }

}