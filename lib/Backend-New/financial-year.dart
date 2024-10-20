
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:import_lookup/Backend-New/tar-report.dart';
import 'package:intl/intl.dart';

class FinancialYear {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> financialYear({
    required String currentMonth,
    bool isUpdate = false,
  }) async {
    try {
      DocumentSnapshot snap =
          await firebaseFirestore.collection("MP").doc("financial year").get();

      // Get the current date
      DateTime now = DateTime.now();

      String currentFinancialYearStart =
          "1-April-${DateFormat('yyyy').format(now)}";
      String currentFinancialYearEnd =
          "31-March-${((DateTime(DateTime.now().year + 1)).toString().substring(0, 4))}";

      if (snap.exists) {
        Map<String, dynamic> data = snap.data() as Map<String, dynamic>;

        // Check if current month in Firestore matches the current month
        if (data["current month"] != currentMonth) {
          var res = await TarReportInformation().transferCasesUpTheMonth(
              category: '', subcategory: '', docName: '');
          // Update current month if it doesn't match
          if (res["res"] == "success") {
            await firebaseFirestore
                .collection("MP")
                .doc("financial year")
                .update({
              "current month": currentMonth,
            });
            return {"res": "sucess"};
          } else {
            return {"res": "some error occuured"};
          }
        }

        // Check if the current date is beyond the financial year end
        DateTime financialYearEndDate =
            DateFormat('dd-MMMM-yyyy').parse(data["financial year end date"]);
        if (now.isAfter(financialYearEndDate)) {
          // Update financial year and current month
          var res = await TarReportInformation()
              .transferCasesYear(category: '', subcategory: '', docName: '');
          if (res["res"] == "success") {
            await firebaseFirestore
                .collection("MP")
                .doc("financial year")
                .update({
              "financial year start date": currentFinancialYearStart,
              "financial year end date": currentFinancialYearEnd,
              "current month": currentMonth,
            });
            return {"res": "sucess"};
          } else {
            return {"res": "some error occured"};
          }
        }
      } else {
        await firebaseFirestore.collection("MP").doc("financial year").set({
          "current month": currentMonth,
          "financial year start date": currentFinancialYearStart,
          "financial year end date": currentFinancialYearEnd,
        });
      }

      return {"res": "success"};
    } catch (e) {
      return {"res": "some error occurred ${e.toString()}"};
    }
  }
}
