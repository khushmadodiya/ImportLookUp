import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';




class AddAsesse {
  Future<String> addDetails( Map<String , dynamic> asseserDetails,String uid)async{
   String res = "error";
   try{
     print(isadmin);
     if(isadmin){
       await FirebaseFirestore.instance.collection('assesers').doc(uid).set(asseserDetails);
     }
     else{
       await FirebaseFirestore.instance.collection('request').doc(uid).set(asseserDetails);
     }
     return res ='s';
   }
   catch(e){
     res = "error: $e";
   }
   return res;
}


}



