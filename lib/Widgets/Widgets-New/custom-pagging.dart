

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/Provider-New/add-new-cases.dart';
import 'package:provider/provider.dart';

import '../../Backend-New/Golbal-Files/category-and-subcategory.dart';
import '../../Provider-New/general-pusrpose.dart';

Widget CutomPagging() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Consumer<AddNewCase>(
      builder: (context, provider, child) => Consumer<GeneralPurposeProvider>(
        builder: (context, generalProvider, child) => Row(
          children: List.generate(
              FORMATION.length,
              (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Container(
                        color: generalProvider.selectedIndex == index
                            ? Colors.blue
                            : Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                           FORMATION[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        provider.updateLoader();
                        generalProvider.updateSelectedIndex(index);
                        provider.getMainCasesInformation(formation: FORMATION[index], isAdmin: false);
                        provider.updateLoader();
                      },
                    ),
                  )),

        ),
      ),
    ),
  );
}
