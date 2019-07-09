import 'package:flutter/material.dart';
import 'main_screen.dart' as ms;
import 'package:flutter/animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: MyHomePage(
        star: 3,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  int star;
  MyHomePage({Key key, this.star}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(star ?? 5);
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int star;
  _MyHomePageState(this.star);

  Animation animation;
  Animation animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..forward();

    animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.fastOutSlowIn, parent: animationController));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  height: height/2.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/done.png'),
                          fit: BoxFit.cover))),
              SizedBox(height: 15.0),
              Text(
                'CONGRATULATIONS',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25.0,
                    fontFamily: 'Uniform Bold',
                    color: Color(0XFF2284A1)),
              ),
              SizedBox(height: 10.0),
              Text(
                'You have completed a challenge from',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    fontFamily: 'Uniform Bold',
                    color: Colors.grey[500]),
              ),
              SizedBox(height: 10.0),
              Text(
                'LEVEL $star',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    fontFamily: 'Uniform Bold',
                    color: Colors.grey[800]),
              ),
              SizedBox(height: 35.0),
              Text(
                'You earn',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                    fontFamily: 'Uniform Bold',
                    color: Colors.grey[500]),
              ),
              SizedBox(height: 10.0),
              Transform(
                  transform: Matrix4.translationValues(
                      0.0, animation.value * height, 0.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: myWidget(star))),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'STARS',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'Uniform Bold',
                    color: Colors.grey[800]),
              ),
              SizedBox(
                height: 15.0,
              ),
              
            ]),
            bottomSheet: Container(
              // color:Colors.white,
              margin:  EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/6, 0, 0, 15),
              // padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/3, 0, 0, 20),
                height: 45.0,
                width: MediaQuery.of(context).size.width*4/6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xFFE73131)),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Color(0xFFE73131),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ms.TabsDemoScreen();
                      }),
                    );
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: Colors.white),
                  ),
                ),
              ),
          );
        });
  }

  List<Widget> myWidget(int star) {
    return List.generate(
        star,
        (i) => Image.asset('assets/tara1.gif',
            width: 40.0,
            height: 40.0,
            fit:
                BoxFit.cover)); // replace * with your rupee or use Icon instead
  }
}
