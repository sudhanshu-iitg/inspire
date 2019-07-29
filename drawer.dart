import 'package:flutter/material.dart';
import 'pchallenge1.dart' as pc1;
import 'self_profile.dart' as profile;
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'drawerdetails.dart' as d;
import 'people.dart' as people;

String url = '';
String name = '';
pro(context) {
  Firestore.instance.collection("USER").document(uid).get().then((a) {
    url = a["photoURL"];
    name = a["uName"];
  });

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Container(

        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          color:Colors.grey[200],
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(url),
          ),
        ),
      ),
      Text(
        uname.split(" ")[0]+ "\n"+uname.split(" ")[1],
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

drawer(context) {
  return Drawer(
    child: Center(child:Column(
      // padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        DrawerHeader(
          child: pro(context),
          decoration: BoxDecoration(
                  color: Colors.grey[100],
              ),
        ),
     
        ListTile(
          title: Text('Create personal challenge'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) {
                return pc1.MyHomePage();
              }),
            );
          },
        ),
        ListTile(
          title: Text('Our Mission'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) {
                return d.MyHomePage("mission");
              }),
            );
          },
        ),
        ListTile(
          title: Text('Join our Team'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) {
                return d.MyHomePage("team");
              }),
            );
          },
        ),
        ListTile(
          title: Text('Suggest Changes'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) {
                return d.MyHomePage("changes");
              }),
            );
          },
        ),
        ListTile(
          title: Text('Discover People'),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) {
                return people.MyHomePage();
              }),
            );
          },
        ),
      ],
    ),),
  );
}
