// replyWrite.dart : 댓글 작성 화면

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:tj2024b_app/example/day05/serverpath.dart";

class ReplyWrite extends StatefulWidget {

  @override
  State<ReplyWrite> createState() => _ReplyWriteState();

}

class _ReplyWriteState extends State<ReplyWrite> {

  Dio dio = Dio();

  TextEditingController commentController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  dynamic reply = {"comment" : "", "password" : "", "bookId" : ""};

  /** 서버에 댓글 저장하기 */
  Future<void> replySave(BuildContext context) async {
    try {
      final sendData = {
        "comment" : commentController.text,
        "password" : passwordController.text,
        "bookId" : int.parse(reply["bookId"])
      };
      final response = await dio.post("$serverPath/reply", data : sendData);
      final data = response.data;
      if(data != null) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("작성 실패!")));
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int bookId = ModalRoute.of(context)!.settings.arguments as int;
    setState(() {
      reply["bookId"] = bookId.toString();
      print("reply  = $reply");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(title : Text("댓글 작성")),
      body : Center(
        child : Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.end,
          children : [
            SizedBox(
              width : 300,
              child : TextField(
                controller : commentController,
                maxLength : 100,
                maxLines : 5,
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
              child : TextField(
                controller : passwordController,
                maxLength : 12,
                decoration : InputDecoration(
                  labelText : "비밀번호",
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                  border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                ),
              ),
            ),
            SizedBox(height : 20),
            ElevatedButton(
              onPressed : () {
                replySave(context);
              },
              child : Text("작성하기"),
            ),
          ],
        ),
      ),
    );
  }

}
