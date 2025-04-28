import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductView extends StatefulWidget {

  int pno;
  String pname;

  ProductView({required this.pno, required this.pname});

  @override
  State<ProductView> createState() => _ProductViewState();

}

class _ProductViewState extends State<ProductView> {

  final dio = Dio();
  final baseUrl = "http://192.168.40.38:8080";

  Map<String, dynamic> product = {};

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
        setState(() {
          product = response.data;
          print(product);
        });
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
            ],
          ),
        ),
      ),
    );
  }

}
