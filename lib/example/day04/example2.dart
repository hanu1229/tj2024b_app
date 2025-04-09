// example2.dart : text 입력 폼

import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner : false,
    home : Home(),
  ));
}

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  // 입력 컨트롤러를 이용한 입력값들을 제어 | TextEditingController();
  // 생성된 입력컨트롤러 객체를 대입 | TextField(controller : 입력컨트롤러객체);
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  // 입력 후 값 추출 | 입력컨트롤러객체.text

  String str1 = "";
  String str2 = "";
  String str3 = "";


  void onEvent() {
    setState(() {
      print("controller1.text = ${controller1.text}");
      print("controller2.text = ${controller2.text}");
      print("controller3.text = ${controller3.text}");
      str1 = controller1.text;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(title : Text("입력 화면")),
      body : Center(
        child : Column(
          mainAxisAlignment : MainAxisAlignment.center,
          children: [
            Text(str1),
            SizedBox(height : 30),
            Text("아래 내용들을 입력해주세요"),
            SizedBox(height : 30),
            TextField(controller : controller1),
            SizedBox(height : 30),
            // 텍스트 입력 위젯 | 최대 입력 글자수 제한
            TextField(maxLength : 30, controller : controller2),
            SizedBox(height : 30),
            // 텍스트 입력 위젯 | 입력에 따라 자동 확장
            TextField(maxLines : 5, controller : controller3),
            SizedBox(height : 30),
            ElevatedButton(onPressed: onEvent, child: Text("버튼"))
          ],
        ),
      ),
    );
  }

}