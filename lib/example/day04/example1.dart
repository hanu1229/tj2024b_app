// 위젯 : 화면을 그려내는 최소 단위
// 위젯명(속성명 : 위젯명, 속성명 : 위젯명);
// VS 클래스명(매개변수, 매개변수, 매개변수);

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

// 플러터 시작 | 시작점에서 runApp()에 최초로 실행할 위젝의 객체 대입
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner : false,
    // 최초로 실행 시 열리는 경로
    initialRoute : "/",
    // routes : { "경로 정의" : (context) => 위젯명(), "경로 정의" : (context) => 위젯명(), ... }
    routes : {
      "/" : (context) => Home(),
      "/page1" : (context) => Page1(),
    }
  ));
}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(title : Text("메인페이지")),
      body : Center(
          child : Column(
            mainAxisAlignment : MainAxisAlignment.center,
            children : [
              Text("메인페이지 본문"),
              SizedBox(width : 10, height : 10),
              ElevatedButton(
                  onPressed : () { Navigator.pushNamed(context, "/page1"); },
                  child : Text("page1로 이동")
              ),
            ]
          )
      ),
      floatingActionButton : FloatingActionButton(onPressed: () {}, child : Icon(Icons.add)),
    );
  }

}

class Page1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(title : Text("Page1 Page")),
      body : Center(child : Text("Page1 본문")),
      floatingActionButton : FloatingActionButton(
          onPressed: () { Navigator.pop(context); },
          child : Icon(Icons.keyboard_arrow_left)
      ),
    );
  }
}
