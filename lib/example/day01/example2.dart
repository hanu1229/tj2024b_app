


void main() {
  // p.67 레코드 . dart3부터 추가된 타입
  // 듀플 == 값의 묵음 - 집행
  // 레코드 생성하는 방법1
  var record = ("first", a : 2, b : true, "last");
  print(record);

  // 레코드 생성하는 방법2
  (String, int) record2;
  record2 = ("유재석", 40); print(record2);

  // 레코드의 값 호출
  // key가 존재하지 않는 첫번째 value
  print(record.$1);
  // 'a'라는 key의 값을 반환
  print(record.a);
  // 'b'라는 key의 값을 반환
  print(record.b);
  // key가 존재하지 않는 두번째 value
  print(record.$2);

  // json형식
  dynamic json = {"name" : "Dash", "age" : 10, "color" : "blue"};
  print(json);
}