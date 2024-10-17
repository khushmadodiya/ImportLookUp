import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInformation extends ChangeNotifier {
  String _userType = '';
  String _userId = '';
  String _formation = '';
  String _email = '';

  String get userType => _userType;
  String get userId => _userId;
  String get formation => _formation;
  String get email => _email;

  Future getUserData() async {
    try {

      var pref = await SharedPreferences.getInstance();
      print(pref.getString('userId'));
      print(pref.getString('userType'));
      var usertype = pref.getString('userType').toString();
      var userid = pref.getString('userId');
      FirebaseFirestore store = FirebaseFirestore.instance;
      DocumentSnapshot snap = await store.collection(usertype).doc(userid).get();
      if (snap.exists) {
        final data = snap.data() as Map<String, dynamic>;
        _userType = pref.getString('userType') ?? ''; 
        _userId = pref.getString('userId') ?? '';
        _formation = data["formation"] ?? '';
        _email = data["email"] ?? '';
        notifyListeners();
        return 'success';
      }
    } catch (e) {
     
      print("Error fetching user data: ${e.toString()}");
    }
  }
}
