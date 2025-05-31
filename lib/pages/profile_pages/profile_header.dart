import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja_livros/models/users_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
          const SizedBox(height: 20),
          Text(
            user.nome,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text('Conta: ${user.isAdmin ? "Administrativa" : "Comum"}', style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(
            'Criado em: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(user.createdAt))}',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
