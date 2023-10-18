import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_pad/add_page.dart';
import 'package:note_pad/manager/shared_pref_manager.dart';

import 'model/note.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final _shared = SharedPrefManager();
  final List<Note> _noteList = [];

  @override
  void initState() {
    super.initState();
    _readNotes();
  }

  void _readNotes() async {
    final s = await _shared.readNoteList();
    for (var i in s) {
      _noteList.add(Note.fromJson(i));
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes"), actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddPage()));
            },
            icon: const Icon(Icons.add))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12
          ),
          itemCount: _noteList.length,
          itemBuilder: (context, index) {
            final reversed = _noteList.reversed.toList();
            final note = reversed[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.deepPurpleAccent.withAlpha(70),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(note.title,style: TextStyle(fontSize: 22,color: Colors.black)),
                      Text(note.desc,style: TextStyle(fontSize: 18,color: Colors.black)),
                      Text(note.time,style: TextStyle(fontSize: 12,color: Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
