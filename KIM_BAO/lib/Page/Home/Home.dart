import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../Model/Note/Note.dart';
import '../../Provider/Note/NoteProvider.dart';
import 'Edit_Note.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note>? tnote;
  String searchKey = "";
  void refresh(){
    final provider = Provider.of<NoteProvider>(context, listen: false);
    provider.getAll();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  refresh();
  }

  @override
  Widget build(BuildContext context) {

    NoteProvider notesProvider = Provider.of<NoteProvider>(context);
    final List<Note>? ListNote = notesProvider.notes;
    final List<Note>? SListNote = notesProvider.getFilteredNotes(searchKey);

    // String dateNote = formattedDate(DateTime.now());

    print(notesProvider.isLoading);

    print(SListNote!.length);

    print("line 41: " + ListNote.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ghi chú", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        //   actions: [IconButton(onPressed: () {notesProvider.getAll();},
        //   icon: Icon(Icons.check),
        // )]
      ),
      body: (notesProvider.isLoading == false)
          ? SafeArea(
              child: (notesProvider.notes!.length > 0)
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (val) {
                              setState(() {
                                searchKey = val;
                              });
                            },
                            decoration: InputDecoration(hintText: "Search"),
                          ),
                        ),
                        (notesProvider.getFilteredNotes(searchKey).length > 0)
                            ? Expanded(child: ListNoteUI(SListNote))
                            : const Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  "No notes found!",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ],
                    )
                  : EmptyUI())
          : LoadingUI(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => Addnewnote(
                        isUpdate: false,
                        note: null,
                      )));
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  Widget LoadingUI() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget EmptyUI() {
    return const Center(
      child: Text("List is empty!"),
    );
  }

  Widget ListNoteUI(List<Note>? a) {

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: a?.length,
      itemBuilder: (context, index) {
        Note currentNote = a![index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => Addnewnote(
                          note: currentNote,
                          isUpdate: true,
                        )));
            // Navigator.push(context, CupertinoPageRoute(builder: (context) => Test()));
          },
          onLongPress: () {
            _showAlertDialog(context, currentNote);
          },
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a![index].Ten!,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(
                    a[index].NoiDung,
                    maxLines: 2,
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child:
                   Text(a[index].Ngay.toString()),
                  // Text(formattedDate(a[index].dateadded)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAlertDialog(BuildContext context, Note note) {
    NoteProvider notesProvider =
        Provider.of<NoteProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Are you want to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                notesProvider.deleteNote(note);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
