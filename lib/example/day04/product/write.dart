// write.dart : 비품 등록 화면

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:tj2024b_app/example/day04/product/serverpath.dart";

class Write extends StatefulWidget {
  
  @override
  State<Write> createState() => _WriteState();
  
}

class _WriteState extends State<Write> {

  Dio dio = Dio();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  /** 서버에 비품 등록하기 *////
  Future<void> productSave(BuildContext context) async {
    try {
      dynamic sendData = {
        "name" : nameController.text,
        "description" : descriptionController.text,
        "quantity" : int.parse(quantityController.text)
      };
      final response = await dio.post(serverPath, data : sendData);
      final data = response.data;
      if(data) {
        Navigator.pushReplacementNamed(context, "/");
      }
    } catch(e) {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : Text("비품 등록"),
      ),
      body : Center(
        child : Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.end,
          children : [
            SizedBox(
              width : 300,
              child : TextField(
                controller : nameController,
                maxLength : 30,
                decoration : InputDecoration(
                  labelText : "비품 이름",
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                  border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                ),
              ),
            ),
            SizedBox(
              width : 300,
              child : TextField(
                controller : descriptionController,
                maxLength : 300,
                maxLines : 5,
                decoration : InputDecoration(
                  labelText : "비품 내용",
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                  border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                ),
              ),
            ),
            SizedBox(
              width : 300,
              child : TextField(
                controller : quantityController,
                maxLength : 5,
                decoration : InputDecoration(
                  labelText : "비품 수량",
                  enabledBorder : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                  border : OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                ),
              ),
            ),
            SizedBox(height : 10),
            ElevatedButton(onPressed : () { productSave(context); }, child : Text("등록")),
          ],
        ),
      ),
    );
  }
  
}