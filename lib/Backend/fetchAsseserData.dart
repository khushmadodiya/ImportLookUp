import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/oio_model.dart';

class AsseserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchAssesers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('assesers').get();
      List<Map<String, dynamic>> asseserMaps = snapshot.docs.map((doc) {
        Asseser asseser = Asseser.fromJson(doc.data() as Map<String, dynamic>);
        return asseser.toJson();
      }).toList();

      return asseserMaps;
    } catch (e) {
      print("Error fetching assesers: $e");
      return [];
    }
  }
}
