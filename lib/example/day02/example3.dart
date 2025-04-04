

void main() {
  // p.73 ~ p.84 연산자 : 책 보고 예시 코드 따라서 작성 하여 제출

  // 반복문
  int number = 31;
  if(number % 31 == 1) {
    print("홀수!");
  } else {
    print("짝수!");
  }
  String light = "red";
  if(light == "green") {
    print("초록불!");
  } else if(light == "yellow") {
    print("노란불!");
  } else if(light == "red") {
    print("빨간불!");
  } else {
    print("잘못된 신호입니다.");
  }
  light = "purple";
  if(light == "green") {
    print("초록불!");
  } else if(light == "yellow") {
    print("노란불!");
  } else if(light == "red") {
    print("빨간불!");
  }

  // 반복문
  for(int i = 0; i < 100; i++) {
    print(i + 1);
  }
  List<String> subjects = ["자료구조", "이산수학", "알고리즘", "플러터"];
  for(String subject in subjects) {
    print(subject);
  }
  int i = 0;
  while(i < 100) {
    print(i + 1);
    i = i + 1;
  }
  /*
    무한루프
    i = 0;
    while(true) {
      print(i+1);
      i = i + 1;
    }
  */
  i = 0;
  while(true) {
    print(i + 1);
    i = i + 1;
    if(i == 100) {
      break;
    }
  }
  for(int j = 0; j < 100; j++) {
    if(j % 2 == 0) {
      continue;
    }
    print(j + 1);
  }

  // 함수
  number = add(1, 2);
  print(number);

  // 패턴매칭 | switch문
  switch(number) {
    case 1:
      print("one");
  }
  const a = "a";
  const b = "b";
  var obj = [a, b];
  switch(obj) {
    case [a, b]:
      print("$a, $b");
  }
  switch(obj) {
    case 1:
      print("one");
    // case >= first && <= last:
    //   print("in range");
    case (var a, var b):
      print("a = $a, b = $b");
    default:
      print("...");
  }


}

int add(int a, int b) {
  return a + b;
}