import 'package:flutter/material.dart';
import 'package:loja_livros/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Login')), body: const Padding(padding: EdgeInsets.all(24.0), child: LoginForm()));
  }
}
