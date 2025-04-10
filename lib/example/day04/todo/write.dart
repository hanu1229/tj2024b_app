// write.dart : 등록 화면 파일

import "package:dio/dio.dart";
import "package:flutter/material.dart";

class Write extends StatefulWidget {

  @override
  State<Write> createState() => _WriteState();

}

class _WriteState extends State<Write> {

  // 서버 통신을 위한 객체
  Dio dio = Dio();

  // 입력된 텍스트값 컨트롤러
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  /** 데이터베이스에 등록 */
  Future<void> todoSave(BuildContext context) async {
    try {
      final sendData = {"title" : titleController.text, "content" : contentController.text, "done" : "false"};
      // final response = await dio.post("http://192.168.40.38:8080/day04/todos", data : sendData);
      final response = await dio.post("https://wise-caprice-hanu1229-4a4e573f.koyeb.app/day04/todos", data : sendData);
      final data = response.data;
      if(data != null) {
        // Navigator.pushNamed(context, "/");
        Navigator.pushReplacementNamed(context, "/");
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(title : Text("할일 등록")),
      body : Center(
        child : Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.end,
          children : [
            SizedBox(
              width : 300,
              child : TextField(
                controller : titleController,
                maxLength : 30, 
                decoration: InputDecoration(
                  labelText: "제목",
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                  border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 2)),
                ),
              )
            ),
            SizedBox(height : 30),
            SizedBox(
                width : 300,
                child : TextField(
                  controller : contentController,
                  maxLines : 5,
                  maxLength : 300,
                  decoration: InputDecoration(
                    labelText: "내용",
                    enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                    border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 2)),
                  ),
                )
            ),
            SizedBox(height : 30),
            ElevatedButton(onPressed : () { todoSave(context); }, child : Text("등록"))
          ],
        ),
      ),
    );
  }

}