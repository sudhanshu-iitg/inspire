import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'main_screen.dart' as ms;
import 'MakePost6.dart' as post;
import 'main.dart' as login;

void main() {}

class MyHomePage extends StatefulWidget {
  final String cname, image;
  final bool show;
  MyHomePage({Key key, this.cname, this.image, this.show}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(cname, image, show);
}

class _MyHomePageState extends State<MyHomePage> {
  final String cname, image;
  final bool show;

  _MyHomePageState(this.cname, this.image, this.show);
  String description, scat, level, tag, media = '', mtype = '';

  bool state = false;
  void initState() {
    super.initState();
    state = false;
  }

  bool hide=true;
  getdata() async {
    await Firestore.instance
        .collection('CHALLENGES')
        .document(cname)
        .get()
        .then((a) {
      description = a['description'];
      scat = a['scat'];
      level = a['level'];
      tag = a['tag'];
      if (a['mtype'].toString().isNotEmpty &&
          a['media'].toString().isNotEmpty) {
        media = a['media'];
        mtype = a['mtype'];
      }
      setState(() {
        print(media);
        state = true;
      });
    });
  }

  Widget build(BuildContext context) {
    state == false ? getdata() : null;

    return 
    // MaterialApp(
    //   home: 
      Scaffold(
        body: Builder(
          builder: (context) => Container(
                child: (!state)
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 200.0,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey[300],
                              child: res(),
                            ),
                            Padding(
                              child: Text(
                                cname.substring(0, 1).toUpperCase() +
                                    cname.substring(1),
                                style: TextStyle(
                                    fontSize: 31.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Uniform Bold',
                                    color: Colors.grey[900]),
                              ),
                              padding:
                                  EdgeInsets.fromLTRB(16.0, 20.0, 0.0, 0.0),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.0, 15.0, 0.0, 15.0),
                              child: Text(
                                "3 people did",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Segoe UI',
                                    color: Colors.grey[800]),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.0, 15.0, 12.0, 15.0),
                              child: Text(
                                description,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Open Sans',
                                    color: Colors.grey[600]),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.0, 10.0, 0.0, 20.0),
                              child: Text(
                                "Upload a small video or take a photo",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Segoe UI',
                                    color: Colors.grey[800]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              // padding: EdgeInsets.fromLTRB(
                              //     MediaQuery.of(context).size.width / 2.35, 10, 0, 0),
                              child: show
                                  ? Center(
                                      child: OutlineButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          onPressed: () {
                                            print("da");
                                            dolater(context);
                                          },
                                          color: Colors.white,
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "      Do Later      ",
                                                style: TextStyle(
                                                    color: Color(0xff2284a1),
                                                    fontSize: 17),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          )),
                                    )
                                  : null,
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
              ),
        ),
        bottomSheet: bottom(),
        endDrawer: bottom(),
        // bottomSheet: bottom(),
      )
    // ,)
    ;
  }

  Widget bottom() {
    if(hide){
    return  Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width / 5, 0.0, 0.0, 15.0),
          width: MediaQuery.of(context).size.width / 1.2,
          height: 65,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return post.Persona(
                      cname: cname,
                      scat: scat,
                      level: level,
                      tag: tag,
                      image: image);
                }),
              );
            },
            color: Color(0xffe73131),
            child: Text(
              "Do now",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        )
      ],
      // ),
    );
  
  }
  else return Container(height: 0.01,);
  
  }

  void dolater(con) {
    Firestore.instance
        .collection("USER")
        .document(login.uid)
        .collection("CHALLENGES")
        .document(cname)
        .setData({
      "status": "a",
      "timestamp": DateTime.now(),
      "curl": image,
    });
    setState(() {
     hide=false; 
    });
    Future.delayed(const Duration(milliseconds: 2500), () {

// Here you can write your code

  setState(() {
    hide=true;
  });

});
    Scaffold.of(con).showSnackBar(SnackBar(
      content: Text('Challenge added to your Stats'),
      duration: Duration(seconds: 2),
    ));
  }

  res() {
    if (mtype == 'image') {
      return Image.network(
        media,
        fit: BoxFit.fill,
      );
    } else {
      return Image.network(
        image,
        fit: BoxFit.fill,
      );
    }
  }
}
