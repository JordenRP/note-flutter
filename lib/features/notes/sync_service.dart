import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/features/notes/data/note_model.dart';

class SyncService {
  static const String baseUrl = 'http://localhost:5000';

  Future<List<Note>> syncNotes(List<Note> localNotes) async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');

    if (username == null) {
      throw Exception('Пользователь не авторизован');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/sync'),
      body: jsonEncode({
        'username': username,
        'notes': localNotes.map((note) => note.toMap()).toList(),
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['notes'] as List<dynamic>;
      return data.map((note) => Note.fromMap(note)).toList();
    }

    return localNotes;
  }
}
