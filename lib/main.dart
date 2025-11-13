import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'Views/sign/forgot.dart';
import 'package:flutter/material.dart';
import 'Views/sign/signIn.dart';
import 'Views/Navigation.dart';
import 'Views/sign/signUp.dart';

void main() async { 
  //final dir = await path.getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  var deta =await Hive.openBox('details');
  //var box =Hive.openBox("details");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visualizer',
      routes:{
        '/signIn':((context) =>signIn()),
        '/signUp':((context) =>SignUp()),
        '/navig':(context) => Navigation(),
        '/pass':((context) => Forgot())      
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: signIn(),
      debugShowCheckedModeBanner: false
    );
  }
}

