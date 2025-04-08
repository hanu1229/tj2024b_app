// Flutter : Dart언어(google) 기반의 프레임워크
// Dart언어 클래스 : 첫글자 대문자로 시작
// Dart언어 인스턴스 생성 : 클래스명()
// 위젯 : 화면을 그려내는 최소의 단위, 클래스기반(첫글자를 대문자)

import "package:flutter/material.dart";

void main() {
  print("콘솔에 출력하기");
  runApp(MyApp2());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : Scaffold(
        appBar : AppBar(
          title : Center(child : Text("상단메뉴"))
        ),
        body : Center(
          child : Text("센터"),
        ),
        bottomNavigationBar : BottomAppBar(
          child : Text("하단메뉴"),
        ),
      ),
    );
  }
}

class MyApp2 extends StatelessWidget {

  // 값 변수
  int count = 0;
  // 증가 함수
  void increment() {
    count++;
    print(count);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      home : Scaffold(
        appBar : AppBar(
          title : Text("상단 텍스트"),
        ),
        body : Center(
          // Column : 세로 배치 위젯
          child : Column(
            mainAxisAlignment : MainAxisAlignment.center,
            children: [
              Text("본문 텍스트 $count"),
              TextButton(onPressed: increment, child: Text("버튼"))
            ],
          ),
        ),
      ),
    );
  }
}
