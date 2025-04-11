// write.dart : 책 추천 등록 화면

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:tj2024b_app/example/day05/serverpath.dart";

class Write extends StatefulWidget {

  @override
  State<Write> createState() => _WriteState();

}

class _WriteState extends State<Write> {

  Dio dio = Dio();

  TextEditingController titleController = TextEditingController();
  TextEditingController writerController = TextEditingController();
  TextEditingController introController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscure = true;

  /** 서버에 데이터 저장하기 */
  Future<void> bookSave(BuildContext context) async {
    try {
      final sendData = {
        "title" : titleController.text,
        "writer" : writerController.text,
        "intro" : introController.text,
        "password" : passwordController.text
      };
      final response = await dio.post("$serverPath/book", data : sendData);
      final data = response.data;
      if(data != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(title : Text("책 추천하기")),
      body : Center(
        child : Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.end,
          children : [
            SizedBox(
              width : 300,
              child : TextField(
                controller : titleController,
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
                controller : writerController,
                decoration : InputDecoration(
                  labelText : "저자",
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                  border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                ),
              ),
            ),
            SizedBox(height : 20),
            SizedBox(
              width : 300,
              child : TextField(
                controller : introController,
                maxLength : 300,
                maxLines : 5,
                decoration : InputDecoration(
                  labelText : "간단한 소개",
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                  border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                ),
              ),
            ),
            SizedBox(height : 20),
            SizedBox(
              width : 300,
              child : TextField(
                controller : passwordController,
                maxLength : 12,
                obscureText: _obscure,
                decoration : InputDecoration(
                  labelText : "비밀번호",
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                  border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                  suffixIcon : IconButton(
                    onPressed : () { setState(() { _obscure = !_obscure; }); },
                    icon : Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
              ),
            ),
            SizedBox(height : 20),
            ElevatedButton(
                onPressed : () {
                  bookSave(context);
                },
                child : Text("추천하기"),
            ),
          ],
        ),
      ),
    );
  }

}