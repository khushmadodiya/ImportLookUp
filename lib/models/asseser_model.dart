import 'dart:core';
import 'dart:ffi';

class Asseser {
  String? name;
  String? division_range;
  String? OIO_and_date;
  String? Date;
  String? duty_or_arear;
  String? penalty;
  String? amount_recovered;
  String? pre_deposit;
  String? total_arrears_pending;
  String? breif_fect;
  String? status;
  String? apeal_no;
  String? stay_order_no_and_data;
  String? IEC;
  String? GSTIN;
  String? PAN;
  Double? Age;
  List<String>? complete_track;
  Bool? isshifted;
  String? category;

  Asseser({
    this.name,
    this.division_range,
    this.OIO_and_date,
    this.Date,
    this.duty_or_arear,
    this.penalty,
    this.amount_recovered,
    this.pre_deposit,
    this.total_arrears_pending,
    this.breif_fect,
    this.status,
    this.apeal_no,
    this.stay_order_no_and_data,
    this.GSTIN,
    this.IEC,
    this.PAN,
    this.Age,
    this.complete_track,
    this.isshifted,
    this.category
  });

  factory Asseser.fromJson(Map<String, dynamic> json) {
    return Asseser(
      name: json['name'] as String,
      division_range: json['division_range'] as String,
      OIO_and_date: json['OIO_and_date'] as String,
      Date: json['Date']as String,
      duty_or_arear: json['duty_or_arear'] as String,
      penalty: json['penalty'] as String,
      amount_recovered: json['amount_recovered'] as String,
      pre_deposit: json['pre_deposit'] as String?,
      total_arrears_pending: json['total_arrears_pending'] as String,
      breif_fect: json['breif_fect'] as String,
      status: json['status'] as String,
      apeal_no: json['apeal_no'] as String,
      stay_order_no_and_data: json['stay_order_no_and_data'] as String,
      IEC: json['IEC'] as String,
      GSTIN: json['GSTIN'] as String,
      PAN: json['PAN'] as String,
      Age: json['Age'] as Double,
      complete_track: json['complete_track'] as List<String>,
      isshifted: json['Isshifted'] as Bool,
      category: json['category']as String

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'division_range': division_range,
      'OIO_and_date': OIO_and_date,
      'Date':Date,
      'duty_or_arear': duty_or_arear,
      'penalty': penalty,
      'amount_recovered': amount_recovered,
      'pre_deposit': pre_deposit,
      'total_arrears_pending': total_arrears_pending,
      'breif_fect': breif_fect,
      'status': status,
      'apeal_no': apeal_no,
      'stay_order_no_and_data': stay_order_no_and_data,
      'IEC': IEC,
      'GSTIN': GSTIN,
      'PAN': PAN,
      'Age':Age,
      'complete_track':[],
      'isshifted':isshifted,
      'category':category

    };
  }
}
