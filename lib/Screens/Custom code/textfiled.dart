import 'package:flutter/material.dart';

// Custom TextField Widget
class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final double height;
  final double width;
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
    this.customValidator,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(

        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue[50]
        ),
        child: TextFormField(

          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
            hintText: widget.hintText,

            // labelStyle: ,
            labelText: widget.labelText,
            border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide.none,
      ),
          ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.customValidator


        ),
      ),
    );
  }
}
