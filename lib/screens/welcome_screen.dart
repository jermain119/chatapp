// import '/screens/login_screen.dart';
// import '/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import '/components/Rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'login',
              colour: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, 'LoginScreen');
              },
            ),
            RoundedButton(
              title: 'RegistrationScreen',
              colour: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, 'RegistrationScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}

