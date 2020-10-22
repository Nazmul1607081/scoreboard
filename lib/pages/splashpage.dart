import 'package:flutter/material.dart';
import 'package:scoreboard/pages/loginpage.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashPage extends StatefulWidget {
  @override
  _MySplashPageState createState() => _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 7,
      navigateAfterSeconds: new MyLoginHead(),
      title: new Text(
        'Scoreboard',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
      image: new Image.asset('images/splashpage.png'),
      gradientBackground: LinearGradient(
          begin: Alignment.topCenter,
          colors: [Colors.orange[900], Colors.orange[800], Colors.orange[400]]),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
    ;
  }
}
