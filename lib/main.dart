import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'note_list_screen.dart';

void main() {
  runApp(NoteApp());
}

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: const NoteListScreen(),
    );
  }
}