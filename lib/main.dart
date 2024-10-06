
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:import_lookup/Screens-New/Auth-Screens/login-screen.dart';
import 'package:import_lookup/Screens/login-screen.dart';
import 'package:import_lookup/provider/provider.dart';
import 'package:import_lookup/test.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
bool isadmin = false;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AsseserProvider()),
        ChangeNotifierProvider(create: (_) => RequestedAsseserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:const Test(),
       
      
      ),
    );
  }
}

// class Dipu extends StatelessWidget {
//   final dropDownKey = GlobalKey<DropdownSearchState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('examples mode')),
//       body: ListView(
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: DropdownSearch<String>(
//                   // key:,
                  
//                   selectedItem: "Menu",
//                   items: (filter, infiniteScrollProps) =>
//                   ["Menu", "Dialog", "Modal", "BottomSheet"],
                  
//                 ),
//               ),
              
//             ],
//           ),
         
          
//         ],
//       ),
//     );
//   }
// }