import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tj2024b_app/app/server_url.dart';

class ProductRegister extends StatefulWidget {

  @override
  State<ProductRegister> createState() => _ProductRegisterState();

}

class _ProductRegisterState extends State<ProductRegister> {

  final TextEditingController pnameController = TextEditingController();
  final TextEditingController pcontentController = TextEditingController();
  final TextEditingController ppriceController = TextEditingController();
  int? cno = 1;
  Dio dio = Dio();
  final String baseUrl = serverUrl;
  List<dynamic> categoryList = [];

  /// 이미지 피커
  List<XFile> selectedImage = [];
  void onSelectImage() async {
    try {
      ImagePicker picker = ImagePicker();
      // 사용자가 선택한 이미지들을 XFile 파일로 반환
      List<XFile> pickerFiles = await picker.pickMultiImage();
      if(pickerFiles.isNotEmpty) { setState(() { selectedImage = pickerFiles; }); }
    } catch(e) {
      print(e);
    }
  }

  /// 카테고리 조회 요청 함수
  void onCategory() async {
    try {
      final response = await dio.get("$baseUrl/product/category");
      setState(() { categoryList = response.data; print(categoryList); });
    } catch(e) {
      print(e);
    }
  }

  /// 제품 등록 요청 함수 ( + FormData )
  void onRegister() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if(token == null) { print("로그인 후 가능합니다."); return; }
      FormData formData = FormData();
      // 필드명은 자바의 DTO 필드명과 동일함
      // formData.fields.add(MapEntry("필드명" : "값"));
      formData.fields.add(MapEntry("pname", pnameController.text));
      formData.fields.add(MapEntry("pcontent", pcontentController.text));
      formData.fields.add(MapEntry("pprice", ppriceController.text));
      formData.fields.add(MapEntry("cno", "$cno"));
      for(XFile image in selectedImage) {
        final file = await MultipartFile.fromFile(image.path, filename : image.name);
        formData.files.add(MapEntry("files", file));
      }
      Options options = Options(headers : {"Authorization" : token});
      final response = await dio.post("$baseUrl/product/register", data : formData, options : options);
      if(response.statusCode == 201 && response.data == true) {
        print("제품 등록 성공");
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    onCategory();
  }

  @override
  Widget build(BuildContext context) {

    /// 카테고리 드롭다운 위젯 함수
    Widget CategoryDropdown() {
      return DropdownButtonFormField(
        value : cno,
        hint : Text("카테고리 선택"),
        dropdownColor : Colors.white,
        decoration : InputDecoration(
          border : OutlineInputBorder(),
        ),
        items: categoryList.map((category) {
          return DropdownMenuItem<int>(
            value : category["cno"],
            child: Text("${category["cname"]}"),
          );
        }).toList(),
        onChanged: (value) { setState(() { cno = value; print("cno = $cno"); }); },
      );
    }

    /// 선택한 이미지 미리보기 함수
    Widget ImagePreview() {
      return Container(
        height : 100,
        child : ListView.builder(
          scrollDirection : Axis.horizontal,
          itemCount : selectedImage.length,
          itemBuilder : (context, index) {
            final XFile xFile = selectedImage[index];
            return Padding(
              padding : EdgeInsets.all(5),
              child : SizedBox(
                width : 100,
                height : 100,
                child : Image.file(File(xFile.path)),
              ),
            );
          }
        ),
      );
    }

    return Scaffold(
      body : Container(
        padding : EdgeInsets.all(16),
        child : Column(
          children : [
            CategoryDropdown(),
            SizedBox(height : 20),
            TextField(
              controller : pnameController,
              decoration : InputDecoration(
                labelText : "상품명",
              ),
            ),
            SizedBox(height : 20),
            TextField(
              controller : pcontentController,
              decoration : InputDecoration(
                labelText : "소개",
              ),
            ),
            SizedBox(height : 20),
            TextField(
              controller : ppriceController,
              decoration : InputDecoration(
                labelText : "가격",
              ),
            ),
            SizedBox(height : 20),
            TextButton.icon(
              onPressed: () { onSelectImage(); },
              icon : Icon(Icons.image),
              label: Text("이미지 선택 : ${selectedImage.length}"),
            ),
            SizedBox(height : 20),
            ImagePreview(),
            SizedBox(height : 20),
            ElevatedButton(onPressed: () { onRegister(); }, child: Text("등록"))
          ],
        ),
      ),
    );
  }

}
