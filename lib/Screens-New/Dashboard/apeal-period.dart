import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/Provider-New/add-new-cases.dart';
import 'package:provider/provider.dart';

import '../../Provider-New/get-user-deatils.dart';
import '../../Widgets/Widgets-New/custom-table.dart';

class ApealPeriodNotOver extends StatefulWidget {
  const ApealPeriodNotOver({super.key});

  @override
  State<ApealPeriodNotOver> createState() => _ApealPeriodNotOverState();
}

class _ApealPeriodNotOverState extends State<ApealPeriodNotOver> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewCase>(
      builder: (context,provider,child)=>
      CustomTable(data: provider.mainCaseData, tital: 'OIO Details',)
    );
  }

  void getData()async {

    final asseserProvider = Provider.of<AddNewCase>(context, listen: false);
    final userinfo = Provider.of<UserInformation>(context,listen: false);
    await asseserProvider.getMainCasesInformation(formation: userinfo.formation, isAdmin: false);

    print('dipu landka hai ${asseserProvider.mainCaseData[0].name}');
  }
}
