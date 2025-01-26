import 'package:flutter/material.dart';
import 'features/notes/presentation/notes_list_page.dart';
import 'features/notes/presentation/note_detail_page.dart';
import 'features/notes/data/note_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const NotesListPage(),
        '/note_detail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Note?;
          return NoteDetailPage(note: args);
        },
      },
    );
  }
}
