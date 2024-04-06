import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';

import '../../Model/Note/Note.dart';
import '../../Provider/Note/NoteProvider.dart';

class Addnewnote extends StatefulWidget {
  final bool isUpdate;
  final Note? note;

  const Addnewnote({Key? key, required this.isUpdate, this.note})
      : super(key: key);

  @override
  State<Addnewnote> createState() => _AddnewnoteState();
}

class _AddnewnoteState extends State<Addnewnote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FocusNode focusNode = FocusNode();

  String Title = "Tạo mới ghi chú";

  addNote() async {
    String t = titleController.text;
    String nd = contentController.text;
    Provider.of<NoteProvider>(context, listen: false).addNote(t, nd);
    Navigator.pop(context);

    print("line 51: $titleController");
  }

  updateNote() async {
    widget.note!.Ten = titleController.text;
    widget.note!.NoiDung = contentController.text;

    Provider.of<NoteProvider>(context, listen: false).updateNote2(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    if (widget.isUpdate) {
      titleController.text = widget.note!.Ten!;
      contentController.text = widget.note!.NoiDung;
      Title = "Chỉnh sửa ghi chú";
    }

  }

  @override
  Widget build(BuildContext context) {
    // NoteProvider notesProvider = Provider.of<NoteProvider>(context);

    final List<Note>? tl = NoteProvider().notes;

    bool isUpdating = widget.isUpdate;

    print(Title + "0" + isUpdating.toString());
    print("line 62 " + tl.toString());

    return
      MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (context) => NoteProvider(),
          builder: (context, child) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(Title),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        if (widget.isUpdate) {
                          updateNote();
                          int? a = widget.note?.id ;
                          print("line 74  $a " );
                        } else {
                          addNote();
                        }
                      },
                      icon: const Icon(Icons.check),
                    ),
                  ],
                ),
                body: SafeArea(
                    child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(children: [
                    Container(
                        child: TextFormField(
                      controller: titleController,
                      autofocus: true,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        hintText: "Tên ghi chú",
                      ),
                    )),
                    Expanded(
                        child: TextFormField(
                      controller: contentController,
                      focusNode: focusNode,
                      maxLines: null,
                      decoration: const InputDecoration(
                          hintText: "Nội dung", border: InputBorder.none),
                    ))
                  ]),
                )));
          })
    ]);
    //   Scaffold(
    //     appBar: AppBar(
    //       title: Text(Title),
    //       centerTitle: true,
    //       actions: [
    //         IconButton(
    //           onPressed: () {
    //             if (widget.isUpdate) {
    //               updateNote();
    //             } else {
    //               addNote();
    //             }
    //           },
    //           icon: const Icon(Icons.check),
    //         ),
    //       ],
    //     ),
    //     body: SafeArea(
    //         child: Container(
    //           margin: const EdgeInsets.all(15),
    //           child: Column(children: [
    //             Container(
    //                 child: TextFormField(
    //                   controller: titleController,
    //                   autofocus: true,
    //                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    //                   decoration: const InputDecoration(
    //                     hintText: "Title",
    //                   ),
    //                 )),
    //             Expanded(
    //                 child: TextFormField(
    //                   controller: contentController,
    //                   focusNode: focusNode,
    //                   maxLines: null,
    //                   decoration: const InputDecoration(
    //                       hintText: "Content", border: InputBorder.none),
    //                 ))
    //           ]),
    //         ))
    // );
  }
}
