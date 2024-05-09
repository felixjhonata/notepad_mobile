import 'package:flutter/material.dart';
import 'package:notepad_mobile/NoteDetails.dart';
import 'package:notepad_mobile/model/Notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  List<Note> notes = [];

  void toNoteDetails(int num) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetails(
          noteID: num,
        ),
      ),
    ).then((value) => setState(() {}));
  }

  void createNewNote() {
    Notes.addNote(titleController.text);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetails(noteID: notes.length - 1),
      ),
    );
  }

  void triggerNewNoteDialog() {
    titleController.text = "";
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
            onPressed: () => createNewNote(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xffFFF279),
              ),
            ),
            child: const Text(
              "Create",
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
    notes = Notes.getNotes();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: const Color(0xffFFF279),
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => toNoteDetails(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffFFA800),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 160,
                            child: Text(
                              notes[index].title,
                              style: const TextStyle(
                                fontFamily: "Kumbh Sans",
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                setState(() => Notes.removeAt(index)),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: IconButton(
        color: Colors.black,
        icon: const Icon(Icons.add),
        iconSize: 50,
        onPressed: () => triggerNewNoteDialog(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xffFFC700)),
        ),
      ),
    );
  }
}
