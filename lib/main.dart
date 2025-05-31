import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_livros/firebase_options.dart';
import 'package:loja_livros/models/book_model.dart';
import 'package:loja_livros/pages/livros_pages/cadastro_livro_page.dart';
import 'package:loja_livros/pages/login_pages/create_user_page.dart';
import 'package:loja_livros/pages/livros_pages/editar_livro_page.dart';
import 'package:loja_livros/pages/home_page.dart';
import 'package:loja_livros/pages/livros_pages/listar_livro_page.dart';
import 'package:loja_livros/pages/login_pages/login_page.dart';
import 'package:loja_livros/pages/loja_page.dart';
import 'package:loja_livros/pages/minhas_compras_page.dart';
import 'package:loja_livros/pages/profile_pages/profile_page.dart';
import 'package:loja_livros/pages/welcome_view_page.dart';
import 'package:loja_livros/providers/book_provider.dart';
import 'package:loja_livros/providers/user_provider.dart';
import 'package:loja_livros/repositories/book_repository.dart';
import 'package:loja_livros/repositories/user_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(userRepository: UserRepository())),
        ChangeNotifierProvider(create: (_) => BookProvider(bookRepository: BookRepository())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomeViewPage(),
      routes: <String, WidgetBuilder>{
        '/login_page': (BuildContext context) => const LoginPage(),
        '/creater_user_page': (BuildContext context) => const CreateUserPage(),
        '/home_page': (BuildContext teste) => const HomePage(),
        '/cadastro_livro': (context) => const CadastroLivroPage(),
        '/listar_livro': (context) => const ListarLivroPage(),
        '/welcome_view': (context) => const WelcomeViewPage(),
        '/profile_page': (context) => const ProfilePage(),
        '/loja_page': (context) => const LojaPage(),
        '/compras_page': (context) => const MinhasComprasPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/editar_livro') {
          final livro = settings.arguments as BookModel;
          return MaterialPageRoute(builder: (context) => EditarLivroPage(livroExistente: livro));
        }

        return null;
      },
    );
  }
}
