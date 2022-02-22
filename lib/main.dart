
// @dart=2.9


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '/screens/welcome_screen.dart';
import '/screens/login_screen.dart';
import '/screens/registration_screen.dart';
import '/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      // welcome is starting app
      initialRoute: '/WelcomeScreen',
      routes: {
        //! no  '_' underscores in route naming
        '/WelcomeScreen':(context)=> WelcomeScreen(),
        'RegistrationScreen': (context)=> RegistrationScreen(),
         'LoginScreen': (context)=> LoginScreen(),
         'ChatScreen': (context)=> ChatScreen(),


      },
    );
  }
}
