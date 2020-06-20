import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profilefinalsql/profile.dart';
import 'insert.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.lightGreen),
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.lightGreen),
      //home: Insert(),
      home: DetailScreen(),
    );
  }
}
