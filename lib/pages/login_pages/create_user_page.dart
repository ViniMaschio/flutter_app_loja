import 'package:flutter/material.dart';
import 'package:loja_livros/pages/login_pages/create_user_form.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: const Padding(padding: EdgeInsets.all(24.0), child: CreateUserForm()),
    );
  }
}
