import 'package:flutter/cupertino.dart';

import '../../Model/Note/Note.dart';
import '../../Service/Note_Service.dart';


class NoteProvider extends ChangeNotifier {
  bool isLoading = true;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  // List<Map<String, dynamic>> _1notes = [];
  // List<Map<String, dynamic>> get 1notes => _1notes;

  NoteProvider() {
    getAll();
  }

  //get all note
  getAll() async {
    try {
      final newNote = await Note_Service.getAllN();
      _notes = newNote;
      isLoading = false;
      notifyListeners();
    } catch (error) {
      print("Error: $error");
      return -1;
    }
  }

  addNote(String tile, String content) {
    try {
      final newNote =
          Note(Ten: tile, NoiDung: content, Ngay: DateTime.now().toString());
      _notes.add(newNote);
      notifyListeners();
      Note_Service.createN(tile, content);
    } catch (error) {
      print("Error creating note: $error");
      return -1;
    }
  }

  List<Note> getFilteredNotes(String searchQuery) {
    return notes!
        .where((element) =>
            element.Ten!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            element.NoiDung!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  updateNote(Note note) {
    if (notes.isNotEmpty) {
      int indexofNote =
          notes!.indexOf(notes!.firstWhere((element) => element.id == note.id));
      if (indexofNote != -1) {
        notes![indexofNote] = note;

        Note_Service.createN(note.Ten, note.NoiDung);
        notifyListeners();
      } else {
        print('Note not found in the list.');
      }
    } else {
      print('Notes list is empty.');
    }
  }

  //Delete Note
  deleteNote(Note note) {
    if (notes.isNotEmpty) {
      int indexofNote =
          notes!.indexOf(notes!.firstWhere((element) => element.id == note.id));
      if (indexofNote != -1) {
        notes![indexofNote] = note;

        Note_Service.deleteN(note.id!);
        notifyListeners();
      } else {
        print('Note not found in the list.');
      }
    } else {
      print('Notes list is empty.');
    }
  }

  updateNote2(Note note1) {
    if (notes.isNotEmpty) {
      int indexofNote =
          notes.indexOf(notes.firstWhere((element) => element.id == note1.id));
      if (indexofNote != -1) {
        notes[indexofNote] = note1;
        Note_Service.updateN(note1.id!, note1.Ten, note1.NoiDung);
        notifyListeners();
      } else {
        print('Note not found in the list.');
      }
    } else {
      print('Notes list is empty.');
    }
  }
}
