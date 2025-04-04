

void main() {
  // p.70 ~ p.73 연산자 : 책보고 예시 코드 따라서 작성 하여 제출
  // ↓ 덧셈
  int a = 2, b = 1;
  print(a + b);
  String firstName = 'Jeongjoo';
  String lastName = "Lee";
  String fullName = lastName + firstName;
  print("#" * 15);

  // ↓ 뺄셈
  print (a - b);
  print("#" * 15);

  // ↓ - 표현식
  print(-a);
  print("#" * 15);

  // ↓ 곱셈
  int c = 6, d = 3;
  print(c * d);
  print("*" * 5);
  print("#" * 15);

  // ↓ 나눗셈
  int e = 10, f = 5;
  print(e / f);
  print("#" * 15);

  // ↓ 몫(정수)
  print(e ~/ f);
  print("#" * 15);

  // ↓ 나머지
  print(e % f);
  print("#" * 15);

  // ↓  변수++와 변수--
  int g = 0, h = 1;
  print(g++);
  print(g);
  print(h--);
  print(h);
  print("#" * 15);

  // ↓ ++변수와 --변수
  print(++g);
  print(g);
  print(--h);
  print(h);
  print("#" * 15);

  // ↓ ==, !=, >, >=, <, <=
  print(a == b);
  print(a != b);
  print(a > b);
  print(a >= b);
  print(a < b);
  print(a <= b);
  print("#" * 15);

  // ↓  +=, -=, *=
  print(a *= 3);
  print(a = a * 3);
  print("#" * 15);

  // ↓ !표현식
  bool result = a > b;
  print(!result);
  print("#" * 15);

  // ||, &&
  int aa = 3, bb = 2, cc = 1;
  print(aa > bb);
  print(bb < cc);
  print(aa > bb || bb < cc);
  print(aa > bb && bb < cc);
  print("#" * 15);

}