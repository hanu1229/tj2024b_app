// home.dart : 메인 화면 | 책 추천 목록 조회

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:tj2024b_app/example/day05/serverpath.dart";

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  Dio dio = Dio();

  List<dynamic> bookList = [];

  bool passwordCheck = true;

  /** 서버에서 책 추천 목록 가져오기 */
  Future<void> bookFindAll() async {
    try {
      final response = await dio.get("$serverPath/book");
      final data = response.data;
      print(data);
      if(data != null) {
        setState(() {
          bookList = data;
        });
      }
    } catch(e) {
      print(e);
    }
  }

  /** 서버에게 데이터 삭제하라고 시키기 */
  Future<void> bookDelete(BuildContext context, int id) async {
    final password = await showPasswordDialog(context);

    if(password == null) { return; }

    try {
      final sendData = {"id" : id, "password" :password};
      final response = await dio.delete("$serverPath/book", data : sendData);
      final data = response.data;
      if(data) {
        setState(() {
          bookFindAll();
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("삭제 성공")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("비밀번호가 틀렸습니다.")));
      }
    } catch(e) {
      print(e);
    }
  }

  /** 비밀번호창 */
  Future<String?> showPasswordDialog(BuildContext context) async {
    final TextEditingController passwordController = TextEditingController();

    return showDialog<String>(
        context: context,
        builder: (context) {
          bool _obscure = true;
          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text("비밀번호 확인"),
                  content: TextField(
                    controller: passwordController,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      labelText: "비밀번호",
                      enabledBorder: OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                      border: OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                      suffixIcon : IconButton(
                        onPressed : () { setState(() { _obscure = !_obscure; }); },
                        icon : Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, passwordController.text); // 비밀번호 반환
                      },
                      child: Text("확인"),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context), // 취소
                      child: Text("취소"),
                    ),
                  ],
                );
              });
        }
    );
  }

  @override
  void initState() {
    super.initState();
    bookFindAll();
  }

  @override
  Widget build(BuildContext context) {

    int count = 0;

    return Scaffold(
      appBar : AppBar(title : Text("메인 페이지")),
      body : Center(
        child : ListView(
          children : bookList.map((book) {
            setState(() { count++; });
            return Column(
              children : [
                Card(
                  child : ListTile(
                    title : Text("$count : ${book["title"]}"),
                    trailing : Row(
                      mainAxisSize : MainAxisSize.min,
                      children : [
                        IconButton(
                          onPressed : () {
                            Navigator.pushNamed(context, "/detail", arguments : book["id"]);
                          },
                          icon : Icon(Icons.info),
                        ),
                        IconButton(
                          onPressed : () async {
                            final bool result = await Navigator.pushNamed(context, "/update", arguments : book["id"]) as bool;
                            if(result) {
                              bookFindAll();
                            }
                          },
                          icon : Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed : () { bookDelete(context, book["id"]); },
                          icon : Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height : 10),
              ],
            );
          }).toList(),
        ),
      ),
      floatingActionButton : FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/write");
          },
          child : Icon(Icons.add),
      ),
    );
  }

}