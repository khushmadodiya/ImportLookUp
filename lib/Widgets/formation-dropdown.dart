import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class GlobleDropdown extends StatefulWidget {
  final GlobalKey? dropdownKey;
  final String selectedItem;
  final ValueChanged<String?> fun;
  final String label;
  final List<String> listofvalues;

  const GlobleDropdown({
    super.key,
    this.dropdownKey,
    required this.listofvalues,
    required this.label,
    required this.fun,
    required this.selectedItem,
  });

  @override
  State<GlobleDropdown> createState() => _GlobleDropdownState();
}

class _GlobleDropdownState extends State<GlobleDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: widget.dropdownKey,
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple[50]!, Colors.deepPurple[100]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownSearch<String>(
            onChanged: (val) {
              widget.fun(val);
              setState(() {});
            },
            items: widget.listofvalues,
            selectedItem: widget.selectedItem,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: widget.label,
                labelStyle: const TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),


                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.deepPurple, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              baseStyle: const TextStyle(
                color: Colors.blueAccent, // Color for the selected item text
                fontSize: 16,
                // fontWeight: FontWeight.bold,
              ),
            ),
            popupProps: const PopupProps.menu(
              fit: FlexFit.loose,
              constraints: BoxConstraints(maxHeight: 300),
              // showSearchBox: true,
            ),
          ),
        ),
      ),
    );
  }
}
