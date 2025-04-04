import 'package:flutter/material.dart';

// 프로그램 진입점
void main() {
  // 메뉴 상단에서 'select device'에 'web' 선택 후 실행
  runApp(new MyApp2());
}

// (1) 간단한 화면 만들기
// StatelessWidget : 상태가 없는 인터페이스
// build함수를 오버라이딩 해야함
class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home : new Scaffold(
        body: Text(
          "안녕하세요 플러터",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 간단한 레이아웃 만들기
class MyApp2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : Scaffold(
        appBar : AppBar(
          title : Text("여기는 상단 메뉴"),
        ),
        body : Center(
          child : Text("여기는 본문"),
        ),
        bottomNavigationBar : BottomAppBar(
          child : Text("여기는 하단 메뉴"),
        ),
      ),
    );
  }
}
