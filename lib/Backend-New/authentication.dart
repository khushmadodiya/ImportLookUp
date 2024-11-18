
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Future<String> signUp(
      {required String userType,
      required String userId,
      required String formation,
      required String email,
      required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _fireStore.collection(userType).doc(userId).set({
        "formation": formation,
        "email": email,
        "state": 'MP',
      });
      return "success";
    } catch (error) {
      return "some error occured ${error.toString()}";
    }
  }
  Future forgotPassword({required String email})async{
    String res = "some error occure";
     try{
       await _auth.sendPasswordResetEmail(email: email);
       return res='sucess';
     }
     catch(e){
       res =e.toString();
       return res;
     }
  }
  Future logOut()async{
    await _auth.signOut();
    var pref= await SharedPreferences.getInstance();
    pref.clear();
    return 'success';
  }

  Future<String> login(
      {required String userType,
      required String userId,
      required String password}) async {
    try {
      DocumentSnapshot snap =
          await _fireStore.collection(userType).doc(userId).get();
      if (snap.exists) {
        await _auth.signInWithEmailAndPassword(
            email: (snap.data() as Map<String, dynamic>)['email'],
            password: password);
        return "success";
      } else {
        return "User not found";
      }
     
    } catch (error) {
      return "some error occured ${error.toString()}";
    }
  }
}
