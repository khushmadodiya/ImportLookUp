import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';




class AddUniversalDetails {
  Future<String> addDetails( Map<String , dynamic> asseserDetails,String uid,String trackEntry)async{
    String res = "error";
    try{
      print(isadmin);
      if(isadmin){
        await FirebaseFirestore.instance.collection('assesers').doc(uid).update({...asseserDetails,'complete_track': FieldValue.arrayUnion([trackEntry])});
      }
      else{
        await FirebaseFirestore.instance.collection('request').doc(uid).set({...asseserDetails,'complete_track': FieldValue.arrayUnion([trackEntry])});

      }
      return res ='s';
    }
    catch(e){
      res = "error: $e";
    }
    return res;
  }
 Future<String> acceptRequest( Map<String , dynamic> asseserDetails,String uid,String trackEntry)async{
    String res = "error";
    try{
      await FirebaseFirestore.instance.collection('assesers').doc(uid).update({...asseserDetails,'complete_track': FieldValue.arrayUnion([trackEntry])});
      await FirebaseFirestore.instance.collection('request').doc(uid).delete();
      return res ='s';
    }
    catch(e){
      res = "error: $e";
    }
    return res;
  }
  Future<String> rejectRequest(String uid)async{
    String res = "error";
    try{
      await FirebaseFirestore.instance.collection('request').doc(uid).delete();
      return res ='s';
    }
    catch(e){
      res = "error: $e";
    }
    return res;
  }


}



