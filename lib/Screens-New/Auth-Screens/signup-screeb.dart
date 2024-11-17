
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:import_lookup/Provider-New/add-new-cases.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
import 'package:import_lookup/Widgets/custom-button.dart';
import 'package:provider/provider.dart';

import '../../Backend-New/Golbal-Files/category-and-subcategory.dart';
import '../../Backend-New/authentication.dart';
import '../../Widgets/Widgets-New/custom-textfield.dart';
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
  String? formation = FORMATION[0];



  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    var userType= Provider.of<GeneralPurposeProvider>(context,listen: false);
    var loading= Provider.of<AddNewCase>(context,listen: false);
    loading.updateLoader();
    String res = await Authentication().signUp(
      email: _emailController.text,
      password: _passwordController.text,
      userId: _usernameController.text,
      userType:userType.userType??"",
     formation: formation?? '');
    loading.updateLoader();
    if (res == "success") {

      if (context.mounted) {

          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);

      }
    } else {
      if (context.mounted) {
        Fluttertoast.showToast(msg: res,timeInSecForIosWeb: 3);
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<AddNewCase>(
        builder: (context,p,child)=>
         Consumer<GeneralPurposeProvider>(
          builder: (context,pro,child)=>
         SafeArea(
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
                  GlobleDropdown(listofvalues: USERTYPE,label: 'Select UserType', fun: (String? value) {
                    pro.updateUserType(value??"");
                    print(pro.userType);
                  }, selectedItem: USERTYPE[0],),
                  const SizedBox(height: 10,),
                  if(pro.userType==USERTYPE[1])GlobleDropdown(listofvalues: FORMATION, label: 'Select Formation', fun: (String? value) {
                    formation = value;
                  }, selectedItem: SUBCATEGORY[CATEGORY[2]]![0],),
                  const SizedBox(height: 10,),
                  CustomTextField(
                    hintText: 'Enter your username',
                    labelText: 'Enter your username',
                    controller: _usernameController,

                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    hintText: 'Enter your email',
                    labelText: 'Enter your email',
                    controller: _emailController,

                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    hintText: 'Enter your password',
                    labelText: 'Enter your password',
                    controller: _passwordController,
                    obscureText: pro.ispass?false:true,
                    suffixIcon:IconButton(
                      icon: Icon(
                        pro.ispass ? Icons.visibility : Icons.visibility_off,

                      ), onPressed: () {
                      pro.updatePass();
                    },
                    ),

                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  CustomButton(onpress: signUpUser, isLoading: p.isLoading, text: 'Signup'),
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
        ),
      ),
    );
  }



}
