import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/dashboard.dart';
import 'Screens/login-screen.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.active) {
      //       if (snapshot.hasData) {
      //         return LoginScreen();
      //       } else if (snapshot.hasError) {
      //         return Center(child: Text('An error occurred'));
      //       }
      //     }
      //     return DashboardScreen();
      //   },
      // )
      routes: {
        '/': (context) => DashboardScreen(),
        '/screen1': (context) => AddAsseserDetails(),
        '/Commr Appeal': (context) => Scaffold(body: Center(child: Text("Commr Appeal"))),
        '/CESTAT': (context) => Scaffold(body: Center(child: Text('CESTAT'))),
        '/High Court': (context) => Scaffold(body: Center(child: Text('High Court'))),
        '/Supreme Court': (context) => Scaffold(body: Center(child: Text('Supreme Court'))),

      },
      initialRoute: '/',

    );
  }
}

