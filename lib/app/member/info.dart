// info.dart : 내정보 페이지

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tj2024b_app/app/layout/main_app.dart';

class Info extends StatefulWidget {

  @override
  State<Info> createState() => _InfoState();

}

class _InfoState extends State<Info> {

  Dio dio = Dio();

  dynamic info = {};
  // 상태변수
  int no = 0;
  String email = "";
  String name = "";
  // 타입?은 null을 포함 수 있다는 뜻
  bool? _isLogin;

  /// 로그인 상태를 확인하는 함수
  Future<void> loginCheck() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if(token != null && token.isNotEmpty) {
      // 전역변수에 로그인(토큰)이 존재하면
      setState(() {
        _isLogin = true;
        print("로그인 중");
      });
    } else {
      setState(() {
        _isLogin = false;
        print("비로그인 중");
      });
    }
  }

  /// 내정보 가져오기
  Future<void> myInfo() async {
    await loginCheck();
    if(_isLogin == true) {
      try {
        SharedPreferences pref = await SharedPreferences.getInstance();
        final token = pref.getString("token");
        // 방법1 : dio.options.headers["속성명"] = 값;
        // dio.options.headers["Authorization"] = token;
        // 방법2 : dio.get(options : Options(headers : {"Authorization" : token}));
        final response = await dio.get(
          "http://localhost:8080/member/info",
          options : Options(
              headers : {"Authorization" : token}
          ),
        );
        final data = response.data;
        print(data);
        if(data != null) {
          setState(() {
            no = data["no"];
            email = data["email"];
            name = data["name"];
          });
        }
      } catch(e) {
        print(e);
      }
    }
  }

  /// 로그아웃 요청
  Future<void> logout(BuildContext context) async {
    await loginCheck();
    if(_isLogin == true) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");
        final response = await dio.get(
          "http://localhost:8080/member/logout",
          options : Options(
            headers : {"Authorization" : token},
          ),
        );
        await prefs.remove("token");
        print("로그아웃");
        // Navigator.pushReplacementNamed(context, "/", arguments : "로그아웃");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder : (context) => MainApp(),
          ),
        );
      } catch(e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    myInfo();
  }

  @override
  Widget build(BuildContext context) {
    
    // 만약에 로그인 상태가 확인되기 전에 대기 화면을 표현
    if(_isLogin == null) {
      return Scaffold(
        body : Center(
          // 로딩을 제공하는 위젯
          child : CircularProgressIndicator(),
        ),
      );
    }
    
    return Scaffold(
      body : Container(
        margin : EdgeInsets.all(30),
        padding : EdgeInsets.all(30),
        child : Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.start,
          children : [
            Divider(height : 10, color : Colors.black),
            SizedBox(height : 20),
            Text("회원번호 : $no"),
            SizedBox(height : 20),
            Text("이름 : $email"),
            SizedBox(height : 20),
            Text("이메일 : $name"),
            SizedBox(height : 20),
            Divider(height : 10, color : Colors.black),
            SizedBox(height : 20),
            Align(
              alignment : Alignment.centerRight,
              child : ElevatedButton(
                onPressed: () { logout(context); },
                child: Text("로그아웃"),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
