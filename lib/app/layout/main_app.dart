// main_app.dart :

import "package:flutter/material.dart";
import "package:tj2024b_app/app/member/signup.dart";

class MainApp extends StatefulWidget {

  @override
  State<MainApp> createState() => _MainAppState();

}

class _MainAppState extends State<MainApp> {

  // 페이지 위젯 리스트 : 여러개의 위젯들을 갖는 리스트
  // Widget : 여러 위젯들을 상속하는 상위 위젯(클래스)
  List<Widget> pages = [
    Text("홈페이지"),
    Text("게시물1 페이지"),
    Text("게시물2 페이지"),
    Signup(),
  ];
  // 페이지 상단 제목 리스트
  List<String> pageTitle = ["홈", "게시물1", "게시물2", "회원가입"];
  // 상태 변수 | 현재 클릭된 페이지를 확인하는 변수
  int selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final str = ModalRoute.of(context)!.settings.arguments;
    if(str != null && str == "회원가입") {
      setState(() { selectedIndex = 0; });
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : Row(
          children : [
            // 로컬이미지(플러터) VS 네트워크이미지(Spring서버)
            Image(
              image : AssetImage("assets/images/logo.png"),
              width : 50,
              height : 50,

            ),
            SizedBox(width : 20),
            Text(pageTitle[selectedIndex]),
          ],
        ),
      ),
      body : pages[selectedIndex],
      bottomNavigationBar : BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        // 현재 선택된 버튼 번호
        currentIndex : selectedIndex,
        // 여러개의 버튼 위젯들
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label : "게시물1"),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label : "게시물2"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label : "회원가입"),
        ],
        selectedItemColor : Colors.deepPurpleAccent,
        onTap : (checkIndex) => setState(() { selectedIndex = checkIndex; }),
      ),
    );
  }

}