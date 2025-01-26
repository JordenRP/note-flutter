import 'package:flutter/material.dart';
import '../data/note_model.dart';
import '../sync_service.dart';

class NoteDetailPage extends StatefulWidget {
  final Note? note;

  const NoteDetailPage({super.key, this.note});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late bool _isEditing;
  final SyncService _syncService = SyncService();

  @override
  void initState() {
    super.initState();
    _isEditing = widget.note != null;
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заполните все поля')),
      );
      return;
    }

    final newNote = Note(
      id: widget.note?.id ?? DateTime.now().toString(),
      title: title,
      content: content,
      createdAt: widget.note?.createdAt ?? DateTime.now(),
    );

    try {
      await _syncService.syncNote(newNote);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заметка сохранена на сервере')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ошибка сохранения на сервере')),
      );
    }

    Navigator.pop(context, newNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Редактировать заметку' : 'Новая заметка'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Заголовок',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: 'Содержание',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
