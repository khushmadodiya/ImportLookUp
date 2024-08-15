import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/oio_model.dart';


class AsseserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Asseser>> fetchAssesers() async {
    try {
      // Fetch the collection of documents
      QuerySnapshot snapshot = await _firestore.collection('assesers').get();

      // Map each document to an Asseser object
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
