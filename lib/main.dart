import 'package:chate_com_firebase/screens/auth_screen.dart';
import 'package:chate_com_firebase/screens/chart_screan.dart';
import 'package:chate_com_firebase/screens/contacts_screan.dart';
import 'package:chate_com_firebase/screens/credit.dart';
import 'package:chate_com_firebase/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue[100]
      ),
      routes: routes(),
      initialRoute: FirebaseAuth.instance.currentUser != null ? Splash.route : AuthScreen.route,
    );
  }
}



routes() =>  {
    Splash.route: (context) => Splash(),
    Credit.route: (context) => Credit(),
    AuthScreen.route: (context) => AuthScreen(),
    ContactsScrean.route: (context) => ContactsScrean(),
    ChartScreen.route: (context) => ChartScreen(),
};
