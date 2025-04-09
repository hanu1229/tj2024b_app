// home.dart : 메인 화면

import "package:dio/dio.dart";
import "package:flutter/material.dart";

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Dio dio = new Dio();
  List<dynamic> todoList = [];

  /** 서버에서 할 일 데이터 가져오기 */
  Future<void> todoFindAll() async {
    try {
      final response = await dio.get("http://192.168.40.38:8080/day04/todos");
      final data = response.data;
      print(data);
      setState(() {
        todoList = data;
      });
    } catch (e) {
      print(e);
    }
  }

  // 화면이 최초로 열렸을 때 딱 1번 실행
  void initState() {
    super.initState();
    todoFindAll();
  }

  /** 삭제 함수 */
  Future<void> todoDelete(int id) async {
    try {
      final response = await dio.delete("http://192.168.40.38:8080/day04/todos?id=$id");
      final data = response.data;
      if(data) {
        todoFindAll();
      } else {
        print("삭제 실패");
      }
    } catch(e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // 뒤로가기 아이콘 비활성화
          automaticallyImplyLeading : false,
          title: Text("메인페이지 : todo")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 자바로부터 가져온 할일 목록을 mpa함수를 이용하여 반복해서 Card형식의 위젯(ListTile) 만들기
            Expanded(
              child: ListView(
                children: todoList.map<Widget>((todo) {
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text("${todo["id"]}. ${todo["title"]}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("내용 : ${todo["content"]}"),
                              Text("상태 : ${todo["done"]}"),
                              Text("등록일 : ${todo["createAt"].split("T")[0]}"),
                            ],
                          ),
                          trailing : IconButton(
                              onPressed : () { todoDelete(todo["id"]); },
                              icon : Icon(Icons.delete)
                          ),
                        ),
                      ),
                      SizedBox(height : 10)
                    ],
                  );
                }).toList(),
              ),
            ),
            SizedBox(height : 80)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/write");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
