import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tj2024b_app/app/layout/main_app.dart';
import 'package:tj2024b_app/app/product/product_list.dart';
import 'package:tj2024b_app/app/server_url.dart';

class ProductView extends StatefulWidget {

  int pno;
  String pname;

  ProductView({required this.pno, required this.pname});

  @override
  State<ProductView> createState() => _ProductViewState();

}

class _ProductViewState extends State<ProductView> {

  final dio = Dio();
  final baseUrl = serverUrl;

  Map<String, dynamic> product = {};
  bool isOwner = false;

  @override
  void initState() {
    super.initState();
    // pno에 해당하는 제품 정보 요청
    onView();
  }

  Future<void> onView() async {
    try {
      final response = await dio.get("$baseUrl/product/view?pno=${widget.pno}");
      if(response.data != null) {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");
        if(token == null) { setState(() { isOwner = false; }); }
        final response2 = await dio.get("$serverUrl/member/info", options : Options(headers : {"Authorization" : token}));
        if(response2.data["email"] == response.data["email"]) {
          setState(() { isOwner = true; });
        }
        setState(() {
          product = response.data;
          print(product);
        });
      }
    } catch(e) {
      print(e);
    }
  }

  Future<void> deleteProduct(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if(token == null) { return; }
      Options options = Options(headers : {"Authorization" : token});
      final response = await dio.delete("$serverUrl/product/delete?pno=${widget.pno}", options : options);
      if(response.statusCode == 200 && response.data == true) {
        print("삭제 성공!");
        setState(() {});
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MainApp(),
        //   ),
        // );
        Navigator.pop(context);
      } else {
        print("삭제 실패!");
      }
    } catch(e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {

    if(product.isEmpty) { return Center(child : CircularProgressIndicator()); }
    final List<dynamic> images = product["images"];
    Widget imageWidget;
    if(images.isEmpty) {
      imageWidget = Container(
        height : 300,
        alignment : Alignment.center,
        child : Image.network("$baseUrl/upload/default.jpg", fit : BoxFit.cover)
      );
    } else {
      imageWidget = Container(
        height : 300,
        child : ListView.builder(
          scrollDirection : Axis.horizontal,
          itemCount : images.length,
          itemBuilder : (context, index) {
            String imageUrl = "$baseUrl/upload/${images[index]}";
            return Padding(
              padding : EdgeInsets.all(5),
              child : Image.network(imageUrl),
            );
          }
        ),
      );
    }

    return Scaffold(
      appBar : AppBar(title : Text("${product["pname"]} 상세 정보")),
      body : SingleChildScrollView(
        child : Padding(
          padding : EdgeInsets.all(16),
          child : Column(
            crossAxisAlignment : CrossAxisAlignment.start,
            children : [
              imageWidget,
              SizedBox(height : 10),
              Text("${product["pname"]}", style : TextStyle(fontSize : 26, fontWeight : FontWeight.bold)),
              SizedBox(height : 10),
              Text("가격 : ${product["pprice"]}", style : TextStyle(fontSize : 22, fontWeight : FontWeight.bold, color : Colors.red)),
              SizedBox(height : 10),
              Divider(),
              SizedBox(height : 10),
              Row(
                mainAxisAlignment : MainAxisAlignment.spaceBetween,
                children : [
                  Text("카테고리 : ${product["cname"]}"),
                  Text("조회수 : ${product["pview"]}"),
                ],
              ),
              SizedBox(height : 10),
              Text("판매자 : ${product["email"]}"),
              SizedBox(height : 10),
              Divider(),
              SizedBox(height : 10),
              Text("제품 설명", style : TextStyle(fontSize : 20, fontWeight : FontWeight.bold)),
              SizedBox(height : 10),
              Text("${product["pcontent"]}"),
              SizedBox(height : 10),
              Divider(),
              SizedBox(height : 10),
              isOwner ? Row(
                mainAxisAlignment : MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    icon : Icon(Icons.edit, color : Colors.white),
                    onPressed : () {

                    },
                    label : Text("수정하기", style : TextStyle(color : Colors.white,),),
                    style : ElevatedButton.styleFrom(
                      backgroundColor : Colors.blue,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon : Icon(Icons.delete, color : Colors.white),
                    onPressed : () {
                      deleteProduct(context);
                    },
                    label : Text("삭제하기", style : TextStyle(color : Colors.white,),),
                    style : ElevatedButton.styleFrom(
                      backgroundColor : Colors.blue,
                    ),
                  ),
                ],
              ) : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

}
