// detail.dart : 책 추천 상세보기 화면

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:tj2024b_app/example/day05/serverpath.dart";

class Detail extends StatefulWidget {

  @override
  State<Detail> createState() => _DetailState();

}

class _DetailState extends State<Detail> {

  Dio dio = Dio();

  TextEditingController titleController = TextEditingController();
  TextEditingController writerController = TextEditingController();
  TextEditingController introController = TextEditingController();

  dynamic bookInfo = {};

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
      appBar : AppBar(title : Text("상세보기")),
      body : Center(
        child : Column(
          mainAxisAlignment : MainAxisAlignment.start,
          crossAxisAlignment : CrossAxisAlignment.end,
          children : [
            SizedBox(
              width : 400,
              child : Card(
                elevation : 50,
                child : Column(
                  children : [
                    SizedBox(height : 50),
                    SizedBox(
                      width : 300,
                      child : TextField(
                        controller : titleController,
                        readOnly : true,
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
                        readOnly : true,
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
                        readOnly : true,
                        decoration : InputDecoration(
                          labelText : "간단한 소개",
                          enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                          border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                        ),
                      ),
                    ),
                    SizedBox(height : 50),
                  ],
                ),
              ),
            ),
            SizedBox(height : 30),
            ElevatedButton(
              onPressed : () {
                Navigator.pushNamed(context, "/replyWrite", arguments : bookInfo["id"]);
              },
              child : Text("댓글 작성")
            ),
            SizedBox(height : 30),
            SizedBox(
              width : 400,
              child : Card(
                child : Text("테스트"),
              ),
            )
          ],
        ),
      ),
    );
  }

}
