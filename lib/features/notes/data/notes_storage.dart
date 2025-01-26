import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'note_model.dart';

class NotesStorage {
  static const String _notesKey = 'notes';

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedNotes = notes.map((note) => note.toMap()).toList();
    prefs.setString(_notesKey, jsonEncode(encodedNotes));
  }

  Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesData = prefs.getString(_notesKey);

    if (notesData != null) {
      final List<dynamic> decodedNotes = jsonDecode(notesData);
      return decodedNotes.map((note) => Note.fromMap(note)).toList();
    }

    return [];
  }
}
