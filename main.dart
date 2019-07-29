import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'main_screen1.dart' as ms;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'notif-handler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'onboarding.dart' as on;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

String uid;
String uname;
String photo;
double width = 300;
double height = 300;
FirebaseAnalytics analytics = FirebaseAnalytics();
void main() {

  

  runApp(
    MaterialApp(
       navigatorObservers: [
    FirebaseAnalyticsObserver(analytics: analytics),
  ],
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

    return  Scaffold(
        body: Container(
          child:  SingleChildScrollView
          (child:userI(),),
          
        ),
      
    );
  }

  void initGoogleLogin() async {
    print("0");
    final GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    print("1");
    DocumentReference ref =
        Firestore.instance.collection('USER').document(googleAccount.id);
    ref.setData({
      'uid': googleAccount.id,
      'email': googleAccount.email,
      'photoURL': googleAccount.photoUrl,
      'uName': googleAccount.displayName,
      //'lastSeen': DateTime.now()
    }, merge: true);
    print("2");
    save(
      googleAccount.id,
      googleAccount.displayName,
      googleAccount.photoUrl,
    );
    print("3");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return ms.MyHomePage();
      }),
    );

    print("4");
    uid = googleAccount.id;
    uname = googleAccount.displayName;
    photo = googleAccount.photoUrl;
  }

  void initiateFacebookLogin() async {
    print("inside initiate facebook login");
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);
    //print(facebookLoginResult);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        // print(profile['id']);
        DocumentReference ref =
            Firestore.instance.collection('USER').document(profile['id']);
        ref.setData({
          'uid': profile['id'],
          'email': profile['email'],
          'photoURL': profile['picture']['data']['url'],
          'uName': profile['name'],
          //'lastSeen': DateTime.now()
        }, merge: true);
        save(
          profile['id'],
          profile['name'],
          profile['picture']['data']['url'],
        );

        onLoginStatusChanged(true, profileData: profile);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return ms.MyHomePage();
          }),
        );
        break;
    }
    uid = profileData['id'];
    uname = profileData['name'];
    photo = profileData['picture']['data']['url'];
  }

  userI() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(width / 3, 50, width / 3, 50),
          child: Text("inspire", style: TextStyle(fontSize: 20)),
        ),
        Container(
          height: height / 2,
          child: PageView(
              onPageChanged: (int inr) {
                setState(() {
                  pgn = inr;
                });
              },
              controller: pageController,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: height / 3.5,
                      child: Text("vector"),
                    ),
                    Center(
                      child: Text("Line"),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: height / 3.5,
                      child: Text("vector"),
                    ),
                    Center(
                      child: Text("Line"),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: height / 3.5,
                      child: Text("vector"),
                    ),
                    Center(
                      child: Text("Line"),
                    ),
                  ],
                )
              ]),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Container(
              // width: width/3,
              child: dots(),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Spacer(),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Sign IN"),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ms.MyHomePage();
                            }),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/google.png',
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          initiateFacebookLogin();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/facebook.png",
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        )
      ],
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

  void check() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'exist';
    final value = prefs.getBool(key) ?? false;
    print('read: $value');
    if (value) {
      setState(() {
        print('check true');
        uid = prefs.getString("uid");
        uname = prefs.getString("uname");
        photo = prefs.getString("photo");
        print(uid ?? 'shit');
        isLoggedIn = true;
      });
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     return ms.TabsDemoScreen();
      //   }),
      // );
    } else {
      print('check false');
      isLoggedIn = false;
    }
  }

  save(String a, String b, String c) async {
    print("profile saved");
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool("exist", true);
    prefs.setString("uid", a);
    prefs.setString("uname", b);
    prefs.setString("photo", c);
    print('saved ');
  }
}
