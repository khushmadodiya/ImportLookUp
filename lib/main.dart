// import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/Backend-New/request-cases-details.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
import 'package:import_lookup/Screens-New/Auth-Screens/login-screen.dart';
import 'package:import_lookup/Screens-New/Dashboard/DisposalScreen.dart';
import 'package:import_lookup/Screens/dashboard.dart';
import 'package:import_lookup/test.dart';
import 'package:import_lookup/upload-data.dart';
import 'package:provider/provider.dart';
import 'Provider-New/add-new-cases.dart';
import 'Provider-New/get-user-deatils.dart';
import 'firebase_options.dart';
// import 'main_cases_details_mobile.dart' if (dart.library.html) 'main_cases_details_web.dart';

bool isadmin = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AddNewCase()),
    ChangeNotifierProvider(create: (_) => UserInformation()),
    ChangeNotifierProvider(create: (_) => GeneralPurposeProvider()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TRC Customs Indore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            primary: Colors.deepPurple,
            background: Colors.white),
        useMaterial3: true,
      ),
      // home: UploadData()
     home:  Consumer<UserInformation>(
        builder: (context, pro, child) => StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                // if (pro.email.isNotEmpty)
                return DashboardScreen();
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return Center(child: Text('An error occurred'));
              }
              // return DashboardScreen(isadmin: false);
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
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

  void getData() async {
    var pro = await (Provider.of<UserInformation>(context, listen: false));
    var p = await pro.getUserData();
    await RequestCasesInformation().getAllReuqestCasesDetails();
    // await UserInformation().getUserData()
    print('${pro.userId}  ${pro.userType}  ${pro.email}  ${pro.formation} ');
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
