import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'notif-handler.dart';
import 'package:google_sign_in/google_sign_in.dart';

String uid;
String uname;
String photo;
double width = 300;
double height = 300;

void main() {
  runApp(
    MaterialApp(
      home: LoginPage(),
    ),
  );
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoggedIn;
  var profileData;
  PageController pageController = PageController();
  List<Widget> lc1 = [], lc2 = [], lc3 = [], lc4 = [], lc5 = [];

  @override
  void initState() {
    isLoggedIn = false;
    profileData = null;
    uid = null;
    uname = null;
    photo = null;
    print(isLoggedIn);
    // check();
    super.initState();
    FirebaseNotifications().setUpFirebase();
    // check();
    // initiateFacebookLogin();
  }

  var facebookLogin = FacebookLogin();
  var googleSignIn = GoogleSignIn();
  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  int pgn = 0;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: userI(),
          ),
        ),
      ),
    );
  }

  userI() {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          child: PageView(
              onPageChanged: (int inr) {
                setState(() {
                  pgn = inr;
                });
              },
              scrollDirection: Axis.vertical,
              // physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: height/1.5,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            right: width/3.3,
                            bottom: height/3.2,
                            child: SizedBox(
                              height: height / 2.5,
                              child:
                                  Image.asset("assets/1.png", fit: BoxFit.fill),
                            ),
                          ),
                          Positioned(
                            top: height/5,
                            left: width/3.3,
                            child: SizedBox(
                              height: height / 2.5,
                              child: Image.asset(
                                "assets/1-2.png",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Spacer(),
                    Text(
                      "Line 1",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Line 2",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: height / 2,
                      child: Image.asset("assets/2.png", fit: BoxFit.fill),
                    ),
                    Text(
                      "Line 1",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Line 2",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: height / 2,
                      child:
                          Image.asset("assets/000 – 4.png", fit: BoxFit.fill),
                    ),
                    Text(
                      "Line 1",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Line 2",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: height / 2,
                      child:
                          Image.asset("assets/000 (1).png", fit: BoxFit.fill),
                    ),
                    Text(
                      "Line 1",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Line 2",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: height / 2,
                      child: Image.asset("assets/iPhone 6-7-8 – 9.png",
                          fit: BoxFit.fill),
                    ),
                    Text(
                      "Line 1",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Line 2",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ]),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (pgn != 4) {
              setState(() {
                pgn++;
              });
              pageController.animateToPage(pgn,
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            } else
              pageController.animateToPage(0,
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);
          },
          backgroundColor: Colors.red,
          child: Icon(Icons.arrow_downward),
        ),
      ),
    );
  }

  dots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon(0),
        SizedBox(
          width: 3,
        ),
        icon(1),
        SizedBox(
          width: 3,
        ),
        icon(2),
      ],
    );
  }

  icon(int a) {
    if (a == pgn) {
      return Container(
        padding: EdgeInsets.all(15),
        height: 10,
        width: 10,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      );
    } else
      return Container(
        padding: EdgeInsets.all(15),
        height: 7,
        width: 7,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.grey[400]),
      );
  }
}
