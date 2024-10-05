import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserInformation extends ChangeNotifier {
  String _userType = '';
  String _userId = '';
  String _formation = '';
  String _email = '';

  String get userType => _userType;
  String get userId => _userId;
  String get formation => _formation;
  String get email => _email;

  Future<void> getUserData({required String userType, required String userId}) async {
    try {
      FirebaseFirestore store = FirebaseFirestore.instance;
      DocumentSnapshot snap = await store.collection(userType).doc(userId).get();
      if (snap.exists) {
        final data = snap.data() as Map<String, dynamic>;
        _userType = data["userType"] ?? ''; 
        _userId = data["userId"] ?? '';
        _formation = data["formation"] ?? '';
        _email = data["email"] ?? '';
        notifyListeners(); 
      }
    } catch (e) {
     
      print("Error fetching user data: ${e.toString()}");
    }
  }
}
