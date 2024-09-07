// ignore_for_file: non_constant_identifier_names

import 'dart:core';

class AcceptRequestModel {
  String? uid;
  String? name;
  String? upname;
  String? division_range;
  String? updivision_range;
  String? oio;
  String? upoio;
  String? date;
  String? update;
  String? duty_or_arear;
  String? upduty_or_arear;
  String? penalty;
  String? uppenalty;
  String? amount_recovered;
  String? upamount_recovered;
  String? pre_deposit;
  String? uppre_deposit;
  String? total_arrears_pending;
  String? uptotal_arrears_pending;
  String? brief_facts;
  String? upbrief_facts;
  String? status;
  String? upstatus;
  String? apeal_no;
  String? upapeal_no;
  String? stay_order_no_and_data;
  String? upstay_order_no_and_data;
  String? iec;
  String? upiec;
  String? gstin;
  String? upgstin;
  String? pan;
  String? uppan;
  double? age;
  double? upage;
  List<String>? complete_track;
  List<String>? upcomplete_track;
  bool? isshifted;
  bool? upisshifted;
  String? category;
  String? upcategory;
  String? remark;
  String? upremark;
  String? subcategory;
  String? upsubcategory;

  AcceptRequestModel({
    this.uid,
    this.name,
    this.upname,
    this.division_range,
    this.updivision_range,
    this.oio,
    this.upoio,
    this.date,
    this.update,
    this.duty_or_arear,
    this.upduty_or_arear,
    this.penalty,
    this.uppenalty,
    this.amount_recovered,
    this.upamount_recovered,
    this.pre_deposit,
    this.uppre_deposit,
    this.total_arrears_pending,
    this.uptotal_arrears_pending,
    this.brief_facts,
    this.upbrief_facts,
    this.status,
    this.upstatus,
    this.apeal_no,
    this.upapeal_no,
    this.stay_order_no_and_data,
    this.upstay_order_no_and_data,
    this.gstin,
    this.upgstin,
    this.iec,
    this.upiec,
    this.pan,
    this.uppan,
    this.age,
    this.upage,
    this.complete_track,
    this.upcomplete_track,
    this.isshifted,
    this.upisshifted,
    this.category,
    this.upcategory,
    this.remark,
    this.upremark,
    this.subcategory,
    this.upsubcategory,
  });

  factory AcceptRequestModel.fromJson(Map<String, dynamic> json) {
    return AcceptRequestModel(
      uid: json['uid'] as String? ?? '',
      name: json['name'] as String? ?? '',
      upname: json['upname'] as String? ?? '',
      division_range: json['division_range'] as String? ?? '',
      updivision_range: json['updivision_range'] as String? ?? '',
      oio: json['oio'] as String? ?? '',
      upoio: json['upoio'] as String? ?? '',
      date: json['date'] as String? ?? '',
      update: json['update'] as String? ?? '',
      duty_or_arear: json['duty_or_arear'] as String? ?? '',
      upduty_or_arear: json['upduty_or_arear'] as String? ?? '',
      penalty: json['penalty'] as String? ?? '',
      uppenalty: json['uppenalty'] as String? ?? '',
      amount_recovered: json['amount_recovered'] as String? ?? '',
      upamount_recovered: json['upamount_recovered'] as String? ?? '',
      pre_deposit: json['pre_deposit'] as String? ?? '',
      uppre_deposit: json['uppre_deposit'] as String? ?? '',
      total_arrears_pending: json['total_arrears_pending'] as String? ?? '',
      uptotal_arrears_pending: json['uptotal_arrears_pending'] as String? ?? '',
      brief_facts: json['brief_facts'] as String? ?? '',
      upbrief_facts: json['upbrief_facts'] as String? ?? '',
      status: json['status'] as String? ?? '',
      upstatus: json['upstatus'] as String? ?? '',
      apeal_no: json['apeal_no'] as String? ?? '',
      upapeal_no: json['upapeal_no'] as String? ?? '',
      stay_order_no_and_data: json['stay_order_no_and_data'] as String? ?? '',
      upstay_order_no_and_data: json['upstay_order_no_and_data'] as String? ?? '',
      iec: json['iec'] as String? ?? '',
      upiec: json['upiec'] as String? ?? '',
      gstin: json['gstin'] as String? ?? '',
      upgstin: json['upgstin'] as String? ?? '',
      pan: json['pan'] as String? ?? '',
      uppan: json['uppan'] as String? ?? '',
      age: (json['age'] as num?)?.toDouble() ?? 0.0,
      upage: (json['upage'] as num?)?.toDouble() ?? 0.0,
      complete_track: (json['complete_track'] as List<dynamic>?)?.map((item) => item as String).toList() ?? [],
      upcomplete_track: (json['upcomplete_track'] as List<dynamic>?)?.map((item) => item as String).toList() ?? [],
      isshifted: json['isshifted'] as bool? ?? false,
      upisshifted: json['upisshifted'] as bool? ?? false,
      category: json['category'] as String? ?? '',
      upcategory: json['upcategory'] as String? ?? '',
      remark: json['remark'] as String? ?? '',
      upremark: json['upremark'] as String? ?? '',
      subcategory: json['subcategory'] as String? ?? '',
      upsubcategory: json['upsubcategory'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'upname': upname,
      'division_range': division_range,
      'updivision_range': updivision_range,
      'oio': oio,
      'upoio': upoio,
      'date': date,
      'update': update,
      'duty_or_arear': duty_or_arear,
      'upduty_or_arear': upduty_or_arear,
      'penalty': penalty,
      'uppenalty': uppenalty,
      'amount_recovered': amount_recovered,
      'upamount_recovered': upamount_recovered,
      'pre_deposit': pre_deposit,
      'uppre_deposit': uppre_deposit,
      'total_arrears_pending': total_arrears_pending,
      'uptotal_arrears_pending': uptotal_arrears_pending,
      'brief_facts': brief_facts,
      'upbrief_facts': upbrief_facts,
      'status': status,
      'upstatus': upstatus,
      'apeal_no': apeal_no,
      'upapeal_no': upapeal_no,
      'stay_order_no_and_data': stay_order_no_and_data,
      'upstay_order_no_and_data': upstay_order_no_and_data,
      'iec': iec,
      'upiec': upiec,
      'gstin': gstin,
      'upgstin': upgstin,
      'pan': pan,
      'uppan': uppan,
      'age': age,
      'upage': upage,
      'complete_track': complete_track,
      'upcomplete_track': upcomplete_track,
      'isshifted': isshifted,
      'upisshifted': upisshifted,
      'category': category,
      'upcategory': upcategory,
      'remark': remark,
      'upremark': upremark,
      'subcategory': subcategory,
      'upsubcategory': upsubcategory,
    };
  }
}
