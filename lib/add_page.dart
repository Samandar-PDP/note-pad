import 'package:flutter/material.dart';
import 'package:note_pad/manager/shared_pref_manager.dart';
import 'package:note_pad/note_list_screen.dart';

import 'model/note.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _shared = SharedPrefManager();
  final List<Note> _noteList = [];
  
  void _saveNewNote() async {
    final currentTime = DateTime.now();

    final dyNotes = await _shared.readNoteList();
    final List<Note> s= [];

    for(var i in dyNotes) {
      s.add(Note.fromJson(i));
    }

    var title = _titleController.text;

    _noteList.addAll(s);
    final spaceIndex = _descController.text.indexOf(' ');
    if(title.isEmpty) {
      title = _descController.text.substring(0, spaceIndex);
      print(title);
    }

    _noteList.add(Note(title: title, desc: _descController.text, time: currentTime.toString()));
    _shared.saveNoteList(_noteList);

    _titleController.text = '';
    _descController.text = '';
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Note"),
        actions: [IconButton(onPressed: () {
          _saveNewNote();
          // _titleController.dispose();
          // _descController.dispose();
          Navigator.of(context)
            .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const NoteListScreen()), (Route<dynamic> route) => false);
        }, icon: Icon(Icons.check))],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 20, color: Colors.black),
              controller: _titleController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.black12)),
            ),
            Expanded(
              child: TextField(
                style: TextStyle( color: Colors.black),
                controller: _descController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Content',
                    hintStyle: TextStyle(color: Colors.black12)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
