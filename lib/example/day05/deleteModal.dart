// deleteModal.dart : 비밀번호를 입력할 수 있는 모달창

import "package:flutter/material.dart";

Future<String?> showPasswordDialog(BuildContext context) async {
  final TextEditingController passwordController = TextEditingController();

  return showDialog<String>(
      context: context,
      builder: (context) {
        bool _obscure = true;
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("비밀번호 확인"),
                content: TextField(
                  controller: passwordController,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: "비밀번호",
                    enabledBorder: OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                    border: OutlineInputBorder(borderSide : BorderSide(color : Colors.black, width : 1)),
                    suffixIcon : IconButton(
                      onPressed : () { setState(() { _obscure = !_obscure; }); },
                      icon : Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, passwordController.text); // 비밀번호 반환
                    },
                    child: Text("확인"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context), // 취소
                    child: Text("취소"),
                  ),
                ],
              );
            });
      }
  );
}