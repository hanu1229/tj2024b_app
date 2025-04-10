// main.dart : 웹 실행의 최초 파일

/*
  안드로이드 : apk 확장자 | 스토어 등록
  IOS : ipa 확장자 | 보안상 스토어 등록
  [ apk | ipa 파일 만들기 ]
    방법1
      01. 터미널 창 열기 | 현재 프로젝트명 오른쪽 클릭 -> open in -> terminal
      02. flutter build apk --release --target=lib/example/day04/todo/main.dart --target-platform=android-arm64 작성
          --> --target을 생략 시 자동으로 lib에서 제일 가까운 main.dart가 빌드됨
    방법2
      01. 상단메뉴 -> [build] -> [flutter] -> [apk] 선택

   안드로이드 폰에서 apk 실행 시 https가 적용이 안되는 경우가 있음
   --> C:\Users\tj-bu-702-12\StudioProjects\tj2024b_app\android\app\src\main의 AndroidManifest.xml 들어가기
   --> <manifest> </manifest> 사이에
   --> <uses-permission android:name="android.permission.INTERNET" /> 작성

*/

import "package:flutter/material.dart";
import "package:tj2024b_app/example/day04/todo/home.dart";
import "package:tj2024b_app/example/day04/todo/update.dart";
import "package:tj2024b_app/example/day04/todo/write.dart";
import "package:tj2024b_app/example/day04/todo/detail.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  dynamic route = {
    "/" : (BuildContext context) => Home(),
    "/write" : (BuildContext context) => Write(),
    "/update" : (BuildContext context) => Update(),
    "/detail" : (BuildContext context) => Detail(),
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