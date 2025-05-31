import 'package:flutter/material.dart';
import 'package:loja_livros/pages/profile_pages/edit_account_button.dart';
import 'package:loja_livros/pages/profile_pages/profile_header.dart';
import 'package:provider/provider.dart';
import 'package:loja_livros/providers/user_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text('Usuário não encontrado')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Minha Conta')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [const SizedBox(height: 40), ProfileHeader(user: user), const SizedBox(height: 30), EditAccountButton(user: user)],
        ),
      ),
    );
  }
}
