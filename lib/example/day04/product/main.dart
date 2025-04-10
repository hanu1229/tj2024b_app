

import "package:flutter/material.dart";
import "package:tj2024b_app/example/day04/product/detail.dart";
import "package:tj2024b_app/example/day04/product/home.dart";
import "package:tj2024b_app/example/day04/product/update.dart";
import "package:tj2024b_app/example/day04/product/write.dart";

void main() {
  runApp(EntryPoint());
}

class EntryPoint extends StatelessWidget {

  dynamic route = {
    "/" : (BuildContext context) => Home(),
    "/write" : (BuildContext context) => Write(),
    "/detail" : (BuildContext context) => Detail(),
    "/update" : (BuildContext context) => Update(),
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