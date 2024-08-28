// ignore_for_file: non_constant_identifier_names

import 'dart:core';


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
  String? apeal_no;
  String? stay_order_no_and_data;
  String? iec;
  String? gstin;
  String? pan;
  double? age;
  List<String>? complete_track;
  bool? isshifted;
  String? category;
  String? remark;
  String? subcategory;

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
    this.apeal_no,
    this.stay_order_no_and_data,
    this.gstin,
    this.iec,
    this.pan,
    this.age,
    this.complete_track,
    this.isshifted,
    this.category,
    this.remark,
    this.subcategory
  });

  
  factory Asseser.fromJson(Map<String, dynamic> json) {
    return Asseser(
      uid:json['uid'] as String? ??'',
      name: json['name'] as String? ?? '',
      division_range: json['division_range'] as String? ?? '',
      oio: json['oio'] as String? ?? '',
      date: json['date'] as String? ?? '',
      duty_or_arear: json['duty_or_arear'] as String? ?? '',
      penalty: json['penalty'] as String? ?? '',
      amount_recovered: json['amount_recovered'] as String? ?? '',
      pre_deposit: json['pre_deposit'] as String? ?? '',
      total_arrears_pending: json['total_arrears_pending'] as String? ?? '',
      brief_facts: json['brief_facts'] as String? ?? '',
      status: json['status'] as String? ?? '',
      apeal_no: json['apeal_no'] as String? ?? '',
      stay_order_no_and_data: json['stay_order_no_and_data'] as String? ?? '',
      iec: json['iec'] as String? ?? '',
      gstin: json['gstin'] as String? ?? '',
      pan: json['pan'] as String? ?? '',
      age: (json['age'] as num?)?.toDouble() ?? 0.0, // Convert to double and handle null
      complete_track: (json['complete_track'] as List<dynamic>?)?.map((item) => item as String).toList() ?? [], // Convert List<dynamic> to List<String> and handle null
      isshifted: json['Isshifted'] as bool? ?? false, // Handle null for boolean
      category: json['category'] as String? ?? '',
      subcategory: json['subcategory'] as String? ?? '',
      remark: json['remark'] as String? ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'division_range': division_range,
      'oio': oio,
      'date':date,
      'duty_or_arear': duty_or_arear,
      'penalty': penalty,
      'amount_recovered': amount_recovered,
      'pre_deposit': pre_deposit,
      'total_arrears_pending': total_arrears_pending,
      'brief_facts': brief_facts,
      'status': status,
      'apeal_no': apeal_no,
      'stay_order_no_and_data': stay_order_no_and_data,
      'iec': iec,
      'gstin': gstin,
      'pan': pan,
      'age':age,
      'complete_track':complete_track,
      'isshifted':isshifted,
      'category':category,
      'subcategory':subcategory,
      'remark': remark
    };
  }
}
