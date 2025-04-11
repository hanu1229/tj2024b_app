// main.dart : 진입점 | 익명 책 추천 어플

import "package:flutter/material.dart";
import "package:tj2024b_app/example/day05/detail.dart";
import "package:tj2024b_app/example/day05/home.dart";
import "package:tj2024b_app/example/day05/replyWrite.dart";
import "package:tj2024b_app/example/day05/update.dart";
import "package:tj2024b_app/example/day05/write.dart";

void main() {
  runApp(EntryPoint());
}

class EntryPoint extends StatelessWidget {

  dynamic route = {
    "/" : (BuildContext context) => Home(),
    "/write" : (BuildContext context) => Write(),
    "/detail" : (BuildContext context) => Detail(),
    "/update" : (BuildContext context) => Update(),
    "/replyWrite" : (BuildContext context) => ReplyWrite(),
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
