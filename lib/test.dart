import 'package:flutter/material.dart';
import 'package:import_lookup/Backend-New/authentication.dart';
import 'package:import_lookup/Backend-New/main-cases-details.dart';
import 'package:import_lookup/Backend-New/request-cases-details.dart';
import 'package:import_lookup/Backend-New/tar-report.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData()async{

  //  print(await Authentication().signUp(email:"knownpatidar@gmail.com", userType: 'Admin', userId: 'divyansh', formation: 'Icd Indore', password: '123456'));
  //  await Authentication().forgotPassword(email:"knownpatidar@gmail.com");
    // await MainCasesInformation().updateCaseDetails(uid:"06cbc580-70f9-11ef-94b7-2fda55392be8", name:'Divyansh', formation:'Icd Tihi', oio:'', date:'dd/mm/yyyy', dutyOfArrear:'', penalty: '', amountRecovered:'', preDeposit: '', intrest: '', totalArrearPending: '', briefFact:'Testing is performing' , status: 'Staus', apealNo:'', stayOrderNumberAndDate: '', iec: '', gstin: '', pan: '', completeTrack:["case is added"], category:'RC', remark: 'NA', subcategory:'NA', effortMade:'NA');
  // print( await Authentication().login(userType:'Admin', userId:'divy', password:'123456'));

  //add main case
  // print(  await MainCasesInformation().addCases( uid:'', name: "name", formation: "formation", oio: "oio", date: "date", dutyOfArrear: "dutyOfArrear", penalty: "penalty", amountRecovered: "amountRecovered", preDeposit: "preDeposit", intrest: "intrest", totalArrearPending: "totalArrearPending", briefFact: "briefFact", status: "status", apealNo: "apealNo", stayOrderNumberAndDate: "stayOrderNumberAndDate", iec: "iec", gstin: "gstin", pan: "pan", completeTrack: ["completeTrack by divyansh"], category: "category", remark: "remark", subcategory: "subcategory", effortMade: "effortMade"));
  //
// List<Map<String,dynamic>>allCases=await MainCasesInformation().getAllMainCasesDetails();
// print("heeelo ${allCases.toList()}");
// print("res is here ${await RequestCasesInformation().addCases(
// oldData:allCases[0],
// uid:allCases[0]['uid'], 
// name: "testing is heraaaa" ,
// formation:allCases[0]["formation"], 
// oio: allCases[0]["oio"], 
// date: allCases[0]["date"], 
// dutyOfArrear: allCases[0]["dutyOfArrear"], 
// penalty: allCases[0]["penalty"], 
// amountRecovered: allCases[0]["amountRecovered"], 
// preDeposit: allCases[0]["preDeposit"], 
// intrest: allCases[0]["intrest"], 
// totalArrearPending: allCases[0]["totalArrearPending"], 
// briefFact: allCases[0]["briefFact"],
//  status: allCases[0]["status"],
//   apealNo: allCases[0]["apealNo"], 
//   stayOrderNumberAndDate: allCases[0]["stayOrderNumberAndDate"], 
//   iec: allCases[0]["iec"], 
//   gstin: allCases[0]["gstin"], 
//   pan: allCases[0]["pan"], 
//   completeTrack: "buu", 
//   category: allCases[0]["category"], 
//   remark: allCases[0]["remark"], 
//   subcategory: allCases[0]["subcategory"],
//    effortMade: allCases[0]["effortMade"])}");
// print("i am dipu   ${allCases.toList()}");

// List<Map<String,dynamic>>allCases=await RequestCasesInformation().getAllReuqestCasesDetails();
// print("heeelo ${allCases.toList()}");
// print("res is here ${await RequestCasesInformation().acceptRequest(
// // oldData:allCases[0],
// uid:allCases[0]['uid'], 
// name: "testing is heraaaa" ,
// formation:allCases[0]["upformation"], 
// oio: allCases[0]["upoio"], 
// date: allCases[0]["update"], 
// dutyOfArrear: allCases[0]["updutyOfArrear"], 
// penalty: allCases[0]["uppenalty"], 
// amountRecovered: allCases[0]["upamountRecovered"], 
// preDeposit: allCases[0]["uppreDeposit"], 
// intrest: allCases[0]["upintrest"], 
// totalArrearPending: allCases[0]["uptotalArrearPending"], 
// briefFact: allCases[0]["upbriefFact"],
//  status: allCases[0]["upstatus"],
//   apealNo: allCases[0]["upapealNo"], 
//   stayOrderNumberAndDate: allCases[0]["upstayOrderNumberAndDate"], 
//   iec: allCases[0]["upiec"], 
//   gstin: allCases[0]["upgstin"], 
//   pan: allCases[0]["uppan"], 
//   completeTrack: List<String>.from(allCases[0]["upcompleteTrack"]), 
//   category: allCases[0]["upcategory"], 
//   remark: allCases[0]["upremark"], 
//   subcategory: allCases[0]["upsubcategory"],
//    effortMade: allCases[0]["upeffortMade"])}");
// print("i am dipu   ${allCases.toList()}");
// print(  await RequestCasesInformation().updateRequestData(oldData:{}, uid:'7b2dd400-71f2-11ef-a1c8-cdecc2d8ff49', name: "Divyansh", formation: "formation", oio: "oio", date: "date", dutyOfArrear: "dutyOfArrear", penalty: "penalty", amountRecovered: "amountRecovered", preDeposit: "preDeposit", intrest: "intrest", totalArrearPending: "totalArrearPending", briefFact: "briefFact", status: "status", apealNo: "apealNo", stayOrderNumberAndDate: "stayOrderNumberAndDate", iec: "iec", gstin: "gstin", pan: "pan", completeTrack: "completeTrack by divyansh", category: "category", remark: "remark", subcategory: "subcategory", effortMade: "effortMade"));
// print("i am calle d");
// await RequestCasesInformation().getFormationRequestedCaseInformation('formation');

await TarReportInformation().transferCasesUpTheMonth(category:"arrear under litigation" , docName:"disposal transfered formation category", subcategory:'High court');

// print(await TarReportInformation().updateDataOfTarReport(category:"arrear under litigation", subcategory: "High court", docName: "disposal transfered formation category", noOfCasesOfTheMonth:1, noOfCasesUpToTheMonth: 0, amountOfTheMonth: 1, amountUpTotheMonth: 0));
  print("success");

  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:Center(
        child: Column(
          children: [
            Text('TEst Project')
          ],
        ),
      ),
    );
  }
}