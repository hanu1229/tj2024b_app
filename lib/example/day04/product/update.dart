// update.dart : 개별 비품 수정 화면

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:tj2024b_app/example/day04/product/serverpath.dart";

class Update extends StatefulWidget {

  @override
  State<Update> createState() => _UpdateState();

}

class _UpdateState extends State<Update> {

  Dio dio = Dio();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  Map<String, dynamic> product = {};

  /** 서버에서 상세정보 가져오기 */
  Future<void> productFindById(int id) async {
    try {
      String path = serverPath + "/view?id=$id";
      final response = await dio.get(path);
      final data = response.data;
      if(data != null) {
        product = data;
       setState(() {
         nameController.text = data["name"];
         descriptionController.text = data["description"];
         quantityController.text = data["quantity"].toString();
       });
      }
    } catch(e) {
      print(e);
    }
  }

  /** 서버에 수정된 값 저장하기 */
  Future<void> productUpdate(BuildContext context, int id) async {
    try {
      dynamic sendData = {
        "id" : id,
        "name" : nameController.text,
        "description" : descriptionController.text,
        "quantity" : quantityController.text
      };
      final response = await dio.put(serverPath, data : sendData);
      final data = response.data;
      if(data != null) {
        Navigator.pop(context, true);
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int id = ModalRoute.of(context)!.settings.arguments as int;
    productFindById(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title : Text("비품 수정"),
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
            ElevatedButton(onPressed : () { productUpdate(context, product["id"]); }, child : Text("수정")),
          ],
        ),
      ),
    );
  }

}
