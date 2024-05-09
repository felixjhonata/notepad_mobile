import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notepad_mobile/model/Notes.dart';

class NoteDetails extends StatelessWidget {
  final int noteID;
  const NoteDetails({super.key, required this.noteID});

  @override
  Widget build(BuildContext context) {
    Note note = Notes.getNotesByIndex(noteID);
    TextEditingController noteController =
        TextEditingController(text: note.content);

    void removeNote() {
      Notes.removeAt(noteID);
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          note.title,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "Kumbh Sans",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xffFFA800),
        actions: [
          IconButton(
            onPressed: removeNote,
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Notes.updateNote(noteID, note.title, noteController.text);
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: TextField(
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "Kumbh Sans",
                fontWeight: FontWeight.normal,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              maxLines: null,
              controller: noteController,
            ),
          ),
        ],
      ),
    );
  }
}
