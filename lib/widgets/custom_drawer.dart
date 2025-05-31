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
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.grey),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(backgroundColor: Colors.white, radius: 30, child: Icon(Icons.person, size: 32, color: Colors.black)),
                  const SizedBox(height: 12),
                  Text(
                    user?.nome ?? 'Usuário',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/profile_page');
                    },
                    label: const Text('Minha Conta', style: TextStyle(color: Colors.white)),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      backgroundColor: Colors.black26,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('HOME'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/home_page');
                  },
                ),
                if (user?.isAdmin == true) ...[
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text('Listar Livros'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/listar_livro');
                    },
                  ),
                ] else ...[
                  ListTile(
                    leading: const Icon(Icons.store),
                    title: const Text('Loja'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/loja_page'); // Substitua pela rota real da loja
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_bag),
                    title: const Text('Minhas Compras'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/compras_page'); // Substitua pela rota real das compras
                    },
                  ),
                ],
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sair', style: TextStyle(color: Colors.red)),
              onTap: () async {
                await Provider.of<UserProvider>(context, listen: false).logout();
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(context, '/welcome_view', (_) => false);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
