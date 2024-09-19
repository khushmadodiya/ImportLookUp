import 'dart:core';

class RequestCaseModel {
  
   Map<String,dynamic>oldData;
  String uid;
  String upname;
  String upformation;
  String upoio;
  String update;
  String updutyOfArrear;
  String uppenalty;
  String upamountRecovered;
  String uppreDeposit;
  String upintrest;
  String uptotalArrearPending;
  String upbriefFact;
  String upstatus;
  String upapealNo;
  String upstayOrderNumberAndDate;
  String upiec;
  String upgstin;
  String uppan;
  double? upage;
  // String updutyOfArrear,
  List<String>? upcompleteTrack;
  bool? upisshifted;
  String upcategory;
  String upeffortMade;
  String upremark;
  String upsubcategory;

  RequestCaseModel(
      {
      required this.oldData,  
      required this.uid,
      required this.upname,
      required this.upformation,
      required this.upoio,
      required this.update,
      required this.updutyOfArrear,
      required this.uppenalty,
      required this.upintrest,
      required this.upamountRecovered,
      required this.uppreDeposit,
      required this.uptotalArrearPending,
      required this.upbriefFact,
      required this.upstatus,
      required this.upapealNo,
      required this.upstayOrderNumberAndDate,
      required this.upgstin,
      required this.upiec,
      required this.uppan,
      this.upage,
      required this.upcompleteTrack,
      this.upisshifted,
      required this.upcategory,
      required this.upremark,
      required this.upsubcategory,
      required this.upeffortMade});

  factory RequestCaseModel.fromJson(Map<String, dynamic> json) {
    return RequestCaseModel(
        oldData:json['oldData'] as Map<String,dynamic>,
        uid: json['uid'] as String? ?? '',
        upname: json['name'] as String? ?? '',
        upformation: json['formation'] as String? ?? '',
        upoio: json['oio'] as String? ?? '',
        update: json['date'] as String? ?? '',
        updutyOfArrear: json['dutyOfArrear'] as String? ?? '',
        uppenalty: json['penalty'] as String? ?? '',
        upamountRecovered: json['amountRecovered'] as String? ?? '',
        uppreDeposit: json['preDeposit'] as String? ?? '',
        uptotalArrearPending: json['totalArrearPending'] as String? ?? '',
        upbriefFact: json['briefFact'] as String? ?? '',
        upstatus: json['status'] as String? ?? '',
        upapealNo: json['apealNo'] as String? ?? '',
        upstayOrderNumberAndDate: json['stayOrderNumberAndDate'] as String? ?? '',
        upiec: json['iec'] as String? ?? '',
        upgstin: json['gstin'] as String? ?? '',
        uppan: json['pan'] as String? ?? '',
        upage: (json['age'] as num?)?.toDouble() ?? 0.0,
        upcompleteTrack: (json['completeTrack'] as List<dynamic>?)
                ?.map((item) => item as String)
                .toList() ?? [],
        upisshifted: json['isshifted'] as bool? ?? false,
        upcategory: json['category'] as String? ?? '',
        upsubcategory: json['subcategory'] as String? ?? '',
        upremark: json['remark'] as String? ?? '',
        upeffortMade: json['effortMade'] as String? ?? '',
        upintrest: json['intrest'] as String? ?? ''
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'upname': upname,
      'upoio': upoio,
      'upformation': upformation,
      'uppenalty': uppenalty,
      'upamountRecovered': upamountRecovered,
      'uppreDeposit': uppreDeposit,
      'uptotalArrearPending': uptotalArrearPending,
      'upbriefFact': upbriefFact,
      'upstatus': upstatus,
      'upapealNo': upapealNo,
      'upstayOrderNumberAndDate': upstayOrderNumberAndDate,
      'upiec': upiec,
      'upgstin': upgstin,
      'uppan': uppan,
      'upage': upage,
      'upcompleteTrack': upcompleteTrack,
      'upisshifted': upisshifted,
      'upcategory': upcategory,
      'upsubcategory': upsubcategory,
      'upremark': upremark,
      'upeffortMade': upeffortMade,
      'upintrest': upintrest,
      'oldData':oldData,
      "update":update,
      "updutyOfArrear":updutyOfArrear
    };
  }
}
