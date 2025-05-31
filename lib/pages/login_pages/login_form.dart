import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_livros/providers/user_provider.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  Future<void> _fazerLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final success = await userProvider.login(_emailController.text.trim(), _senhaController.text.trim());

      if (success) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login realizado com sucesso!')));

        Navigator.pushNamedAndRemoveUntil(context, '/home_page', (route) => false);
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(userProvider.errorMessage ?? 'Erro no login')));
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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInput(controller: _emailController, label: 'E-mail', validator: validarEmail),
          const SizedBox(height: 16),
          CustomInput(
            controller: _senhaController,
            label: 'Senha',
            obscure: true,
            validator: (value) => value != null && value.length < 6 ? 'Senha inválida' : null,
          ),
          const SizedBox(height: 24),
          CustomButton(label: 'Entrar', isLoading: userProvider.isLoading, onPressed: () => _fazerLogin(context)),
          const SizedBox(height: 16),
          TextButton(onPressed: () => Navigator.pushNamed(context, '/creater_user_page'), child: const Text('Não tem conta? Cadastre-se')),
        ],
      ),
    );
  }
}
