import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tj2024b_app/app/product/product_view.dart';
import 'package:tj2024b_app/app/server_url.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}
class _ProductListState extends State<ProductList>{
  // 1.
  int cno = 0; // 카테고리 번호 갖는 상태변수 , 초기값 0
  int page = 1; // 현재 조회 중인 페이지 번호 갖는 상태변수 , 초기값 1
  List<dynamic> productList = []; // 자바서버로 부터 조회 한 제품(DTO) 목록 상태변수
  final dio = Dio(); // 자바서버 와 통신 객체
  String baseUrl = serverUrl; // 기본 자바서버의 URL 정의 // 환경에 따라 IP변경
  // * 현재 스크롤의 상태( 위치/크기 등) 를 감지하는 컨트롤러
  // * 무한스크롤( 스크롤이 거의 바닥에 위치했을때 새로운 자료 요청 해서 추가 한다. )
  // .position : 현재 스크롤의 위치 반환 , .position.pixels : 위치를 픽셀로 반환
  // .position.maxScrollExtent : 현재 화면의 스크롤 최대 크기
  final ScrollController scrollController = ScrollController();

  // 2. 현재 위젯 생명주기 : 위젯이 처음으로 열렸을때 1번 실행
  @override // (1)자바서버에게 자료 요청 (2) 스크롤의 리스너(이벤트) 추가.
  void initState() {
    onProductAll( page ); // 현재 페이지 전달
    scrollController.addListener( onScroll ); // .addListener: 스크롤의 이벤트(함수) 리스너 추가
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    onProductAll(page);
  }

  // 3. 자바서버에게 자료 요청 메소드
  void onProductAll( int currentPage ) async {
    try{
      final response = await dio.get( "$baseUrl/product/all?page=$currentPage"); // 현재페이지(page) 매개변수로 보낸다.
      print(">> ${response.data["totalPages"]}");
      setState(() {
        page = currentPage; // 증가된 현재페이지를 상태변수에 반영
        if(page == 1) {
          productList = response.data["content"];
        } else if(page >= response.data["totalPages"]) {
          // 만약에 전체 페이지 수보다 높으면
          page = response.data["totalPages"];
        } else {
          productList.addAll(response.data["content"]); // 서버로 부터 받은 자료를 상태변수에 반영한다.
        }
        print( productList ); // [확인용]
      });
    }catch(e){
      print( e );
    }
  }

  // 4. 스크롤의 리스너(이벤트) 추가 메소드
  void onScroll( ){
    // - 만약에 현재 스크롤의 위치가 거의( 적당하게 100 ~ 200 사이 위 ) 끝에 도달 했을때
    if( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 150 ){
      onProductAll( page + 1 ); // 스크롤이 거의 바닥에 도달했을때 page 를 1증가 하여 다음 페이지 자료 요청한다.
    }
  }

  @override
  Widget build(BuildContext context) {
    if(productList.isEmpty) {
      return Center(child : Text("조회된 제품이 없습니다."));
    }
    return ListView.builder(
      controller : scrollController,
      itemCount : productList.length,
      itemBuilder : (context, index) {
        final product = productList[index];
        final List<dynamic> images = product["images"];
        String? imageUrl;
        if(images.isEmpty) { imageUrl = "$baseUrl/upload/default.jpg"; }
        else { imageUrl = "$baseUrl/upload/${images[0].toString()}"; }
        // InlWell() : 해당 위젯을 클릭(탭)하면 상세 페이지로 이동 구현
        return InkWell(
          onTap : () {
            Navigator.push(
              context,
              MaterialPageRoute(builder : (context) => ProductView(pno : product["pno"], pname : product["pname"]))
            );
          },
          child : Card(
            margin : EdgeInsets.all(16),
            child : Row(
              children : [
                SizedBox(
                  width : 200,
                  height : 200,
                  child : Image.network(imageUrl),
                ),
                SizedBox(width : 20),
                // Card 위젯의 남은 부분 전체
                Expanded(
                  child : Column(
                    crossAxisAlignment : CrossAxisAlignment.start,
                    children : [
                      Text("상품명 : ${product["pname"]}", style : TextStyle(fontSize : 20, fontWeight : FontWeight.bold)),
                      SizedBox(height : 10),
                      Text("가격 : ${product["pprice"]}", style : TextStyle(fontSize : 16, color : Colors.red)),
                      SizedBox(height : 10),
                      Text("카테고리 : ${product["cname"]}"),
                      SizedBox(height : 10),
                      Text("조회수 : ${product["pview"]}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
