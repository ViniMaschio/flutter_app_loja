// custom_book_form.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loja_livros/models/book_model.dart';
import 'package:loja_livros/widgets/custom_input.dart';
import 'package:loja_livros/widgets/custom_button.dart';

class CustomBookForm extends StatefulWidget {
  final BookModel? book;
  final void Function(BookModel, File) onSubmit;
  final bool isLoading;
  const CustomBookForm({super.key, this.book, required this.onSubmit, this.isLoading = false});

  @override
  State<CustomBookForm> createState() => _CustomBookFormState();
}

class _CustomBookFormState extends State<CustomBookForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _autorController = TextEditingController();
  final _precoController = TextEditingController();
  final _quantidadeController = TextEditingController();
  File? _imagemSelecionada;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _nomeController.text = widget.book!.nome;
      _autorController.text = widget.book!.autor;
      _precoController.text = widget.book!.preco.toString();
      _quantidadeController.text = widget.book!.quantidade.toString();
      _imagemSelecionada = widget.book!.imagemUrl.isNotEmpty ? File(widget.book!.imagemUrl) : null;
    }
  }

  Future<void> _selecionarImagem() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _imagemSelecionada = File(picked.path));
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate() || _imagemSelecionada == null) return;
    final book = BookModel(
      id: widget.book?.id ?? '',
      nome: _nomeController.text.trim(),
      autor: _autorController.text.trim(),
      preco: double.tryParse(_precoController.text.trim()) ?? 0.0,
      quantidade: int.tryParse(_quantidadeController.text.trim()) ?? 0,
      imagemUrl: '',
    );
    widget.onSubmit(book, _imagemSelecionada!);
  }

  String? validarPreco(String? v) {
    if (v == null || v.isEmpty) {
      return 'Informe o preço';
    }

    final preco = double.tryParse(v.replaceAll(',', '.'));
    if (preco == null) {
      return 'Preço inválido';
    }

    if (preco < 0) {
      return 'Preço não pode ser negativo';
    }

    final partes = v.split(RegExp(r'[.,]'));
    if (partes.length == 2 && partes[1].length > 2) {
      return 'Máximo de 2 casas decimais';
    }

    return null;
  }

  String? validarQuantidade(String? v) {
    if (v == null || v.isEmpty) {
      return 'Informe a quantidade';
    }

    final quantidade = int.tryParse(v);
    if (quantidade == null) {
      return 'Informe um número inteiro válido';
    }

    if (quantidade <= 0) {
      return 'A quantidade deve ser maior que 0';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInput(
            controller: _nomeController,
            label: 'Nome do Livro',
            validator: (v) => v == null || v.isEmpty ? 'Informe o nome' : null,
          ),
          const SizedBox(height: 16),
          CustomInput(controller: _autorController, label: 'Autor', validator: (v) => v == null || v.isEmpty ? 'Informe o autor' : null),
          const SizedBox(height: 16),
          CustomInput(controller: _precoController, label: 'Preço', validator: validarPreco),
          const SizedBox(height: 16),
          CustomInput(controller: _quantidadeController, label: 'Quantidade', validator: validarQuantidade),
          const SizedBox(height: 16),
          InkWell(
            onTap: _selecionarImagem,
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child:
                  _imagemSelecionada != null
                      ? Image.file(_imagemSelecionada!, height: 140, fit: BoxFit.cover)
                      : const Text('Selecionar Imagem'),
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(label: widget.book == null ? 'Cadastrar' : 'Atualizar', isLoading: widget.isLoading, onPressed: _submit),
        ],
      ),
    );
  }
}
