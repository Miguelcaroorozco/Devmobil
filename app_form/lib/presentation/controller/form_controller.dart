import 'package:flutter/material.dart';

class FormController {
  final Map<String, Map<String, String>> users = const {
    'Migue@gmail.com': {
      'password': '123456',
      'name': 'Miguel Jesus Caro Orozco',
    },
    'Alejo@gmail.com': {'password': '123456', 'name': 'Alejandro Yepes Geney'},
  };

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool authenticate() {
    return users[emailController.text.trim()]?['password'] ==
        passwordController.text;
  }

  Map<String, String>? get authenticatedUser {
    return users[emailController.text.trim()];
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
