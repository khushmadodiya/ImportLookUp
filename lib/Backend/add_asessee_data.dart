

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';



class AddAsesse {
  Future<String> addDetails( Map<String , dynamic> asseserDetails,OIO)async{
   String res = "error";
   try{
     await FirebaseFirestore.instance.collection('assesers').doc(OIO).set(asseserDetails);
     return res ='s';
   }
   catch(e){
     res = "error: $e";
   }
   return res;
}


}