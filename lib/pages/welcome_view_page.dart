import 'package:flutter/material.dart';
import 'package:loja_livros/widgets/custom_button.dart';

class WelcomeViewPage extends StatelessWidget {
  const WelcomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Bem-vindo à Livraria!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              CustomButton(label: 'Login', onPressed: () => Navigator.pushNamed(context, '/login_page')),
              const SizedBox(height: 16),
              CustomButton(label: 'Cadastrar', onPressed: () => Navigator.pushNamed(context, '/creater_user_page')),
            ],
          ),
        ),
      ),
    );
  }
}
