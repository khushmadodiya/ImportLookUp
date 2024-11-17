import 'package:flutter/material.dart';
import 'package:import_lookup/Provider-New/general-pusrpose.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconButton? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final double height;
  final double width;
  final String? helperText;
  final String? Function(String?)? customValidator;

  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.height = 55.0,
    this.width = double.infinity,
    this.helperText,
    this.customValidator,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple[50]!, Colors.deepPurple[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 18,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: Colors.blueAccent)
                : null,
            suffixIcon: widget.suffixIcon,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            labelText: widget.labelText,
            labelStyle: const TextStyle(color: Colors.blueAccent),
            helperText: widget.helperText,
            helperStyle: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 12,
            ),
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.deepPurple, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.customValidator,
        ),
      ),
    );
  }
}
