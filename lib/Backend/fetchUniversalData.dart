import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/oio_model.dart';
import '../models/universal-model.dart';

class UniversalService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchUniversal() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('assesers').get();
      List<Map<String, dynamic>> asseserMaps = snapshot.docs.map((doc) {
        print(doc.data()); // Log the data for debugging
        UniversalModel universalModel = UniversalModel.fromJson(doc.data() as Map<String, dynamic>);
        return universalModel.toJson();
      }).toList();
      print(asseserMaps); // Log the mapped data
      return asseserMaps;
    } catch (e) {
      print("Error fetching assesers: $e");
      return [];
    }
  }
}
