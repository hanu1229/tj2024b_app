// signup.dart : 회원가입 페이지

import "package:dio/dio.dart";
import "package:flutter/material.dart";

class Signup extends StatefulWidget {

  @override
  State<Signup> createState() => _SignupState();

}

class _SignupState extends State<Signup> {
  
  Dio dio = Dio();

  // 입력 컨트롤러 | 입력받은 값을 제어 가능
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  // 비밀번호 ● 여부
  bool _obscure = true;

  /**
      등록 버튼 클릭 시
      <br/>
      서버에 값 전달
   */
  Future<void> onSignup(BuildContext context) async {
    final sendData = {
      "email" : emailController.text,
      "password" : passwordController.text,
      "name" : nameController.text
    };
    try {
      final response = await dio.post("http://localhost:8080/member", data : sendData);
      final data = response.data;
      if(data) {
        showDialog(
            context: context,
            barrierDismissible : false,
            builder: (BuildContext context) {
              return AlertDialog(
                content : Text("회원가입 성공!", style : TextStyle(fontSize : 24)),
                actions : [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/", arguments : "회원가입");
                    },
                    child: Text("확인"),
                  ),
                ],
              );
            }
        );
      } else {
        showDialog(
            context: context,
            barrierDismissible : false,
            builder: (BuildContext context) {
              return AlertDialog(
                content : Text("회원가입 오류!", style : TextStyle(fontSize : 24)),
                actions : [
                  ElevatedButton(
                    onPressed: () { Navigator.pop(context); },
                    child: Text("확인"),
                  ),
                ],
              );
            }
        );
      }
    } catch(e) {
      print(e);
    }
    print(sendData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child : Padding(
          padding : EdgeInsets.all(100),
          child : Column(
            mainAxisAlignment : MainAxisAlignment.center,
            crossAxisAlignment : CrossAxisAlignment.end,
            children: [
              TextField(
                controller : emailController,
                decoration : InputDecoration(
                  labelText : "이메일(id)",
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1),),
                  border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1),),
                ),
              ),
              SizedBox(height : 20),
              TextField(
                controller : passwordController,
                obscureText: _obscure,
                decoration : InputDecoration(
                  labelText : "패스워드",
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1),),
                  border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1),),
                  suffix : IconButton(
                    onPressed : () { setState(() { _obscure = !_obscure; }); },
                    icon : Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                    iconSize : 16,
                    constraints : BoxConstraints(),
                  ),

                ),
              ),
              SizedBox(height : 20),
              TextField(
                controller : nameController,
                decoration : InputDecoration(
                  labelText : "닉네임",
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1),),
                  border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1),),
                ),
              ),
              SizedBox(height : 20),
              ElevatedButton(
                onPressed : () { onSignup(context); },
                child : Text("회원가입"),
              ),
              SizedBox(height : 20),
              Center(
                child : TextButton(
                  onPressed : () {},
                  child : Column(
                    children : [
                      Text("이미 가입한 사용자라면"),
                      Text("로그인 하기"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}