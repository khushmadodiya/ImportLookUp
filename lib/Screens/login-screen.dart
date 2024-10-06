//
// // ignore_for_file: use_build_context_synchronously
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:import_lookup/Widgets/dropdown.dart';
// import 'package:import_lookup/global.dart';
// import 'package:import_lookup/main.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../Backend/authmethos.dart';
// import '../Widgets/text_field.dart';
// import 'SignupScreen.dart';
// import 'dashboard.dart';
//
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;
//
//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//   // }
//
//   void loginUser() async {
//     setState(() {
//       _isLoading = true;
//     });
//     String res = await AuthMethods().loginUser(
//         email: _emailController.text, password: _passwordController.text);
//     if (res == 'success') {
//       var pre = await SharedPreferences.getInstance();
//       await pre.setString('value', selecteditem);
//       selecteditem = pre.get('value').toString();
//       if (context.mounted) {
//          if(FirebaseAuth.instance.currentUser!.uid.toString() == 'pbOT4LLlFQgU11skcHVOva37vg32') {
//            print("this is admin");
//            isadmin = true;
//            Navigator.pushAndRemoveUntil(context,
//                MaterialPageRoute(builder: (context) => DashboardScreen(isadmin: true,)), (
//                    route) => false);
//          }
//          else{
//            isadmin= false;
//            Navigator.pushAndRemoveUntil(context,
//                MaterialPageRoute(builder: (context) => DashboardScreen(isadmin: false,)), (
//                    route) => false);
//          }
//
//
//
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//       if (context.mounted) {
//         Fluttertoast.showToast(msg: res);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Container(
//           padding: MediaQuery.of(context).size.width > 600
//               ? EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width / 3.3)
//               : const EdgeInsets.symmetric(horizontal: 32),
//           width: double.infinity,
//           height:MediaQuery.of(context).size.height,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Container(
//               height:MediaQuery.of(context).size.height,
//               width:MediaQuery.of(context).size.width,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Icon(Icons.person_outline,size: 150,color: Colors.grey[800],),
//
//                   const SizedBox(
//                     height: 24,
//                   ),
//                  const Text('Import LookUp',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30,color: Colors.deepPurple),),
//                  const SizedBox(height: 20,),
//                   Dropdown(),
//                   const SizedBox(height: 20,),
//                   TextFieldInput(
//                     hintText: 'Enter your email',
//                     textInputType: TextInputType.emailAddress,
//                     textEditingController: _emailController,
//
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   TextFieldInput(
//                     hintText: 'Enter your password',
//                     textInputType: TextInputType.text,
//                     textEditingController: _passwordController,
//                     ispass: true,
//
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   InkWell(
//                     onTap: loginUser,
//                     child: Container(
//                       width: double.infinity,
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       decoration: const ShapeDecoration(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(4)),
//                         ),
//                         color: Colors.deepPurple,
//                       ),
//                       child: !_isLoading
//                           ? const Text(
//                         'Log in',style: TextStyle(color: Colors.white,fontSize: 20),
//                       )
//                           : const CircularProgressIndicator(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//
//                 const SizedBox(
//                   height: 12,
//                 ),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       child: const Text(
//                         'Dont have an account?',
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => const SignupScreen(),
//                         ),
//                       ),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 8),
//                         child: const Text(
//                           ' Signup.',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,color: Colors.deepPurple
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//
//               ),
//
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }