import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/note.dart';

class SharedPrefManager {
  saveNoteList(List<Note> notes) async {
    final shared = await SharedPreferences.getInstance();
    shared.setString('notes', json.encode(notes));
  }

  readNoteList() async {
    final shared = await SharedPreferences.getInstance();
    try {
      return json.decode(shared.getString('notes') ?? "");
    } catch(e) {
      return [];
    }
  }

  clear() async {
    final shared = await SharedPreferences.getInstance();
    shared.clear();
  }
}
