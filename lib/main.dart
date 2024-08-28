
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/Screens/dashboard.dart';
import 'package:import_lookup/Screens/login-screen.dart';
import 'package:import_lookup/Screens/show-oio-details.dart';
import 'package:import_lookup/add_json_data.dart';
import 'package:import_lookup/provider/provider.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {

              if (snapshot.hasData) {
                 if(FirebaseAuth.instance.currentUser!.uid.toString()=='pbOT4LLlFQgU11skcHVOva37vg32') {
                   isadmin = true;
                   DashboardScreen(isadmin: true,);
                 }
                 else{
                   DashboardScreen(isadmin: false,);
                 }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreen();
          },
        ),
       
      
      ),
    );
  }
}

