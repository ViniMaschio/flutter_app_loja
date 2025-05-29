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
  Future<void> _logout() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.logout();

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(context, '/login_page', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: const Text('Página Inicial'),
        actions: [IconButton(icon: const Icon(Icons.logout), tooltip: 'Sair', onPressed: _logout)],
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: user == null ? const Text('Usuário não encontrado') : Text('Bem-vindo, ${user.nome}!', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
