import 'dart:core';

class RequestCaseModel {

  Map<String,dynamic>oldData;
  String uid;
  String name;
  String formation;
  String oio;
  String date;
  String dutyOfArrear;
  String penalty;
  String amountRecovered;
  String preDeposit;
  String intrest;
  String totalArrearPending;
  String briefFact;
  String status;
  String apealNo;
  String stayOrderNumberAndDate;
  String iec;
  String gstin;
  String pan;
  double? age;
  // String dutyOfArrear,
  List<String>? completeTrack;
  bool? isshifted;
  String category;
  String effortMade;
  String remark;
  String subcategory;

  RequestCaseModel(
      {
        required this.oldData,
        required this.uid,
        required this.name,
        required this.formation,
        required this.oio,
        required this.date,
        required this.dutyOfArrear,
        required this.penalty,
        required this.intrest,
        required this.amountRecovered,
        required this.preDeposit,
        required this.totalArrearPending,
        required this.briefFact,
        required this.status,
        required this.apealNo,
        required this.stayOrderNumberAndDate,
        required this.gstin,
        required this.iec,
        required this.pan,
        this.age,
        required this.completeTrack,
        this.isshifted,
        required this.category,
        required this.remark,
        required this.subcategory,
        required this.effortMade});

  factory RequestCaseModel.fromJson(Map<String, dynamic> json) {
    return RequestCaseModel(
        oldData:json['oldData'] as Map<String,dynamic>,
        uid: json['uid'] as String? ?? '',
        name: json['name'] as String? ?? '',
        formation: json['formation'] as String? ?? '',
        oio: json['oio'] as String? ?? '',
        date: json['date'] as String? ?? '',
        dutyOfArrear: json['dutyOfArrear'] as String? ?? '',
        penalty: json['penalty'] as String? ?? '',
        amountRecovered: json['amountRecovered'] as String? ?? '',
        preDeposit: json['preDeposit'] as String? ?? '',
        totalArrearPending: json['totalArrearPending'] as String? ?? '',
        briefFact: json['briefFact'] as String? ?? '',
        status: json['status'] as String? ?? '',
        apealNo: json['apealNo'] as String? ?? '',
        stayOrderNumberAndDate: json['stayOrderNumberAndDate'] as String? ?? '',
        iec: json['iec'] as String? ?? '',
        gstin: json['gstin'] as String? ?? '',
        pan: json['pan'] as String? ?? '',
        age: (json['age'] as num?)?.toDouble() ?? 0.0,
        completeTrack: (json['completeTrack'] as List<dynamic>?)
            ?.map((item) => item as String)
            .toList() ?? [],
        isshifted: json['isshifted'] as bool? ?? false,
        category: json['category'] as String? ?? '',
        subcategory: json['subcategory'] as String? ?? '',
        remark: json['remark'] as String? ?? '',
        effortMade: json['effortMade'] as String? ?? '',
        intrest: json['intrest'] as String? ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'oio': oio,
      'formation': formation,
      'penalty': penalty,
      'amountRecovered': amountRecovered,
      'preDeposit': preDeposit,
      'totalArrearPending': totalArrearPending,
      'briefFact': briefFact,
      'status': status,
      'apealNo': apealNo,
      'stayOrderNumberAndDate': stayOrderNumberAndDate,
      'iec': iec,
      'gstin': gstin,
      'pan': pan,
      'age': age,
      'completeTrack': completeTrack,
      'isshifted': isshifted,
      'category': category,
      'subcategory': subcategory,
      'remark': remark,
      'effortMade': effortMade,
      'intrest': intrest,
      'oldData':oldData,
      "date":date,
      "dutyOfArrear":dutyOfArrear
    };
  }

}