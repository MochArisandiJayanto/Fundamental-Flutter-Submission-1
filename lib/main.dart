import 'package:flutter/material.dart';
import 'package:flutter_sub1/screens/get_started.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAJ Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: GetStarted(),
    );
  }
}