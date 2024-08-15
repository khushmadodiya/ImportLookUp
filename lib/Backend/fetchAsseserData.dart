import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/asseser_model.dart';


class AsseserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Asseser>> fetchAssesers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('assesers').get();
      List<Asseser> assesers = snapshot.docs.map((doc) {
        return Asseser.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return assesers;
    } catch (e) {
      print("Error fetching assesers: $e");
      return [];
    }
  }
}
