// update.dart : 수정 화면 페이지

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  const Update ({super.key});

  @override
  State<Update> createState() => _UpdateState();

}

class _UpdateState extends State<Update> {

  Dio dio = new Dio();
  // 가져온 정보를 저장하는 변수
  Map<String, dynamic> todo = {};
  // 입력된 값을 저장하는 변수
  TextEditingController titleController = new TextEditingController();
  TextEditingController contentController = new TextEditingController();
  bool done = false;


  /** 서버에서 정보 가져오기 *////
  Future<void> todoFindById(int id) async {
    try {
      final response = await dio.get("https://wise-caprice-hanu1229-4a4e573f.koyeb.app/day04/todos/view?id=$id");
      final data = response.data;
      print(data);
      setState(() {
        todo = data;
        titleController.text = data["title"];
        contentController.text = data["content"];
        done = data["done"];
      });
    } catch(e) {
      print(e);
    }
  }

  /** 서버에 수정된 데이터 보내기 */
  Future<void> todoUpdate(BuildContext context, int id) async {
    try {
      final sendData = {"id" : id, "title" : titleController.text , "content" : contentController.text , "done" : done};
      print(sendData);
      final response = await dio.put("https://wise-caprice-hanu1229-4a4e573f.koyeb.app/day04/todos", data : sendData);
      final data = response.data;
      if(data != null) {
        // Navigator.pushReplacementNamed(context, "/");
        Navigator.pop(context, true);
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    int id = ModalRoute.of(context)!.settings.arguments as int;
    print("id = $id");
    todoFindById(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : Text("수정화면"),
      ),
      body : Center(
        child : Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.end,
          children : [
            SizedBox(height : 10),
            SizedBox(
                width : 300,
                child : TextField(
                  controller : titleController,
                  maxLength : 30,
                  decoration : InputDecoration(
                    labelText : "제목",
                    enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                    border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                  ),
                ),
            ),
            SizedBox(height : 20),
            SizedBox(
              width : 300,
              child : TextField(
                controller : contentController,
                maxLines : 5,
                maxLength : 300,
                decoration : InputDecoration(
                  labelText : "내용",
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                  border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                ),
              ),
            ),
            SizedBox(height : 20),
            SizedBox(
              width : 300,
              child : Row(
                children : [
                  Text("완료 여부"),
                  Switch(
                      value : done,
                      onChanged : (value) { setState(() { done = value; }); }
                  ),
                ],
              ),
            ),
            SizedBox(height : 20),
            ElevatedButton(onPressed : () { todoUpdate(context, todo["id"]); }, child : Text("수정")),
          ],
        ),
      ),
    );
  }

}
