// detail.dart : 상세 화면 파일

import "package:dio/dio.dart";
import "package:flutter/material.dart";

class Detail extends StatefulWidget {

  @override
  State<Detail> createState() => _DetailState();

}

class _DetailState extends State<Detail> {

  Dio dio = new Dio();
  // 상세정보를 저장할 변수
  Map<String, dynamic> todo = {};

  // id값으로 상세정보 가져오기
  Future<void> todoFindById(int id) async {
    try {
      final response = await dio.get("https://wise-caprice-hanu1229-4a4e573f.koyeb.app/day04/todos/view?id=$id");
      final data = response.data;
      setState(() {
        todo = data;
        print(todo);
      });
    } catch(e) {
      print(e);
    }
  }

  /** 해당 위젯이 최초로 딱 1번 실행하는 함수 (위젯 생명주기) <br/> context 위젯 트리를 제공 X *////
  void initState() {}

  /**
    이전 위젯이 변경되었을 떄 실행되는 함수(위젯 생명주기) <br/>
    context 위젯 트리 제공 O
   *////
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 이전 위젯으로부터 매개변수로 받은 id를 가져오기
    int id = ModalRoute.of(context)!.settings.arguments as int;
    print("id = $id");
    // 가져온 id를 서버에 보내 정보를 요청하기
    todoFindById(id);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar : AppBar(title : Text("상세보기")),
      body : Center(
        child : Column(
          children : [
            Text("제목 : ${todo["title"]}", style : TextStyle(fontSize : 24)),
            SizedBox(height : 20),
            Text("내용 \n${todo["content"]}", style : TextStyle(fontSize : 20)),
            SizedBox(height : 20),
            Text("완료 여부 : ${todo["done"] == "true" ? "완료" : "미완료"}", style : TextStyle(fontSize : 16)),
            SizedBox(height : 20),
            Text("등록일 : ${todo["title"]}", style : TextStyle(fontSize : 16)),
            SizedBox(height : 20),
          ],
        ),
      )
    );
  }

}