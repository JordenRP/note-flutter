import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/note_model.dart';
import '../data/notes_storage.dart';
import '../sync_service.dart';

class NotesListPage extends StatefulWidget {
  const NotesListPage({super.key});

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  final NotesStorage _storage = NotesStorage();
  final SyncService _syncService = SyncService();
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final localNotes = await _storage.loadNotes();
    setState(() {
      _notes = localNotes;
    });

    try {
      final syncedNotes = await _syncService.syncNotes(localNotes);
      setState(() {
        _notes = syncedNotes;
      });
      await _storage.saveNotes(syncedNotes);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ошибка синхронизации')),
      );
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', false);
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои заметки'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _notes.isEmpty
          ? const Center(child: Text('Нет заметок. Добавьте первую!'))
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/note_detail',
                      arguments: note,
                    ).then((_) => _loadNotes());
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/note_detail').then((_) => _loadNotes());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
