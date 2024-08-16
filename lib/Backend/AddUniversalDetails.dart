import 'package:cloud_firestore/cloud_firestore.dart';




class AddUniversalDetails {
  Future<String> addDetails( Map<String , dynamic> asseserDetails,String uid,String trackEntry)async{
    String res = "error";
    try{
      await FirebaseFirestore.instance.collection('assesers').doc(uid).update({...asseserDetails,'complete_track': FieldValue.arrayUnion([trackEntry])});
      return res ='s';
    }
    catch(e){
      res = "error: $e";
    }
    return res;
  }


}



