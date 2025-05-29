import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_livros/providers/user_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;

    return Drawer(
      child: Column(
        children: [
          // TOPO COM NOME DO USUÁRIO
          UserAccountsDrawerHeader(
            accountName: Text(user?.nome ?? 'Usuário'),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: const CircleAvatar(child: Icon(Icons.person, size: 32)),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('HOME'),
            onTap: () {
              Navigator.pop(context); // fecha o Drawer antes de navegar
              Navigator.pushNamed(context, '/home_page');
            },
          ),

          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Listar Livro'),
            onTap: () {
              Navigator.pop(context); // fecha o Drawer antes de navegar
              Navigator.pushNamed(context, '/listar_livro');
            },
          ),

          const Spacer(), // empurra o botão para baixo
          // BOTÃO DE SAIR
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sair', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await Provider.of<UserProvider>(context, listen: false).logout();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/login_page', (_) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
