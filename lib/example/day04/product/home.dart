// home.dart : 비품 전체 조회 화면

import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:tj2024b_app/example/day04/product/serverpath.dart";

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  Dio dio = Dio();
  List<dynamic> productList = ["샘플"];

  /** 서버에서 데이터 가져오기 <br/> post */
  Future<void> productFindAll() async {
    try {
      final response = await dio.get(serverPath);
      final data = response.data;
      setState(() {
        productList = data;
      });
    } catch(e) {
      print(e);
    }
  }

  /** 서버에서 데이터 삭제하기 <br/> delete */
  Future<void> productDelete(int id) async {
    try {
      String path = serverPath + "?id=$id";
      final response = await dio.delete(path);
      final data = response.data;
      if(data) {
        productFindAll();
      }
    } catch(e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    productFindAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        automaticallyImplyLeading : false,
        title : Text("비품 전체 조회"),
      ),
      body : Center(
        child : Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment : CrossAxisAlignment.center,
          children : [
            Expanded(
              child : ListView(
                children : productList.map<Widget>((product) {
                  return Column(
                    children : [
                      Card(
                        child : ListTile(
                          title : Text("${product["id"]} : ${product["name"]}"),
                          trailing : Row(
                            mainAxisSize : MainAxisSize.min,
                            children : [
                              IconButton(
                                  onPressed : () {
                                    Navigator.pushNamed(context, "/detail", arguments : product["id"]);
                                  },
                                  icon : Icon(Icons.info)
                              ),
                              IconButton(
                                  onPressed : () {
                                    Navigator.pushNamed(context, "/update", arguments : product["id"]);
                                  },
                                  icon : Icon(Icons.edit)
                              ),
                              IconButton(
                                  onPressed : () {
                                    productDelete(product["id"]);
                                  },
                                  icon : Icon(Icons.delete)
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height : 10),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton : FloatingActionButton(
        onPressed : () { Navigator.pushNamed(context, "/write"); },
        child : Icon(Icons.add),
      ),
    );
  }

}