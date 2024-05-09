import 'package:flutter/material.dart';
import 'package:notepad_mobile/model/Notes.dart';

class NoteDetails extends StatefulWidget {
  final int noteID;
  const NoteDetails({super.key, required this.noteID});

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  void removeNote() {
    Notes.removeAt(widget.noteID);
    Navigator.pop(context);
  }

  void updateNoteTitle(String title, String content) {
    setState(() {
      Notes.updateNote(widget.noteID, title, content);
      Navigator.pop(context);
    });
  }

  void triggerUpdateNote(Note note, String content) {
    TextEditingController titleController =
        TextEditingController(text: note.title);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Note Title",
          style: TextStyle(
            fontFamily: "Kumbh Sans",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xffFFC700),
        content: TextField(
          controller: titleController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () => updateNoteTitle(titleController.text, content),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xffFFF279),
              ),
            ),
            child: const Text(
              "Update",
              style: TextStyle(
                fontFamily: "Kumbh Sans",
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Note note = Notes.getNotesByIndex(widget.noteID);
    TextEditingController noteController =
        TextEditingController(text: note.content);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => triggerUpdateNote(note, noteController.text),
          child: Text(
            note.title,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "Kumbh Sans",
              fontWeight: FontWeight.bold,
            ),
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
            Notes.updateNote(widget.noteID, note.title, noteController.text);
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
