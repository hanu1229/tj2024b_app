// update.dart : 책 추천 수정 화면

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:tj2024b_app/example/day05/serverpath.dart";

class Update extends StatefulWidget {

  @override
  State<Update> createState() => _UpdateState();

}

class _UpdateState extends State<Update> {

  Dio dio = Dio();

  TextEditingController titleController = TextEditingController();
  TextEditingController writerController = TextEditingController();
  TextEditingController introController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  dynamic bookInfo = {};

  bool colorCheck = true;
  bool _obscure = true;

  /** 서버에서 상세정보 가져오기 */
  Future<void> bookFindById(int id) async {
    try {
      final response = await dio.get("$serverPath/book/detail?id=$id");
      final data = response.data;
      print(data);
      if(data != null) {
        setState(() {
          titleController.text = data["title"];
          writerController.text = data["writer"];
          introController.text = data["intro"];
          bookInfo = data;
        });
      }
    } catch(e) {
      print(e);
    }
  }

  /** 서버에 수정된 데이터 저장하기 */
  Future<void> bookUpdate(BuildContext context) async {
    if(passwordController.text != "") {
      try {
        final sendData = {
          "id" : bookInfo["id"],
          "title" : titleController.text,
          "writer" : writerController.text,
          "intro" : introController.text,
          "password" : passwordController.text
        };
        print("sendData = $sendData");
        final response = await dio.put("$serverPath/book", data : sendData);
        final data = response.data;
        print(data);
        if(data) {
          setState(() { colorCheck = true; });
          Navigator.pop(context, true);
        } else {
          setState(() { colorCheck = false; });
        }
      } catch(e) {
        print(e);
      }
    }

  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int id = ModalRoute.of(context)!.settings.arguments as int;
    print("id = $id");
    bookFindById(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(title : Text("수정하기")),
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
                maxLines : 5,
                controller : introController,
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
                maxLength : 12,
                obscureText : _obscure,
                controller : passwordController,
                decoration : InputDecoration(
                  labelText : colorCheck ? "비밀번호 확인" : "비밀번호 틀림",
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : colorCheck ? Colors.black : Colors.red, width : 1)),
                  border : OutlineInputBorder(borderSide : BorderSide(color : colorCheck ? Colors.black : Colors.red, width : 1)),
                  focusColor : colorCheck ? Colors.black : Colors.red,
                  suffix : IconButton(
                    onPressed : () { setState(() { _obscure = !_obscure; }); },
                    icon : Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
              ),
            ),
            SizedBox(height : 20),
            ElevatedButton(
              onPressed: () {
                bookUpdate(context);
              },
              child: Text("수정하기"),
            ),
          ],
        ),
      ),
    );
  }

}