import 'package:flutter/material.dart';
import 'package:loja_livros/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:loja_livros/providers/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: const Text('Página Inicial'),
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: user == null ? const Text('Usuário não encontrado') : Text('Bem-vindo, ${user.nome}!', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
