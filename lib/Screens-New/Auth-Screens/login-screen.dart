
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:import_lookup/Backend-New/Golbal-Files/category-and-subcategory.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
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
  final TextEditingController _emailcontroller = TextEditingController();
  bool _isLoading = false;
  String? selectedUsertype = USERTYPE[0];

  final _formkey =GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  void loginUser() async {
    var loader=  Provider.of<AddNewCase>(context,listen: false);
    loader.updateLoader();
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
      loader.updateLoader();
      if (context.mounted) {

          isadmin= false;
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => DashboardScreen()), (
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
        loader.updateLoader();
        Fluttertoast.showToast(msg: res,timeInSecForIosWeb: 3);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Form(
        key: _formkey,
        child: Consumer<GeneralPurposeProvider>(
          builder:(context,pro,child)=> Consumer<AddNewCase>(
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
                           Container(
                               height: 200,
                               width: 200,
                               child: Image.asset('assets/logo.jpg')
                           ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("Cutoms TRC Indore",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.blueAccent),),

                          const SizedBox(height: 20,),
                          // GlobleDropdown(dropdownkey: formationKey,listofvalues: FORMATION, label: 'Select Formation',),
                          // const SizedBox(height: 10,),
                          GlobleDropdown(listofvalues: USERTYPE, label: 'Select UserType', fun: (String? value) {
                            selectedUsertype = value;
                          }, selectedItem: USERTYPE[0],),
                          const SizedBox(height: 20,),
                          CustomTextField(
                            hintText: 'Enter your UserId',
                            labelText:'Enter your UserId' ,
                            prefixIcon: Icons.person,
                            controller: userIdController,
                            customValidator: (text){

                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomTextField(
                            prefixIcon: Icons.password,
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
                          }, isLoading: controller.isLoading, text: 'Login'),

                          const SizedBox(
                            height: 12,
                          ),

                         TextButton(onPressed: (){
                           showDialog(
                               context: context, builder: (context)=>AlertDialog(
                             title: Column(
                               children: [
                                 Text('Forget Password'),
                               ],
                             ),
                             actions: [
                               CustomTextField(
                                 controller: _emailcontroller,
                                 hintText: 'Enter email',
                                 labelText: 'Enter email',
                                 prefixIcon: Icons.email,
                               ),
                               TextButton(
                                   onPressed: () async {
                                    var res= await Authentication().forgotPassword(email: _emailcontroller.text.trim());
                                     if(res=='sucess'){
                                       showDialog(context: context, builder: (context)=>
                                           AlertDialog(
                                             title: Column(
                                               children: [
                                                 Text('Check your email inbox',style: TextStyle(color: Colors.blueAccent),),
                                                 SizedBox(height: 20,),
                                                 IconButton(
                                                   onPressed: (){
                                                     Navigator.pop(context);
                                                     Navigator.pop(context);
                                                   },
                                                  icon: Icon(Icons.check_box,size: 40,color: Colors.blueAccent,),
                                                 )
                                               ],
                                             ),
                                             actions: [
                                               TextButton(onPressed: (){
                                                 Navigator.pop(context);
                                                 Navigator.pop(context);
                                               }, child: Text('OK'))

                                             ],

                                           )
                                       );
                                     }
                                     else{
                                       Fluttertoast.showToast(msg: res.toString(),timeInSecForIosWeb: 3);
                                     }
                                   },
                                   child: Text('Send')),
                             ],
                           )
                           );
                         }, child: Text('Forget password'))
                        ],

                      ),

                    ),
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }


}