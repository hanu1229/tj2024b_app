



void main() {
  print("hello world");

  // 문자 타입
  String name = "유재석"; print(name);
  String name2 = '유재석'; print(name2);
  String name3 = "이름 : $name"; print(name3);

  // 숫자 타입
  int year = 2023; print(year);
  double pi = 3.14159; print(pi);
  num year2 = 2023; print(year2);
  num pi2 = 3.141592; print(pi2);

  // bool 타입
  bool darkMode = false; print(darkMode);

  // 컬렉션
  List<String> fruits = ["사과", "딸기", "바나나", "샤인머스켓"]; print(fruits);
  print(fruits[2]); print(fruits.length);
  Set<int> odds = {1, 3, 5, 7, 9}; print(odds);
  Map<String ,int> regionMap = {
    "서울" : 0, "인천" : 1, "대전" : 2, "부산" : 3,
    "대구" : 4, "광주" : 5, "울산" : 6, "세종" : 7
  }; print(regionMap); print(regionMap["서울"]);

  // 기타
  // Object : 모든 자료들은 Object(최상위 타입)저장 가능 | 타입 변환 필요
  Object a = 1;
  Object b = 3.14;
  Object c = "강호동";
  int? test = null;

  // dynamic : 동적 타입으로 대입이 되는 순간 타입이 결정됨(다른 타입이 들어오면 그 타입으로 결정됨)
  dynamic d1 = 1;
  dynamic d2 = 3.14;
  dynamic d3 = "강호동";
  dynamic d4 = ["사과"];
  dynamic d5 = {1, 3, 5};
  dynamic d6 = {"name" : "강호동", "age" : 40};
  print(d1); print(d2); print(d3); print(d4); print(d5); print(d6);
  String? str = null;

  // null 안정성 : 타입 뒤에 ?를 붙임(단, String은 예외)
  // var : 처음에 할당된 값이 타입을 결정

  DateTime dt = DateTime(2025, 4, 2, 16, 53);
  print(dt);

}