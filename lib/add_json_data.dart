import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/global.dart';
import 'package:uuid/uuid.dart';
class PushJson extends StatelessWidget {
  const PushJson({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Push Data to Firebase')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            pushDataToFirebase();
          },
          child: Text('Push Data'),
        ),
      ),
    );
  }
}
// Define the Asseser class
class Asseser {
  String? uid;
  String? name;
  String? division_range;
  String? oio;
  String? date;
  String? duty_or_arear;
  String? penalty;
  String? amount_recovered;
  String? pre_deposit;
  String? total_arrears_pending;
  String? brief_facts;
  String? status;
  String? iec;
  String? gstin;
  String? pan;
  String? category;
  String? subcategory;
  String? remark;
  String? apeal_no;
  String? stay_order_no_and_data;
  // String? age;
  List<String>? complete_track;
  bool? isshifted;

  Asseser({
    this.uid,
    this.name,
    this.division_range,
    this.oio,
    this.date,
    this.duty_or_arear,
    this.penalty,
    this.amount_recovered,
    this.pre_deposit,
    this.total_arrears_pending,
    this.brief_facts,
    this.status,
    this.iec,
    this.gstin,
    this.pan,
    this.category,
    this.subcategory,
    this.remark,
    this.apeal_no,
    this.stay_order_no_and_data,
    // this.age,
    this.complete_track,
    this.isshifted,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'division_range': division_range,
      'oio': oio,
      'date': date,
      'duty_or_arear': duty_or_arear,
      'penalty': penalty,
      'amount_recovered': amount_recovered,
      'pre_deposit': pre_deposit,
      'total_arrears_pending': total_arrears_pending,
      'brief_facts': brief_facts,
      'status': status,
      'iec': iec,
      'gstin': gstin,
      'pan': pan,
      'category': category,
      'subcategory': subcategory,
      'remark': remark,
      'apeal_no': apeal_no,
      'stay_order_no_and_data': stay_order_no_and_data,
      // 'age': age,
      'complete_track': complete_track,
      'isshifted': isshifted,
    };
  }
}

// Function to push data to Firebase
void pushDataToFirebase() {
  var uuid = Uuid();

  List<Asseser> assesers = [
    Asseser(
      uid: uuid.v4(),
      name: "M/s Mantram Technofab Private Limited",
      division_range: "ICD Tihi",
      oio: "02/License/Advance/AC/ICD/Tihi/2024-25/ Dated. 18.04.2024",
      date: "18.04.2024",
      duty_or_arear: "300000",
      penalty: "0",
      amount_recovered: "0",
      pre_deposit: "0",
      total_arrears_pending: "300000",
      brief_facts: "The Party has failed to discharge export obligation against Advance Licences",
      status: "Within appeal period",
      iec: "",
      gstin: "",
      pan: "",
      category: selectedcategory,
      subcategory: "",
      remark: "",
      apeal_no: "",
      stay_order_no_and_data: "",
      // age: "",
      complete_track: ["18.04.2024 OIO is filed"],
      isshifted: false,
    ),
    Asseser(
      uid: uuid.v4(),
      name: "M/s Narsim Bags Pvt. Ltd",
      division_range: "ICD Tihi",
      oio: "03/License/Advance/AC/ICD/Tihi/2024-25 Dated. 18.04.2024",
      date: "18.04.2024",
      duty_or_arear: "200000",
      penalty: "0",
      amount_recovered: "0",
      pre_deposit: "0",
      total_arrears_pending: "200000",
      brief_facts: "The Party has failed to discharge export obligation against Advance Licences",
      status: "Within appeal period",
      iec: "",
      gstin: "",
      pan: "",
      category: selectedcategory,
      subcategory: "",
      remark: "",
      apeal_no: "",
      stay_order_no_and_data: "",
      // age: "",
      complete_track: ["18.04.2024 OIO is filed"],
      isshifted: false,
    ),
    Asseser(
      uid: uuid.v4(),
      name: "M/s Masterplast India Private Limited",
      division_range: "ICD Tihi",
      oio: "04/License/Advance/AC/ICD/Tihi/2024-25 Dated. 18.04.2024",
      date: "18.04.2024",
      duty_or_arear: "200000",
      penalty: "0",
      amount_recovered: "0",
      pre_deposit: "0",
      total_arrears_pending: "200000",
      brief_facts: "The Party has failed to discharge export obligation against Advance Licences",
      status: "Within appeal period",
      iec: "",
      gstin: "",
      pan: "",
      category: selectedcategory,
      subcategory: "",
      remark: "",
      apeal_no: "",
      stay_order_no_and_data: "",
      // age: "",
      complete_track: ["18.04.2024 OIO is filed"],
      isshifted: false,
    ),
    Asseser(
      uid: uuid.v4(),
      name: "M/s Hakimi Rope Industries LLP",
      division_range: "ICD Tihi",
      oio: "08/License/Advance/AC/ICD/Tihi/2024-25 dated 20.04.2024",
      date: "20.04.2024",
      duty_or_arear: "200000",
      penalty: "0",
      amount_recovered: "0",
      pre_deposit: "0",
      total_arrears_pending: "200000",
      brief_facts: "The Party has failed to discharge export obligation against Advance Licences",
      status: "Within appeal period",
      iec: "",
      gstin: "",
      pan: "",
      category: selectedcategory,
      subcategory: '',
      remark: "",
      apeal_no: "",
      stay_order_no_and_data: "",
      // age: "",
      complete_track: ["20.04.2024 OIO is filed"],
      isshifted: false,
    ),
    Asseser(
      uid: uuid.v4(),
      name: "M/s Hakimi Rope Industries LLP",
      division_range: "ICD Tihi",
      oio: "07/License/Advance/AC/ICD/Tihi/2024-25 dated 19.04.2024",
      date: "19.04.2024",
      duty_or_arear: "200000",
      penalty: "0",
      amount_recovered: "0",
      pre_deposit: "0",
      total_arrears_pending: "200000",
      brief_facts: "The Party has failed to discharge export obligation against Advance Licences",
      status: "Within appeal period",
      iec: "",
      gstin: "",
      pan: "",
      category: selectedcategory,
      subcategory: "",
      remark: "",
      apeal_no: "",
      stay_order_no_and_data: "",
      // age: "",
      complete_track: ["19.04.2024 OIO is filed"],
      isshifted: false,
    ),
    Asseser(
      uid: uuid.v4(),
      name: "M/s Bulkpack Exports Limited",
      division_range: "ICD Tihi",
      oio: "10/License/Advance/AC/ICD/Tihi/2024-25 dated 23.04.2024",
      date: "23.04.2024",
      duty_or_arear: "200000",
      penalty: "0",
      amount_recovered: "0",
      pre_deposit: "0",
      total_arrears_pending: "200000",
      brief_facts: "The Party has failed to discharge export obligation against Advance Licences",
      status: "Within appeal period",
      iec: "",
      gstin: "",
      pan: "",
      category: selectedcategory,
      subcategory: "",
      remark: "",
      apeal_no: "",
      stay_order_no_and_data: "",
      // age: "",
      complete_track: ["23.04.2024 OIO is filed"],
      isshifted: false,
    ),
  ];

  CollectionReference collection = FirebaseFirestore.instance.collection('assesers');

  for (Asseser asseser in assesers) {
    collection.add(asseser.toJson()).then((value) {
      print("Document added with ID: ${value.id}");
    }).catchError((error) {
      print("Error adding document: $error");
    });
  }
}
