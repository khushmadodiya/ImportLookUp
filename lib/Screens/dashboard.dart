import 'package:flutter/material.dart';
import 'package:import_lookup/Screens/oio-page.dart';
import 'package:import_lookup/Screens/show-oio-details.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ShowAsserDetails(),
    AddAsseserDetails(),
    Text('Appeal period is not over'),
    Text('Supreme Court'),
    Text('High Court'),
    Text('CESTAT'),
    Text("Commr Appeal"),
    Text("OL"),
    Text("DRT"),
    Text("BIFR"),
    Text("NCLT-Units"),
    Text("'Appeal period not over but appeal filed'"),
    Text("'Settelment commitsion cases'"),
    Text("'Arrear under section-11'"),
    Text( 'Arrear under section-142'),


  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  String? selectedScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Custom Import'),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: MouseRegion(
                onHover: (event){

                },
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Appeal perirod is not over'),
                  onTap: () {
                    _onItemTapped(0);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Add asserdetails'),
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                title: DropdownButton<String>(
                  elevation: 0,

                  underline: Text(''),
                  // icon: Icon(Icons.report),
                  hint: Row(
                    children: [
                      Icon(Icons.report),
                      Text("Arrears Under Litigation", style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500,color: Colors.black),),
                    ],
                  ),

                  items: <String>[
                    'Commr Appeal',
                    'CESTAT',
                    'High Court',
                    'Supreme Court'
                  ]
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedScreen = newValue;
                    });

                    // Navigate to the selected screen
                    if (newValue == 'Commr Appeal') {
                      _onItemTapped(6);
                      Navigator.pop(context);
                    } else if (newValue == 'CESTAT') {
                      _onItemTapped(5);
                      Navigator.pop(context);
                    } else if (newValue == 'High Court') {
                      _onItemTapped(4);
                      Navigator.pop(context);
                    } else if (newValue == 'Supreme Court') {
                      _onItemTapped(3);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                title: DropdownButton<String>(
                  elevation: 0,

                  underline: Text(''),
                  // icon: Icon(Icons.report),
                  hint: const Row(
                    children: [
                      Icon(Icons.report),
                     Text("Restrained Arrears", style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500,color: Colors.black),),
                    ],
                  ),

                  items: <String>[
                    'OL',
                    'DRT',
                    'BIFR',
                    'NCLT-Units'
                  ]
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedScreen = newValue;
                    });

                    // Navigate to the selected screen
                    if (newValue == 'OL') {
                      _onItemTapped(7);
                      Navigator.pop(context);
                    } else if (newValue == 'DRT') {
                      _onItemTapped(8);
                      Navigator.pop(context);
                    } else if (newValue ==  'BIFR') {
                      _onItemTapped(9);
                      Navigator.pop(context);
                    } else if (newValue == 'NCLT-Units') {
                      _onItemTapped(10);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                title: DropdownButton<String>(
                  elevation: 0,

                  underline: Text(''),
                  // icon: Icon(Icons.report),
                  hint: const Row(
                    children: [
                      Icon(Icons.report),
                     Text("Recoverable Arrear", style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500,color: Colors.black),),
                    ],
                  ),

                  items: <String>[
                    'Appeal period not over but appeal filed',
                    'Settelment commitsion cases',
                    'Arrear under section-11',
                    'Arrear under section-142',
                  ]
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedScreen = newValue;
                    });

                    // Navigate to the selected screen
                    if (newValue =='Appeal period not over but appeal filed') {
                      _onItemTapped(11);
                      Navigator.pop(context);
                    } else if (newValue =='Settelment commitsion cases') {
                      _onItemTapped(12);
                      Navigator.pop(context);
                    } else if (newValue ==  'Arrear under section-11') {
                      _onItemTapped(13);
                      Navigator.pop(context);
                    } else if (newValue == 'Arrear under section-142') {
                      _onItemTapped(14);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ),

          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );

  }
}
// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   String? selectedScreen;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flutter Web Dashboard"),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               child: Text('Custom Import'),
//             ),
//             Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 // shape: BoxShape.circle
//               ),
//               child: ListTile(
//                 leading: Icon(Icons.home),
//                 title: Text('Home'),
//                 onTap: () {
//                   Navigator.popAndPushNamed(context, '/screen1');
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//             ListTile(
//               title: DropdownButton<String>(
//                 elevation: 0,
//                 borderRadius: BorderRadius.circular(20),
//                 padding: EdgeInsets.all(10),
//                 underline: Text(''),
//                 // icon: Icon(Icons.report),
//                 hint: Row(
//                   children: [
//                     Icon(Icons.report),
//                     Text("Arrears Under Litigationr",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                   ],
//                 ),
//
//                 items: <String>['Commr Appeal', 'CESTAT', 'High Court','Supreme Court']
//                     .map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedScreen = newValue;
//                   });
//
//                   // Navigate to the selected screen
//                   if (newValue == 'Commr Appeal') {
//                     Navigator.pushNamed(context, '/Commr Appeal');
//                   } else if (newValue == 'CESTAT') {
//                     Navigator.pushNamed(context, '/CESTAT');
//                   } else if (newValue == 'High Court') {
//                     Navigator.pushNamed(context, '/High Court');
//                   }else if (newValue == 'Supreme Court') {
//                     Navigator.pushNamed(context, '/Supreme Court');
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: Text(
//           'Select a screen from the drawer.',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
//
// // Define separate screen widgets
// class Screen1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Screen 1"),
//       ),
//       body: Center(
//         child: Text(
//           'This is Screen 1',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
//
// class Screen2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Screen 2"),
//       ),
//       body: Center(
//         child: Text(
//           'This is Screen 2',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
//
// class Screen3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Screen 3"),
//       ),
//       body: Center(
//         child: Text(
//           'This is Screen 3',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }