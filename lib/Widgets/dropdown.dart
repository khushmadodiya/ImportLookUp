import 'package:flutter/material.dart';

import '../global.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return  DropdownButton<String>(
      isExpanded: true,
        value: selecteditem,
        items: <String>[value1, value2,value3,value4,value5,value6,value7,value8,value9,value10,value11,value12,value13,value14]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Center(child: Text(value,style: TextStyle(fontSize: 17)))
          );
        }).toList(),

        onChanged: (String? newval){
          setState(() {
            selecteditem = newval!;
            print(selecteditem);
          });
        }
    );
  }
}
