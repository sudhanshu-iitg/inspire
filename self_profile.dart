import 'dart:ui';
import 'post2.dart' as post;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'main.dart' as login;

main(String uid) {
  print("main");
  print("main2");
  return MyApp(
    uid: uid,
  );
}

bool bs = false;

Profile profile;
int ins;
String follow;

class MyApp extends StatefulWidget {
  final String uid;
  MyApp({Key key, this.uid}) : super(key: key);
  @override
  _MApp createState() => _MApp(uid);
}

class _MApp extends State<MyApp> {
  String uid;
  _MApp(this.uid);
  List<Widget> items = [];
  getprofile(String uid) async {
    // print("in get...");
    await Firestore.instance.collection("USER").document(uid).get().then((a) {
      profile = Profile.fromDocument(a);
      ins = profile.ins;
      // print("in get profile");
    });

    Firestore.instance
        .collection("POST")
        .where("uid", isEqualTo: uid)
        .where('privacy', isEqualTo: '0')
        .getDocuments()
        .then((s) {
      for (var a in s.documents) {
        items.add(post.MyHomePage(
          snap: a,
        ));
      }
    }).then((a) {
      setState(() {
        bs = true;
      });
    });
  }

  @override
  void initState() {
    print("inside profile");

    super.initState();
    bs = false;
    //  items = [];
    print(uid);
    getprofile(uid);
  }

  @override
  Widget build(BuildContext context) {
    if (bs == false) {
      // print("in if");
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else
      return Scaffold(
        body: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 210.0,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.network(
                          profile.photoURL,
                          fit: BoxFit.cover,
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 160.0,
                    left: MediaQuery.of(context).size.width/3,
                    child: Container(
                        width: MediaQuery.of(context).size.width/3,
                        height: MediaQuery.of(context).size.width/3,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill, image: NetworkImage(profile.photoURL)))),
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 290.0,
                      ),
                      Text(profile.uname,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 23.0,
                              fontFamily: 'Segoe UI',
                              color: Color(0xFF7D7979))),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('inspiring $ins people',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Segoe UI',
                              color: Colors.grey[500])),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Color(0xFF686868),
                            onPressed: () {},
                            child: Text(
                              '#coder',
                              style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.white54),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Color(0xFF686868),
                            onPressed: () {},
                            child: Text(
                              '#traveller',
                              style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.white54),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Color(0xFF686868),
                            onPressed: () {},
                            child: Text(
                              '#fitnessfreak',
                              style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.white54),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                          height: 1.0, width: 330.0, color: Colors.grey[300]),
                      SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height: 30.0,
                                  width: 30.0,
                                  child:  Icon(Icons.star,color:Color(0xfff9d624))
                                  
                                ),
                                Text(profile.bnum.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19.0,
                                        fontFamily: 'Segoe UI',
                                        color: Color(0xFF898383)))
                              ]),
                          Container(
                              height: 60.0,
                              width: 1.0,
                              color: Colors.grey[300]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height: 30.0,
                                  width: 30.0,
                                  child:
                                    Icon(Icons.flag,color:Color(0xff2284a1))
                                  
                                ),
                                Text(profile.cnum.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19.0,
                                        fontFamily: 'Segoe UI',
                                        color: Color(0xFF898383))),
                              ]),
                          
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                          height: 1.0, width: 330.0, color: Colors.grey[300]),
                      SizedBox(
                        height: 20.0,
                      ),

                      SizedBox(
                        height: 10.0,
                      ),
                      // ListView(children: items,),
                      Column(
                        children: items,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ]),
      );
  }

  String checkfollow(String follow) {
    if (follow == "false") {
      return "get inspired";
    } else if (follow == "pending") {
      return "pending";
    } else
      return "inspired";
  }
}

class Profile {
  final String photoURL;
  final int cnum;
  final int mnum;
  final int urating;
  final String uname;
  final int bnum;
  final int ins;
//final String image_url;
//final String user_url;
//final String did;

  Profile({
    this.photoURL,
    this.cnum,
    this.mnum,
    this.urating,
    this.uname,
    this.bnum,
    this.ins,
  });

  factory Profile.fromDocument(DocumentSnapshot document) {
    return new Profile(
      //did:document.documentID,
      uname: document['uName'],
      cnum: document['cnum'],
      mnum: document['mnum'],
      photoURL: document['photoURL'],
      //user_url: document['user_url'],

      //d: document['timestamp'],
      urating: document['urating'],
      bnum: document["bnum"],
      ins: document["ins"],
    );
  }
}
