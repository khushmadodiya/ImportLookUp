import 'package:flutter/material.dart';
import '../Backend/fetchAsseserData.dart';


class AsseserProvider with ChangeNotifier {
  List<Map<String,dynamic>>?_assesers;
  // List<Map<String,dynamic>>?_re;
  bool _isLoading = false;

  List<Map<String,dynamic>> assesers(){
    print("lenght is heer ");
    return _assesers!;
    }

  bool get isLoading => _isLoading;

  Future<void> fetchAssesers() async {
  _isLoading = true;
  notifyListeners(); // Notify listeners that loading has started

  try {
    List<Map<String, dynamic>> fetchedAssesers = await AsseserService().fetchAssesers();
    if (fetchedAssesers.isNotEmpty) {
      // print("heeelo ${fetchedAssesers.length}");
      _assesers = fetchedAssesers;
    } else {
      print("No assesers fetched from the service.");
    }
    print("Fetched assesers count: ${_assesers!.length}");
  } catch (e) {
    print('Error fetching assesers: $e');
    _assesers = [];
  }

  _isLoading = false;
  notifyListeners(); // Notify listeners that loading has finished
}

}

class RequestedAsseserProvider with ChangeNotifier {
  List<Map<String,dynamic>>?_assesers;
  bool _isLoading = false;

  List<Map<String,dynamic>> assesers(){
    // print("lenght is heer ");
    return _assesers!;
    }

  bool get isLoading => _isLoading;

  Future<void> fetchAssesers() async {
  _isLoading = true;
  notifyListeners(); // Notify listeners that loading has started

  try {
    List<Map<String, dynamic>> fetchedAssesers = await AsseserService().featchRequestData(isadmin: true);
    if (fetchedAssesers.isNotEmpty) {
      // print("heeelo ${fetchedAssesers.length}");
      _assesers = fetchedAssesers;
    } else {
      print("No assesers fetched from the service.");
    }
    print("Fetched assesers count: ${_assesers!.length}");
  } catch (e) {
    print('Error fetching assesers: $e');
    _assesers = [];
  }

  _isLoading = false;
  notifyListeners(); // Notify listeners that loading has finished
}

}
