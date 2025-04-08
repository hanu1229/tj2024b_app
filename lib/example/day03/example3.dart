import "package:flutter/material.dart";
import "package:dio/dio.dart";

// 상태 위젯 + Rest(dio)통신

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  Dio dio = new Dio();
  // 상태 변수
  String responseText = "서버 응답 결과가 표시 되는 곳";
  // todoGet 응답 결과 저장 변수
  dynamic todoList = [{"title" : "샘플"}];

  void initState() {
    super.initState();
    todoGet();
  }

  /** 서버에 값 보내기 */
  Future<void> todoSend() async {
    try {
      dynamic sendData = {"title" : "운동하기", "content" : "매일 10분 달리기", "done" : "false"};
      dynamic response = await dio.post("http://192.168.40.38:8080/day04/todos", data : sendData);
      dynamic data = response.data;
      // 응답 결과를 상태에 저장 | setState()함수를 이용한 상태 렌더링
      setState(() {
        print(data);
        responseText = "응답 결과\n $data";
      });
    } catch(e) {
      setState(() {
        responseText = "에러 발생\n $e";
      });
      print(e);
    }
  }

  /** 서버에서 값 가져오기 */
  Future<void> todoGet() async {
    try {
      final response = await dio.get("http://192.168.40.38:8080/day04/todos");
      final data = response.data;
      print(data);
      setState(() {
        todoList = data;
      });
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      home : Scaffold(
        body : Center(
          child : Column(
            mainAxisAlignment : MainAxisAlignment.center,
            children : [
              Text(responseText),
              ElevatedButton(onPressed: todoSend, child: Text("자바 통신1")),
              SizedBox(width : 10, height : 10),
              ElevatedButton(onPressed: todoGet, child: Text("자바 통신2")),
              // Expanded : Column에서 남은 공간을 모두 채워주는 위젯
              Expanded(
                  // ListView : 스크롤이 가능한 목록(리스트)위젯 | 주의할 점 : 부모 요소의 100%높이를 사용
                  child: ListView(
                    children : todoList.map<Widget>((todo) {
                      String? crateAt = todo["createAt"]?.split("T")[0] ?? "";
                      return ListTile(
                          title : Text(todo["title"]),
                          subtitle : Text("${todo['content']}\n생성일 : $crateAt")
                      );
                    }).toList()
                    // children : [
                    //   for(int index = 0; index < todoList.length; index++)
                    //     ListTile(title : Text(todoList[index]["title"]))
                    // ]
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

}



