// 상태가 없는 위젯 : statelessWidget
// 상태가 있는 위젯 : statefulWidget
/*
  상태(state/데이터변화)가 없는 위젯 : StatelessWidget (정적 UI)
  1. 한번 출력된 화면은 불변(고정)이다. 재렌더링이 안된다.
  2. 관리 클래스가 별도로 없다.
    --> 한번 그려낸 화면은 고정
  3. 사용법
      class 새로운위젯명 extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
          return 위젯명();
        }
      }

  상태(state/데이터변화)가 있는 위젯 : StatefulWidget (동적 UI)
  1. 한번 출력된 화면은 불변(고정)이다 | setState() 함수를 이용하여 재렌더링이 된다.
  2. 반드시 상태를 관리하는 별도의 클래스가 필요
      --> 합번 그려낸 화면을 상태 변화에 따라 다시 그려낼 수 있다.
  3. 사용법
      class 상태관리위젯명 extends StatefulWidget {
        @override
        State<상태관리위젯명> createState() => _새로운함수명();
      }
      class _새로운함수명 extends State<상태관리위젯명> {
        @override
        Widget build(BuildContext context) {
          return 위젯명();
        }
      }
  4. 주요 함수
      - initState() : 위젯이 처음에 생성될 때 실행 되는 초기화 함수          [ 위젯 탄생 ]
      - setState(() {}) : 상태를 변경하고 화면을 다시 렌더링(build)하는 함수 [ 위젯 업데이트 ]
      - dispose() : 위젯이 제거될 때 실행 되는 함수                       [ 위젯 사망 ]

*/

import "package:flutter/material.dart";

void main() {
  runApp(MyApp1());
}

/// 상태를 관리하는 클래스(위젯) 선언
class MyApp1 extends StatefulWidget {
  const MyApp1({super.key});

  @override
  State<MyApp1> createState() => _MyApp1State();

}

/// 상태를 사용하는 클래스(위젯) 선언
class _MyApp1State extends State<MyApp1> {

  int count = 0;

  void increment() {
    setState(() { count++; });
  }

  // 상태 위젯이 최초로 실행될 때 딱 1번 실행 되는 함수
  @override
  void initState() {
    super.initState();
    print("상태 위젯이 최초로 한번 실행하는 함수입니다.");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      home : Scaffold(
        appBar : AppBar(title : Text("상단 메뉴")),
        body : Center(
          child : Column(
            mainAxisAlignment : MainAxisAlignment.center,
            children : [
              Text("카운트 : $count"),
              TextButton(onPressed : increment, child: Text("버튼 클릭")),
            ],
          )
        )
      ),
    );
  }
}
