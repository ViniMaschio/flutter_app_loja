import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_livros/models/users_model.dart';
import 'package:loja_livros/providers/user_provider.dart';
import 'package:loja_livros/widgets/custom_input.dart';
import 'package:loja_livros/widgets/custom_button.dart';

class CreateUserForm extends StatefulWidget {
  const CreateUserForm({super.key});

  @override
  State<CreateUserForm> createState() => _CreateUserFormState();
}

class _CreateUserFormState extends State<CreateUserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  Future<void> _cadastrarUsuario(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final user = UserModel(
        id: '',
        nome: _nomeController.text.trim(),
        email: _emailController.text.trim(),
        senha: _senhaController.text.trim(),
        createdAt: DateTime.now().toIso8601String(),
      );

      await userProvider.adicionarUsuario(user);
      if (!context.mounted) return;

      await userProvider.login(user.email, user.senha);
      if (!context.mounted) return;

      if (userProvider.currentUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Usuário cadastrado e logado com sucesso!')));
        Navigator.pushNamedAndRemoveUntil(context, '/home_page', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(userProvider.errorMessage ?? 'Erro no cadastro')));
      }
    }
  }

  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe o e-mail';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'E-mail inválido';
    }

    return null;
  }

  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe a senha';
    }

    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }

    final hasUppercase = RegExp(r'[A-Z]');
    final hasLowercase = RegExp(r'[a-z]');
    final hasDigit = RegExp(r'\d');

    if (!hasUppercase.hasMatch(value) || !hasLowercase.hasMatch(value) || !hasDigit.hasMatch(value)) {
      return 'A senha deve conter pelo menos uma letra maiúscula, \numa letra minúscula e um número';
    }

    if (value.length > 20) {
      return 'A senha deve ter no máximo 20 caracteres';
    }
    if (value.contains(' ')) {
      return 'A senha não pode conter espaços';
    }
    return null;
  }

  String? validarConfirmacaoSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirme a senha';
    }
    if (value != _senhaController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInput(
            controller: _nomeController,
            label: 'Nome',
            validator: (value) => value == null || value.isEmpty || value.length < 4 ? 'Informe o nome completo' : null,
          ),
          const SizedBox(height: 16),
          CustomInput(controller: _emailController, label: 'E-mail', validator: validarEmail),
          const SizedBox(height: 16),
          CustomInput(controller: _senhaController, label: 'Senha', obscure: true, validator: validarSenha),
          const SizedBox(height: 16),
          CustomInput(controller: _confirmarSenhaController, label: 'Confirmar Senha', obscure: true, validator: validarConfirmacaoSenha),
          const SizedBox(height: 24),
          CustomButton(label: 'Cadastrar', isLoading: userProvider.isLoading, onPressed: () => _cadastrarUsuario(context)),
        ],
      ),
    );
  }
}
