import 'package:flutter/material.dart';

class LojaPage extends StatelessWidget {
  const LojaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loja')),
      body: const Center(
        child: Text(
          'Aqui será exibida a lista de livros disponíveis para compra.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
