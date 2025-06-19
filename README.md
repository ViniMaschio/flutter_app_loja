# 📚 Flutter Library App

Aplicativo Flutter com integração ao Firebase, simulando o funcionamento de uma *libraria digital*, com funcionalidades de autenticação, gerenciamento administrativo e loja virtual para usuários comuns.

---

## 🧩 Funcionalidades

### 🔐 Autenticação
- Cadastro e login de usuários usando **Firebase Authentication**.
- Diferenciação de usuários:
  - 👩‍💼 **Administrador**: acesso a cadastros e gerenciamento.
  - 🧑 **Usuário comum**: acesso à loja e histórico de compras.

### 🛒 Loja Virtual
- Visualização de produtos disponíveis.
- Realização de compras com persistência no Firebase.
- Listagem de todas as compras feitas por um usuário.

### 🗂️ Cadastro de Itens (Admin)
- Adição de novos produtos (livros ou itens da loja).
- Interface exclusiva para administradores.

### ☁️ Firebase Firestore
- Todos os dados são armazenados na nuvem com **Cloud Firestore**:
  - Usuários
  - Produtos
  - Compras

---

## 🚀 Tecnologias Utilizadas

- **Flutter** – Framework para desenvolvimento mobile cross-platform.
- **Firebase Authentication** – Login/cadastro de usuários.
- **Firebase Firestore** – Banco de dados em tempo real.
- **Provider** – Gerenciamento de estado.
- **Material Design** – Interface amigável e responsiva.
