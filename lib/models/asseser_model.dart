import 'dart:core';

class Asseser {
  final String name;
  final String division_range;
  final String OIO_and_date;
  final String Date;
  final String duty_or_arear;
  final String penalty;
  final String amount_recovered;
  String? pre_deposit;
  final String total_arrears_pending;
  final String breif_fect;
  final String status;
  final String apeal_no;
  final String stay_order_no_and_data;

  Asseser({
    required this.name,
    required this.division_range,
    required this.OIO_and_date,
    required this.Date,
    required this.duty_or_arear,
    required this.penalty,
    required this.amount_recovered,
    this.pre_deposit,
    required this.total_arrears_pending,
    required this.breif_fect,
    required this.status,
    required this.apeal_no,
    required this.stay_order_no_and_data,
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
    };
  }
}
