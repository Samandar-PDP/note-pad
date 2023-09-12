import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_pad/manager/shared_pref_manager.dart';
import 'package:note_pad/model/note.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {

  List<Note> _noteList = [];

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _sharedPref = SharedPrefManager();


  @override
  void initState() {
    super.initState();
    _readNotes();
  }

  void _readNotes() async {
    var list = await _sharedPref.readNoteList();
    for(var i in list.toList()) {
      _noteList.add(Note.fromJson(i));
    }
    setState(() {});
  }

  void _saveNote() {
    _sharedPref.clear();
    _sharedPref.saveNoteList(_noteList);
  }

  @override
  Widget build(BuildContext context) {
    _noteList = _noteList.toSet().toList();
    return Scaffold(
      appBar: AppBar(title: const Text("Notes"),actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
      ]),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              SearchBar(
                leading: Icon(Icons.search),
                hintText: 'Search Notes...',
                elevation: MaterialStateProperty.all(2),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: _noteList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 3 / 2
                  ),
                  itemBuilder: (context, index) {
                    final note = _noteList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(note.title,style: TextStyle(fontSize: 20,color: Colors.white)),
                          const SizedBox(height: 4),
                          Text(note.desc,style: TextStyle(color: CupertinoColors.white),),
                          const SizedBox(height: 4),
                          Align(alignment:Alignment.bottomRight, child: Text(note.time,style: TextStyle(color: CupertinoColors.white)))
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddStudent(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  _showAddStudent(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Add new student'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              hintText: 'Title'
            ),
          ),
          const SizedBox(height: 20,),
          TextField(
            controller: _descController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                hintText: 'Content'
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(onPressed: () {
            setState(() {
              Navigator.of(context).pop();
              final currentTime = DateTime.now();
              final time = "${currentTime.day}-${currentTime.month}-${currentTime.year} | ${currentTime.hour}:${currentTime.minute}";
              _noteList.add(Note(title: _titleController.text, desc: _descController.text, time: time));
              _saveNote();
              _readNotes();
              print(_noteList);
            });
          }, icon: Icon(Icons.check), label: Text('Save'),)
        ],
      ),
    ));
  }
}
