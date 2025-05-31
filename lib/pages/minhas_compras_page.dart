import 'package:flutter/material.dart';

class MinhasComprasPage extends StatelessWidget {
  const MinhasComprasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Compras')),
      body: const Center(
        child: Text(
          'Aqui serão listadas todas as compras feitas pelo usuário.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
