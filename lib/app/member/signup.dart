// signup.dart : 회원가입 페이지

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:tj2024b_app/app/member/login.dart";
import "package:tj2024b_app/app/server_url.dart";

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
  Future<bool?> onSignup(BuildContext context) async {
    dynamic result;
    final sendData = {
      "email" : emailController.text,
      "password" : passwordController.text,
      "name" : nameController.text
    };
    // Rest API통신 간의 로딩 화면 표시 | showDialog() : 팝업 창을 띄우기 위한 위젯
    showDialog(
      context: context,
      barrierDismissible : false,
      builder: (BuildContext context) => 
          Center(
            child : CircularProgressIndicator(),
          ),
    );
    try {
      final response = await dio.post("$serverUrl/member/signup", data : sendData);
      final data = response.data;
      Navigator.pop(context);
      Fluttertoast.showToast(
        // 출력할 내용
        msg: "회원가입을 성공했습니다.",
        // 메시지 유지시간
        toastLength : Toast.LENGTH_LONG,
        // 메시지 표시 위치 : 앱 적용
        gravity : ToastGravity.BOTTOM,
        // 자세한 유지시간
        timeInSecForIosWeb : 3,
        // 배경색
        backgroundColor : Colors.black,
        // 글자색
        textColor : Colors.white,
        // 글자크기
        fontSize : 16,
        webShowClose: true,
      );
      if(data) {
        result = await showDialog(
            context: context,
            barrierDismissible : false,
            builder: (BuildContext context) {
              return AlertDialog(
                content : Text("회원가입 성공!", style : TextStyle(fontSize : 24)),
                actions : [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      //Navigator.pushReplacementNamed(context, "/", arguments : "회원가입");
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder : (context) => Login(),
                      //   ),
                      // );
                    },
                    child: Text("확인"),
                  ),
                ],
              );
            }
        );
      } else {
        result = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("회원가입 오류!", style: TextStyle(fontSize: 24)),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
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
    return result;
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
                maxLength : 15,
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
                maxLength : 12,
                decoration : InputDecoration(
                  labelText : "닉네임",
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1),),
                  border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1),),
                ),
              ),
              SizedBox(height : 20),
              ElevatedButton(
                onPressed : () async {
                  bool? result = await onSignup(context);
                  if(result == true) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder : (context) => Login(),
                      ),
                    );
                  }
                },
                child : Text("회원가입"),
              ),
              SizedBox(height : 20),
              Center(
                child : TextButton(
                  onPressed : () {
                    //Navigator.pushReplacementNamed(context, "/", arguments : "로그인 시도");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder : (context) => Login()),
                    );
                  },
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