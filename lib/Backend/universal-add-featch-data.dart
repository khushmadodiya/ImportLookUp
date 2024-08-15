import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:import_lookup/models/universal-model.dart';




class AddUniversalData{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Future<String> addUniversalDetails( Map<String , dynamic> universalDetails,String catagory)async{
   String res = "error";
   try{
      await _firestore.collection(catagory).add(universalDetails);
     return res ='s';
   }
   catch(e){
     res = "error: $e";
   }
   return res;
}

 Future<List<UniversalModel>> fetchAssesers(String catagory) async {
    try {
      
      QuerySnapshot snapshot = await _firestore.collection(catagory).get();

      List<UniversalModel> assesers = snapshot.docs.map((doc) {
        return UniversalModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return assesers;
    } catch (e) {
      return [];
    }
  }


}




// class AsseserService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 
// }

