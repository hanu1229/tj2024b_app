// main_app.dart :

import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:tj2024b_app/app/member/info.dart";
import "package:tj2024b_app/app/member/login.dart";
import "package:tj2024b_app/app/member/signup.dart";
import "package:tj2024b_app/app/product/product_list.dart";

class MainApp extends StatefulWidget {

  @override
  State<MainApp> createState() => _MainAppState();

}

class _MainAppState extends State<MainApp> {

  // 로그인, 내정보 변경 변수 | false : Login(), true : Info()
  bool _checkLogin = false;
  // 페이지 위젯 리스트 : 여러개의 위젯들을 갖는 리스트
  // Widget : 여러 위젯들을 상속하는 상위 위젯(클래스)
  List<Widget> pages = [
    Text("홈페이지"),
    ProductList(),
    Text("게시물2 페이지"),
    // Signup(),
    // Login(),
  ];
  // 페이지 상단 제목 리스트
  List<String> pageTitle = ["홈", "제품목록", "게시물2", "회원가입", "로그인", "내정보"];
  // 상태 변수 | 현재 클릭된 페이지를 확인하는 변수
  int selectedIndex = 0;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final str = ModalRoute.of(context)!.settings.arguments;
    if(str != null && str == "회원가입") {
      print(1);
      setState(() { selectedIndex = 4; });
    }
    else if(str != null && str == "로그인 시도") {
      print(2);
      setState(() { selectedIndex = 4; });
    }
    else if(str != null && str == "로그인") {
      print(3);
      setState(() { selectedIndex = 0; _checkLogin = true; });
    }
    else if(str != null && str == "로그아웃") {
      print(4);
      setState(() { selectedIndex = 0; _checkLogin = false; });
    }
    pages = [
      Text("홈페이지"),
      ProductList(),
      Text("게시물2 페이지"),
      Signup(),
      _checkLogin ? Info() : Login()
    ];
    pageTitle = ["홈", "제품목록", "게시물2", "회원가입", _checkLogin ? "내정보" : "로그인"];

  }

  /// 로그인 상태 확인
  Future<void> checkCheck() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if(token != null) {
        print("token true");
        _checkLogin = true;
      } else {
        print("token false");
        _checkLogin = false;
      }
      pages = [
        Text("홈페이지"),
        ProductList(),
        Text("게시물2 페이지"),
        Signup(),
        _checkLogin ? Info() : Login()
      ];
    } catch(e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    checkCheck();
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
          BottomNavigationBarItem(icon : Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon : Icon(Icons.forum), label : "제품목록"),
          BottomNavigationBarItem(icon : Icon(Icons.forum), label : "게시물2"),
          BottomNavigationBarItem(icon : Icon(Icons.person_add_alt_1), label : "회원가입"),
          // BottomNavigationBarItem(icon : Icon(Icons.login), label : "로그인"),
          // BottomNavigationBarItem(icon : Icon(Icons.person), label : "내정보"),
          BottomNavigationBarItem(icon : Icon(_checkLogin ? Icons.person : Icons.login), label : _checkLogin ? "내정보" : "로그인"),
        ],
        selectedItemColor : Colors.deepPurpleAccent,
        onTap : (checkIndex) => setState(() { selectedIndex = checkIndex; }),
      ),
    );
  }

}