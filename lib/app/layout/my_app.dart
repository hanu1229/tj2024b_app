// my_app.dart : 레이아웃을 구성하는 파일

import 'package:flutter/material.dart';
import 'package:tj2024b_app/app/layout/main_app.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : "더조은본문",
      debugShowCheckedModeBanner : false,
      theme : ThemeData(
        scaffoldBackgroundColor : Colors.white,
        appBarTheme : AppBarTheme(
          color : Colors.deepPurpleAccent,
          titleTextStyle : TextStyle(
            color : Colors.white,
            fontSize : 21,
          ),
        ),
      ),
      home : MainApp(),
    );
  }

}