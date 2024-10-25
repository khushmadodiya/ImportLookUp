import 'dart:js';

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
          children:[... List.generate(
              FORMATION.length+1,
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
                          index==0?"All Formation":  FORMATION[index-1],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () {
                        provider.updateLoader();
                        generalProvider.updateSelectedIndex(index);
                        index==0?provider.getMainCasesInformation(formation: FORMATION[0], isAdmin: true): provider.getMainCasesInformation(formation: FORMATION[index-1], isAdmin: false);
                        provider.updateLoader();
                      },
                    ),
                  )),
        ]
        ),
      ),
    ),
  );
}
