// login.dart : 로그인 페이지

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:tj2024b_app/app/server_url.dart";

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();

}

class _LoginState extends State<Login> {

  Dio dio = Dio();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscure = true;

  /// 서버에 로그인 데이터 보내기
  Future<void> onLogin(BuildContext context) async {
    dynamic data;
    try {
      final sendData = {
        "email" : emailController.text,
        "password" : passwordController.text
      };
      final response = await dio.post("$serverUrl/member/login", data : sendData);
      data = response.data;
      if(data == "로그인 실패") {
        print(data);
      } else {
        print("로그인 성공");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", data);
        print("data : ${prefs.getString("token")}");
        Navigator.pushReplacementNamed(context, "/", arguments : "로그인");
      }
    } catch(e) {
      print(e);
      print(data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("이메일과 비밀번호를 정확히 입력해주세요.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
        padding : EdgeInsets.all(30),
        margin : EdgeInsets.all(30),
        child : Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.end,
          children: [
            TextField(
              controller : emailController,
              decoration : InputDecoration(
                labelText : "이메일",
                disabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 2)),
                border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 2)),
              ),
            ),
            SizedBox(height : 20),
            TextField(
              controller : passwordController,
              obscureText : _obscure,
              decoration : InputDecoration(
                labelText : "비밀번호",
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                disabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 2)),
                border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 2)),
                suffix : IconButton(
                  onPressed : () { setState(() { _obscure = !_obscure; }); },
                  icon : _obscure ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                  iconSize : 16,
                  constraints : BoxConstraints(),
                ),
              ),
            ),
            SizedBox(height : 20),
            ElevatedButton(onPressed : () { onLogin(context); }, child : Text("로그인")),
          ],
        ),
      ),
    );
  }

}
