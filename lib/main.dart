import 'package:flutter/material.dart';
import 'package:greencycle/screens/home.dart';
import 'package:greencycle/screens/onboarding.dart';

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
      initialRoute: "/home",
      routes: <String, WidgetBuilder>{
        "/onboarding": (BuildContext context) => new Onboarding(),
        "/home" : (BuildContext context) => new Home(),
      });
  }
}
