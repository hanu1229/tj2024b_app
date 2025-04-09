// main.dart : 웹 실행의 최초 파일

import "package:flutter/material.dart";
import "package:tj2024b_app/example/day04/todo/home.dart";
import "package:tj2024b_app/example/day04/todo/write.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  dynamic route = {
    "/" : (BuildContext context) => Home(),
    "/write" : (BuildContext context) => Write(),
    // "/update" : (BuildContext context) => Update(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      initialRoute : "/",
      routes : route,
    );
  }

}