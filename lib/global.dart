

import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/provider/provider.dart';
import 'package:provider/provider.dart';

import 'Screens/universal-update-details-page.dart';

String selectedcategory = "Arrear where appeal period is not over";
// String selectedsubcategory =


Widget _buildTransferButton(int i,BuildContext context) {
  return Container(
    color: Colors.blue.withOpacity(0.2),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        onPressed: () async {
          bool? shouldRefresh = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateUniversalDetails(index: i),
            ),
          );

          if (shouldRefresh == true) {
            // Notify the provider to fetch data again
            Provider.of<RequestedAsseserProvider>(context, listen: false)
                .fetchAssesers();
          }
        },
        child: const Text("Transfer Case"),
      ),
    ),
  );
}