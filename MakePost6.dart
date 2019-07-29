import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'video4.dart' as video;
import 'main.dart' as login;
import 'congo.dart' as congo;

class Persona extends StatefulWidget {
  String cname, scat, level, tag, image;
  Persona({Key key, this.cname, this.scat, this.level, this.tag, this.image})
      : super(key: key);

  @override
  _PersonaState createState() => _PersonaState(cname, scat, level, tag, image);
}

class _PersonaState extends State<Persona> {
  String cname, scat, level, tag, image;
  _PersonaState(this.cname, this.scat, this.level, this.tag, this.image);

  File samplei;
  File samplev;
  // bool _switchVal=false;
  int _radioValue1 = 0;
  final myController = TextEditingController();
  StorageUploadTask task;
  String url;
  bool upload;
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    //_switchVal=false;
    //state=false;
    upload = false;
    samplei = null;
    samplev = null;
    _radioValue1 = 0;
  }

  Widget Choose() {
    return Container(
      height: 258.0,
      // width: 340.0,
      child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(6.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 0.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        elevation: 4,
                        child: GestureDetector(
                          onTap: () {
                            getImagec();
                          },
                          child: Container(
                            height: 80.0,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Add Photo",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                                Text("Via Camera",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: GestureDetector(
                          onTap: () {
                            getImageg();
                          },
                          child: Container(
                            height: 80.0,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Add Photo ",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                                Text("Via Gallery",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Text('Add Photo via camera',style:TextStyle(fontWeight:FontWeight.w600, fontSize: 16.0,fontFamily: 'Segoe UI',color:Colors.grey[800])),
                      Card(
                        elevation: 4,
                        child: GestureDetector(
                          onTap: () {
                            getVideoc();
                          },
                          child: Container(
                            height: 80.0,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Add Video",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                                Text("Via Camera",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: GestureDetector(
                          onTap: () {
                            getVideog();
                          },
                          child: Container(
                            height: 80.0,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Add Video",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                                Text("Via Gallery",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        fontFamily: 'Segoe UI',
                                        color: Colors.grey[800])),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              ])),
    );
  }

  Widget Post() {
    if (samplei != null) {
      return Container(
        padding: EdgeInsets.all(10),
        height: 258.0,
        width: 340.0,
        child: Material(
          elevation: 1.0,
          borderRadius: BorderRadius.circular(6.0),
          child: Image.file(samplei, height: 280.0, width: 320.0),
        ),
      );
    } else if (samplev != null) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: 400,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: video.VideoApp(video: samplev),
        ),
      );
    }
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  Future getImageg() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    // var tempImage = await ImagePicker.pickVideo(source: ImageSource.camera,);
    setState(() {
      samplei = tempImage;
    });
  }

  Future getImagec() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);
    // var tempImage = await ImagePicker.pickVideo(source: ImageSource.camera,);
    setState(() {
      samplei = tempImage;
    });
  }

  Future getVideog() async {
    //var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    var tempImage = await ImagePicker.pickVideo(
      source: ImageSource.gallery,
    );
    setState(() {
      samplev = tempImage;
    });
  }

  Future getVideoc() async {
    var tempImage = await ImagePicker.pickVideo(
      source: ImageSource.camera,
    );
    setState(() {
      samplev = tempImage;
    });
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    
    String postname, description;
    getlink(String type) async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return congo.MyHomePage(
            star: lev(),
          );
        }),
      );
      StorageTaskSnapshot downloadUrl = await task.onComplete;
      url = await downloadUrl.ref.getDownloadURL() as String;

      await Firestore.instance.collection("POST").document(postname).setData({
        "body": description ?? myController.text,
        // "url": url,
        "timestamp": DateTime.now(),
        "level": level,
        "scat": scat,
        "cname": cname,
        "privacy": _radioValue1.toString(),
        "uid": login.uid,
        "user_url": login.photo,
        "uname": login.uname,
        "nopr": 0,
        "stars": 0,
        "rating": 0,
        "dou": 0.01,
        "media_url": url,
        "mtype": type,
        "ctag": tag,
        "id": postname,
      });

      if (_radioValue1 == 0 || _radioValue1 == 1) {
        var snap = await Firestore.instance
            .collection("RELATIONS")
            .where('A', isEqualTo: login.uid)
            .getDocuments();
        for (var doc in snap.documents) {
          await Firestore.instance
              .collection("USER")
              .document(doc.data['B'])
              .collection("FEED")
              .document(postname)
              .setData({
            "timestamp": DateTime.now(),
          });
        }
      }
      print("upload");
      updatedata(postname);
    }

    return Scaffold(
      key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey[800]),
          title: Text('', style: TextStyle(color: Colors.grey[800])),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            RaisedButton(
                color: Color(0xffe73131),
                child: Text("POST",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        fontFamily: 'Segoe UI',
                        color: Colors.white)),
                onPressed: () {
                  String timenow = DateTime.now().toString();
                  postname = login.uid + timenow;
                  if (myController.text != null &&
                      (samplei != null || samplev != null)) {
                    upload = false;
                    // _showDialog(false);
                    final StorageReference firebaseStorageRef =
                        FirebaseStorage.instance.ref().child(postname);
                    task = firebaseStorageRef
                        .putFile((samplev != null) ? samplev : samplei);
                    getlink((samplev != null) ? "v" : "i");
                  }
                  else {
                    print("object");
                   _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Select a Media file first'),
      duration: Duration(seconds: 2),
    ));
                  }
                }),
          ],
        ),
        body: ListView(children: [
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(height: 15.0),

            Container(
              margin: EdgeInsets.all(10),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              child: Theme(
                data: new ThemeData(
                  primaryColor: Color(0xffe73131),
                  primaryColorDark: Color(0xffe73131),
                ),
                child: TextField(
                  onChanged: (string) {
                    setState(() {
                      description = string;
                    });
                  },
                  controller: myController,
                  decoration: const InputDecoration(
                    focusColor: Color(0xffe73131),
                    border: OutlineInputBorder(),
                    hintText: "How are you feelin abt it?",
                    labelText: "Description",
                  ),
                  maxLines: 4,
                ),
              ),
            ),
            SizedBox(height: 20.0),

            Container(
              height: 20.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Post Privacy",
                    style: TextStyle(
                        color: Color(0xFFe73131),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        fontFamily: 'Segoe UI'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Radio(
                  value: 0,
                  groupValue: _radioValue1,
                  onChanged: _handleRadioValueChange1,
                ),
                new Text(
                  'Global',
                  style: new TextStyle(fontSize: 16.0),
                ),
                new Radio(
                  value: 1,
                  groupValue: _radioValue1,
                  onChanged: _handleRadioValueChange1,
                ),
                new Text(
                  'Followers',
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                new Radio(
                  value: 2,
                  groupValue: _radioValue1,
                  onChanged: _handleRadioValueChange1,
                ),
                new Text(
                  'Private',
                  style: new TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            //SizedBox(height:35.0),

            SizedBox(height: 20.0),
            Container(
              height: 20.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tags attached",
                    style: TextStyle(
                        color: Color(0xFFe73131),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        fontFamily: 'Segoe UI'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      '#' + cname,
                      style: new TextStyle(
                          fontSize: 15.0, color: Color(0xff2284a1)),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    "#level  " + level.toUpperCase(),
                    style:
                        new TextStyle(fontSize: 15.0, color: Color(0xff2284a1)),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    '#' + scat,
                    style:
                        new TextStyle(fontSize: 15.0, color: Color(0xff2284a1)),
                  ),
                ),
              ],
            ),
            (samplei == null && samplev == null) ? Choose() : Post(),
            //Choose(),
            /*  Container(
              padding: EdgeInsets.all(40),
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Card(
                elevation: 5,
                child: DottedBorder(
                  padding: EdgeInsets.all(10),
                  color: Colors.black,
                  strokeWidth: 1,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(60, 20, 50, 20),
                        child: Image.asset(
                          "assets/upload.png",
                          scale: 2,
                          alignment: Alignment.center,
                        ),
                      ),
                      Text("Upload Media")
                    ],
                  ),
                ),
              ),
            ), */
          ])
        ]));
  }

  // void _showDialog(up) {
  //   // flutter defined function
  //   if (up == false) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         // return object of type Dialog
  //         return AlertDialog(

  //       content: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[ Text("Uploading post  "),  CircularProgressIndicator(),]),

  //           // content: new Text("Alert Dialog body"),
  //           actions: <Widget>[
  //             // usually buttons at the bottom of the dialog
  //             new FlatButton(
  //                shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //               color: Color(0xffe73131),
  //               child: Text("Upload in background",style: TextStyle(color: Colors.white),),
  //               onPressed: () { },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } else {
  //     Navigator.of(context, rootNavigator: true).pop();
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) {
  //         return congo.MyHomePage(
  //           star: lev(),
  //         );
  //       }),
  //     );
  //   }
  // }

  updatedata(postname) async {
    int bnum, unum, mnum;
    Firestore.instance.collection("USER").document(login.uid).get().then((a) {
      bnum = a['bnum'];
      unum = a['unum'];
      mnum = a['mnum'];
      switch (level) {
        case ('a'):
          {
            bnum = bnum + 1;
            break;
          }
        case ('b'):
          {
            bnum = bnum + 2;
            break;
          }
        case ('c'):
          {
            bnum = bnum + 3;
            break;
          }
        case ('d'):
          {
            bnum = bnum + 4;
            break;
          }
        case ('e'):
          {
            bnum = bnum + 5;
            break;
          }
      }
      mnum = mnum + 1;
      Firestore.instance.collection("USER").document(login.uid).updateData({
        'bnum': bnum,
        'unum': unum,
        'mnum': mnum,
      });
    });
    final QuerySnapshot result = await Firestore.instance
        .collection("USER")
        .document(login.uid)
        .collection("CHALLENGES")
        .where('cname', isEqualTo: cname)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length == 1) {
      Firestore.instance
          .collection("USER")
          .document(login.uid)
          .collection("CHALLENGES")
          .document(cname)
          .updateData({'status': "c", 'postid': postname});
    } else {
      Firestore.instance
          .collection("USER")
          .document(login.uid)
          .collection("CHALLENGES")
          .document(cname)
          .setData({
        'status': "c",
        'postid': postname,
        "curl": login.photo,
        'timestamp': DateTime.now()
      });
    }
  }

  lev() {
    switch (level) {
      case ('a'):
        {
          return 1;
        }
      case ('b'):
        {
          return 2;
        }
      case ('c'):
        {
          return 3;
        }
      case ('d'):
        {
          return 4;
        }
      case ('e'):
        {
          return 5;
        }
    }
  }
}
