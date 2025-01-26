
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String notesList = '/notes';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const PlaceholderPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case notesList:
        return MaterialPageRoute(builder: (_) => const NotesListPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Страница не найдена')),
          ),
        );
    }
  }
}

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placeholder Page'),
      ),
      body: const Center(
        child: Text('Добро пожаловать!'),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: const Center(
        child: Text('Страница авторизации'),
      ),
    );
  }
}

class NotesListPage extends StatelessWidget {
  const NotesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes List'),
      ),
      body: const Center(
        child: Text('Список заметок'),
      ),
    );
  }
}
