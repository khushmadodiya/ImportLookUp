import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/oio_model.dart';
import '../models/universal-model.dart';

class AsseserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchAssesers({ bool isadmin=false }) async {
    try {
      QuerySnapshot snapshot;
      if(isadmin){
        snapshot=await _firestore.collection('request').get();
      }
      else{
         snapshot = await _firestore.collection('assesers').get();
      }
      List<Map<String, dynamic>> asseserMaps = snapshot.docs.map((doc) {
        // print(doc.data()); // Log the data for debugging
        Asseser asseser = Asseser.fromJson(doc.data() as Map<String, dynamic>);
        return asseser.toJson();
      }).toList();
      // print(asseserMaps); // Log the mapped data
      return asseserMaps;
    } catch (e) {
      print("Error fetching assesers: $e");
      return [];
    }
  }


  //request data
    Future<List<Map<String, dynamic>>> featchRequestData({ bool isadmin=false }) async {
    try {
      QuerySnapshot snapshot;
      // if(isadmin){
        snapshot=await _firestore.collection('requests').get();
      
      List<Map<String, dynamic>> asseserMaps = snapshot.docs.map((doc) {
        
        AcceptRequestModel asseser = AcceptRequestModel.fromJson(doc.data() as Map<String, dynamic>);
        return asseser.toJson();
      }).toList();
        print("i am feggegygeygeugug ${asseserMaps.toString()}");
      return asseserMaps;
    } catch (e) {
      print("Error fetching assesers: $e");
      return [];
    }
  }


}