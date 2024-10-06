import 'package:flutter/cupertino.dart';
import 'package:import_lookup/Provider-New/add-new-cases.dart';
import 'package:import_lookup/Widgets/Widgets-New/custom-table.dart';
import 'package:provider/provider.dart';

class SupremeCourt extends StatefulWidget {
  const SupremeCourt({super.key});

  @override
  State<SupremeCourt> createState() => _SupremeCourtState();
}

class _SupremeCourtState extends State<SupremeCourt> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewCase>(
      builder: (context,provider,child)=>
      CustomTable(data: provider.mainCaseData,tital: 'Supreme Court',)
    );
  }

  void getdata()async {
    print('helo');
  }
}
