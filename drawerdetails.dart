import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  final String drawer;
  MyHomePage(this.drawer);

  @override
  _MyHomePageState createState() => _MyHomePageState(drawer);
}

class _MyHomePageState extends State<MyHomePage> {
  String drawer;
  _MyHomePageState(this.drawer);
  bool loading = false;
  String title = '', body = 'The text might not be there';

  @override
  Widget build(BuildContext context) {
    !loading ? getdata() : null;

    return 
    // MaterialApp(
    //   home: 
      Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Center(child: Text(body),),
        ),
      // ),
    );
  }

  getdata() {
    Firestore.instance.collection("DRAWER").document(drawer).get().then((a) {
      setState(() {
        title = a['title'];
        body = a['body'];
        loading = true;
      });
    });
  }
}
