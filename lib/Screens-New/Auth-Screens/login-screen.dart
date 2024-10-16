
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Screens-New/Auth-Screens/signup-screeb.dart';
import 'package:import_lookup/Widgets/custom-button.dart';

import 'package:import_lookup/Widgets/formation-dropdown.dart';
import 'package:import_lookup/global.dart';
import 'package:import_lookup/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Backend-New/authentication.dart';
import '../../Provider-New/add-new-cases.dart';
import '../../Provider-New/get-user-deatils.dart';
import '../../Screens/dashboard.dart';
import '../../Widgets/Widgets-New/custom-textfield.dart';
import '../../Widgets/text_field.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final formationKey = GlobalKey<DropdownSearchState>();
  // final usertypeKey = GlobalKey<DropdownSearchState>();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? selectedUsertype = USERTYPE[0];

  final _formkey =GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;

    });


    String res = await Authentication().login(
        userType:selectedUsertype??"", userId:userIdController.text.trim(),password: _passwordController.text.trim());
    if (res == 'success') {
      var pre = await SharedPreferences.getInstance();
      await pre.setString(
          'userId',userIdController.text.trim(),);
      await pre.setString('userType', selectedUsertype??"");
      // selecteditem = pre.get('value').toString();
      // send data to provider
      await (Provider.of<UserInformation>(context,listen: false)).getUserData();
      if (context.mounted) {

          isadmin= false;
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => DashboardScreen(isAdmin: selectedUsertype==USERTYPE[0]?true:false)), (
                  route) => false);




        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        Fluttertoast.showToast(msg: res);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Form(
        key: _formkey,
        child: Consumer<AddNewCase>(
          builder: (context,controller,child) {
            return SafeArea(
              child: Container(
                padding: MediaQuery
                    .of(context)
                    .size
                    .width > 600
                    ? EdgeInsets.symmetric(
                    horizontal: MediaQuery
                        .of(context)
                        .size
                        .width / 3.3)
                    : const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(Icons.person_outline,size: 150,color: Colors.grey[800],),

                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'Import LookUp', style: TextStyle(fontWeight: FontWeight
                            .w600, fontSize: 30, color: Colors.deepPurple),),
                        const SizedBox(height: 20,),
                        // GlobleDropdown(dropdownkey: formationKey,listofvalues: FORMATION, label: 'Select Formation',),
                        // const SizedBox(height: 10,),
                        GlobleDropdown(listofvalues: USERTYPE, label: 'Select UserType', fun: (String? value) {
                          selectedUsertype = value;
                        },),
                        const SizedBox(height: 20,),
                        CustomTextField(
                          hintText: 'Enter your UserId',
                          controller: userIdController,
                          customValidator: (text){
                            if(text==null || text.isEmpty){
                              return 'Invalid id';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomTextField(
                          hintText: 'Enter your password',
                          controller: _passwordController,
                          obscureText: true,


                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomButton(onpress: (){
                          if(userIdController.text.isEmpty || userIdController.text.length<3 ){
                            Fluttertoast.showToast(msg: 'Name is not Valid');
                          }
                          else{
                            if(_passwordController.text.isEmpty || _passwordController.text.length<6){
                              Fluttertoast.showToast(msg: 'Password is not Valid');
                            }
                            else{
                              loginUser();
                            }
                          }
                        }, isLoading: _isLoading, text: 'Login'),

                        const SizedBox(
                          height: 12,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: const Text(
                                'Dont have an account?',
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SignupPage(),
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: const Text(
                                  ' Signup.',
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
            );
          }
        ),
      ),
    );
  }


}