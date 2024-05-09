import 'dart:convert';
import 'package:hive/hive.dart';

class Note {
  String title;
  String content;

  Note(this.title, this.content);

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(json["title"] as String, json["content"] as String);
  }

  String toJson() {
    return jsonEncode({"title": title, "content": content});
  }
}

class NotesDB {
  var box = Hive.box("notes");
  List<Note> notes = [];

  void arrayToDB() {
    List<String> jsons = [];
    for (int i = 0; i < notes.length; i++) {
      jsons.add(notes[i].toJson());
    }

    box.put("notes", jsons);
  }

  void dbToArray() {
    notes.clear();
    List<String> jsons = box.get("notes") ?? [];
    for (int i = 0; i < jsons.length; i++) {
      notes.add(Note.fromJson(jsonDecode(jsons[i])));
    }
  }

  List<Note> getNotes() {
    dbToArray();
    return notes;
  }

  void addNote(Note note) {
    notes.add(note);
    arrayToDB();
  }

  Note getNotesByIndex(int idx) {
    return notes[idx];
  }

  void removeAt(int idx) {
    notes.removeAt(idx);
    arrayToDB();
  }

  void updateNote(int idx, String title, String content) {
    notes[idx].title = title;
    notes[idx].content = content;
    arrayToDB();
  }
}

class Notes {
  static NotesDB db = NotesDB();

  static List<Note> getNotes() {
    return db.getNotes();
  }

  static void addNote(String title) {
    db.addNote(Note(title, ""));
  }

  static Note getNotesByIndex(int idx) {
    return db.getNotesByIndex(idx);
  }

  static void removeAt(int idx) {
    db.removeAt(idx);
  }

  static void updateNote(int idx, String title, String content) {
    db.updateNote(idx, title, content);
  }
}
