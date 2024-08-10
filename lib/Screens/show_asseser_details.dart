import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:import_lookup/Widgets/show_asseser_detail.dart';

class ShowAsserDetails extends StatefulWidget {
  const ShowAsserDetails({super.key,});
  @override
  State<ShowAsserDetails> createState() => _ShowAsserDetailsState();
}

class _ShowAsserDetailsState extends State<ShowAsserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Show Arear date'),),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('assesers').snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){

                return ShowAsseser(snap: snapshot.data!.docs[index].data(),index: index,);
              });
        },
      ),
    );
  }
}