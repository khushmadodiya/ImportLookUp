
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/Screens-New/Auth-Screens/login-screen.dart';
import 'package:import_lookup/Screens/dashboard.dart';
import 'package:import_lookup/provider/provider.dart';
import 'package:provider/provider.dart';

import 'Provider-New/add-new-cases.dart';
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
        ChangeNotifierProvider(create: (_) => AddNewCase()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return DashboardScreen(isadmin: false);
              } else if (snapshot.hasError) {
                return Center(child: Text('An error occurred'));
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting ) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return LoginPage();
          },
        ),
       
      
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   final dropDownKey = GlobalKey<DropdownSearchState>();
//
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
//                   // decoratorProps: DropDownDecoratorProps(
//                   //   decoration: InputDecoration(
//                   //     labelText: 'Examples for: ',
//                   //     border: OutlineInputBorder(),
//                   //   ),
//                   // ),
//                   // popupProps: PopupProps.menu(
//                   //     fit: FlexFit.loose, constraints: BoxConstraints()),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.only(right: 16)),
//               FilledButton(
//                 onPressed: () {
//                   switch (dropDownKey.currentState?.getSelectedItem) {
//                     case 'Menu':
//
//                       break;
//                     case 'Modal':
//
//                       break;
//                     case 'BottomSheet':
//
//                       break;
//                     case 'Dialog':
//
//                       break;
//                   }
//                 },
//                 child: Text("Go"),
//               )
//             ],
//           ),
//           Padding(padding: EdgeInsets.all(8)),
//           RichText(
//             text: TextSpan(
//               style: const TextStyle(fontSize: 14.0, color: Colors.black),
//               children: [
//                 TextSpan(text: 'we used '),
//                 TextSpan(
//                     text: 'fit: FlexFit.loose',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 TextSpan(text: ' and '),
//                 TextSpan(
//                     text: 'constraints: BoxConstraints() ',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 TextSpan(
//                     text:
//                     'to fit the height of menu automatically to the length of items'),
//               ],
//             ),
//           ),
//           Padding(padding: EdgeInsets.only(top: 20)),
//           Text(
//             'DropdownSearch Anatomy',
//             style: TextStyle(
//                 fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
//             textAlign: TextAlign.center,
//           ),
//           Image.asset('assets/images/anatomy.png',
//               alignment: Alignment.topCenter, height: 1024)
//         ],
//       ),
//     );
//   }
// }