// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:import_lookup/Screens/dashboard.dart';
import 'package:import_lookup/Screens/oio-page.dart';
import 'package:import_lookup/Widgets/custom-button.dart';

import '../../Backend-New/Golbal-Files/category-and-subcategory.dart';
import '../../Backend-New/authentication.dart';
import '../../Widgets/formation-dropdown.dart';
import '../../Widgets/text_field.dart';
import 'login-screen.dart';



class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formationKey = GlobalKey<DropdownSearchState>();
  final usertypeKey = GlobalKey<DropdownSearchState>();
  bool _isLoading = false;


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });
    final usertype = usertypeKey.currentState?.getSelectedItems.toString()??'Admin';
    final formation = usertypeKey.currentState?.getSelectedItems.toString()??'';
    String res = await Authentication().signUp(
      email: _emailController.text,
      password: _passwordController.text,
      userId: _usernameController.text,
      userType:usertype,
     formation: formation);
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {

          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);

      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        Fluttertoast.showToast(msg: res);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > 600
              ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(
                height: 24,
              ),
              const SizedBox(height: 20,),
              GlobleDropdown(dropdownkey: formationKey,listofvalues: FORMATION, label: 'Select Formation',),
              const SizedBox(height: 10,),
              GlobleDropdown(listofvalues: USERTYPE,key: usertypeKey, label: 'Select UserType',),
              const SizedBox(height: 20,),
              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,

              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,

              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                ispass:true,

              ),
              const SizedBox(
                height: 24,
              ),

              CustomButton(onpress: signUpUser, isLoading: _isLoading),
              const SizedBox(
                height: 12,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Already have an account?',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Login.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



}
