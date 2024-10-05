
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldInput extends StatefulWidget {

  final TextEditingController textEditingController;

  final String hintText;
  final TextInputType textInputType;
  final maxlines;
  final ispass;

  const TextFieldInput({
    Key? key,
    required this.textEditingController,

    required this.hintText,
    required this.textInputType, this.maxlines=1, this.ispass=false,

      }) : super(key: key);

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {

  @override
  Widget build(BuildContext context) {


    return Card(
      elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      child: TextFormField(

        maxLines: widget.maxlines,

        decoration: InputDecoration(
          fillColor: Colors.blue[50],
          hintText: widget.hintText,
          border:OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide.none,
          ),
          label: Text(widget.hintText),
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (text)=>setState(() {
          widget.textEditingController.text =text;
        }),
        obscureText: widget.ispass ? true : false,
      ),
    );
  }
}
