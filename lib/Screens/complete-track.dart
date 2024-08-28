// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class CompleteTrackScreen extends StatefulWidget {
  List<dynamic>complete_track;
   CompleteTrackScreen({super.key,required this.complete_track});

  @override
  State<CompleteTrackScreen> createState() => _CompleteTrackScreenState();
}

class _CompleteTrackScreenState extends State<CompleteTrackScreen> {
  @override
  Widget build(BuildContext context) {
    // print("divyansh ${widget.complete_track}");
    return Scaffold(
      appBar:AppBar(),
      body:Container(
        width:MediaQuery.of(context).size.width,
        height:double.maxFinite,
        // color:Colors.amber,
       child: ListView.builder(itemBuilder:(context,index){
        print("heelo ${widget.complete_track[index]}");
        return ListTile(
          title:Text(widget.complete_track[index].toString()),
        );
        
       },
       itemCount:widget.complete_track.length,
       )
      ),
    );
  }
}