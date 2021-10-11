import 'package:flutter/material.dart';
import 'package:greencycle/screens/home.dart';
import 'package:greencycle/screens/onboarding.dart';
import 'package:greencycle/screens/register.dart';
import 'package:greencycle/screens/login.dart';
import 'package:greencycle/screens/profile.dart';
import 'package:greencycle/screens/misacciones.dart';
import 'package:greencycle/screens/misgrupos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GreenCycle',
        theme: ThemeData(fontFamily: 'Railway'),
        initialRoute: "/misacciones",
        routes: <String, WidgetBuilder>{
          "/onboarding": (BuildContext context) => new Onboarding(),
          "/home" : (BuildContext context) => new Home(),
          "/register" : (BuildContext context) => new Register(),
          "/login" : (BuildContext context) => new Login(),
          "/profile" : (BuildContext context) => new Profile(),
          "/misacciones" : (BuildContext context) => new MisAcciones(),
          "/misgrupos" : (BuildContext context) => new MisGrupos(),
        });
  }
}