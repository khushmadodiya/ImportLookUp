import 'package:flutter/material.dart';
import '../Backend/fetchAsseserData.dart';
import '../models/oio_model.dart';

class AsseserProvider with ChangeNotifier {
  List<Map<String,dynamic>>? _assesers;
  bool _isLoading = false;

  List<Map<String,dynamic>>? get assesers => _assesers;

  bool get isLoading => _isLoading;

  // Function to fetch Assesers from the service
  Future<void> fetchAssesers() async {
    _isLoading = true;
    notifyListeners(); // Notify listeners that loading has started

    try {
      _assesers = await AsseserService().fetchAssesers();
    } catch (e) {
      print('Error fetching assesers: $e');
      _assesers = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
