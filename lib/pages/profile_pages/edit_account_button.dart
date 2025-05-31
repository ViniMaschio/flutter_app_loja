import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_livros/models/users_model.dart';
import 'package:loja_livros/providers/user_provider.dart';

class EditAccountButton extends StatelessWidget {
  final UserModel user;
  const EditAccountButton({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        _showEditModal(context, user);
      },
      icon: const Icon(Icons.edit),
      label: const Text('Alterar dados da conta'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
    );
  }

  void _showEditModal(BuildContext context, UserModel user) {
    final userProvider = context.read<UserProvider>();
    final nameController = TextEditingController(text: user.nome);
    bool isAdmin = user.isAdmin;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Editar Conta'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nome')),
                const SizedBox(height: 16),
                DropdownButtonFormField<bool>(
                  value: isAdmin,
                  decoration: const InputDecoration(labelText: 'Tipo de conta'),
                  items: const [
                    DropdownMenuItem(value: false, child: Text('Comum')),
                    DropdownMenuItem(value: true, child: Text('Administrativa')),
                  ],
                  onChanged: (value) {
                    if (value != null) isAdmin = value;
                  },
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
              ElevatedButton(
                onPressed: () async {
                  final updatedUser = user.copyWith(nome: nameController.text, isAdmin: isAdmin);
                  await userProvider.atualizarUsuario(user.id, updatedUser);
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dados atualizados com sucesso')));
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
    );
  }
}
