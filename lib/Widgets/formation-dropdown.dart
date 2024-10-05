import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Backend-New/Golbal-Files/category-and-subcategory.dart';

class GlobleDropdown extends StatelessWidget {
   final dropdownkey;
   final label;
   final List<String> listofvalues ;
   GlobleDropdown({super.key, this.dropdownkey, required this.listofvalues, required this.label});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      key: dropdownkey,
      padding: const EdgeInsets.all(0.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        child: Container(

          decoration: BoxDecoration(
              color: Colors.blue[50],
            borderRadius: BorderRadius.circular(15)
          ),
          child: DropdownSearch<String>(
            items: listofvalues,

            selectedItem: listofvalues[0],
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15)
                ),
                // fillColor: Colors.blue[50],

              ),
            ),
            popupProps: PopupProps.menu(
                fit: FlexFit.loose, constraints: BoxConstraints(maxHeight: 300)),
          ),
        ),
      ),

    );
  }
}
