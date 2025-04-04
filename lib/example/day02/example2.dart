import "package:dio/dio.dart";

// 1. Dio 객체 생성 new 생략 가능
final dio = new Dio();

// Dart언어는 단일 스레드 기반
void main() async {
  print("dart start");
  await postHttp();
  await getHttp();
}

// 3. (1) 비동기 통신
// dio.HTTP메소드명("URL") vs axios.HTTP메소드명("HRL")
// dio.get("URL");
// 테스트 : web3의 day03 과제3의 StudentController에게 통신
Future<void> getHttp() async {
  try {
    // dio통신을 이용한 자바와 통신
    final response = await dio.get("http://localhost:8080/day03/task3/course");
    // 응답 확인
    print(response.data);
  } catch(e) {
    print(e);
  }
}

// dio.get("URL", Map);
Future<void> postHttp() async {
  try {
    // 보내고자 하는 내용을 JSON(dart map)으로 만들기
    final sendData = {"name": "수학"};
    // dio통신을 이용한 자바와 통신
    final response = await dio.post("http://localhost:8080/day03/task3/course", data: sendData);
    // 응답 확인
    print(response.data);
  } catch(e) {
    print(e);
  }
}