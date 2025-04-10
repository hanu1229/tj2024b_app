// detail.dart : 비품 개별 조회 화면

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:tj2024b_app/example/day04/product/serverpath.dart";

class Detail extends StatefulWidget {

  @override
  State<Detail> createState() => _DetailState();

}

class _DetailState extends State<Detail> {

  Dio dio = Dio();

  Map<String, dynamic> product = {};

  /** 서버에서 상세정보 가져오기 */
  Future<void> productFindById(int id) async {
    try {

      String path = serverPath + "/view?id=$id";
      final response = await dio.get(path);
      final data = response.data;
      print(data);
      if(data != null) {
        setState(() {
          product = data;
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
    productFindById(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : Text("비품 조회"),
      ),
      body : Center(
        child : Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.start,
          children : [
            Text("번호 : ${product["id"]}", style : TextStyle(fontSize : 24)),
            Text("이름 : ${product["name"]}", style : TextStyle(fontSize : 20)),
            Text("설명 : ${product["description"]}", style : TextStyle(fontSize : 16)),
            Text("수량 : ${product["quantity"]}", style : TextStyle(fontSize : 16)),
            Text("등록일 : ${product["createdDate"]}", style : TextStyle(fontSize : 20)),
          ],
        ),
      ),
    );
  }

}