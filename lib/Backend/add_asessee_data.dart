import 'package:cloud_firestore/cloud_firestore.dart';




class AddAsesse {
  Future<String> addDetails( Map<String , dynamic> asseserDetails)async{
   String res = "error";
   try{
     await FirebaseFirestore.instance.collection('assesers').add(asseserDetails);
     return res ='s';
   }
   catch(e){
     res = "error: $e";
   }
   return res;
}


}

