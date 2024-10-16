import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:import_lookup/Backend-New/main-cases-details.dart';
import 'package:import_lookup/Backend-New/tar-report.dart';
import 'package:import_lookup/Model-New/tar-model.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage; // Variable to hold the error message
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData()async{
    print("success 1");
   var res=await TarReportInformation().litigationReport();
   TarReportModel ele=res["data"]["hcreceipts"] as TarReportModel;
   print("hee;o i ma dipu ${ele.closingBalance}");
  //  TarReportModel model=TarReportModel.from(res["data"];
    // print("success  ${model.amountOfTheMonth}   ${model.amountUpTotheMonth}");
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Table'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildCardTextField(_controller, 'Enter something'),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    setState(() {
                      _errorMessage = null; // Clear the error message
                    });
                    // Handle valid input
                  } else {
                    setState(() {
                      _errorMessage = 'Please enter some text'; // Set error message
                    });
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text'; // Validation message
            }
            return null;
          },
          
          decoration: InputDecoration(
            error:null,
            errorStyle:TextStyle(fontSize:0),
            labelText: label,
            labelStyle: GoogleFonts.daiBannaSil(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(16.0),
          ),
          style: GoogleFonts.daiBannaSil(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.purple.withOpacity(0.9),
          ),
        ),
      ),
    );
  }
}
