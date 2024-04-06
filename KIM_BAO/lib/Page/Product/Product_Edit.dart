import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/Note/Note.dart';
import '../../Model/Product/Product.dart';
import '../../Provider/Note/NoteProvider.dart';
import '../../Provider/Note/ProductProvider.dart';
import '../../Util.dart';

class Product_Edit extends StatefulWidget {
  final bool isUpdate;
  final Product? note;
  const Product_Edit({Key? key, required this.isUpdate, this.note})
      : super(key: key);

  @override
  State<Product_Edit> createState() => _ProductEditState();
}

class _ProductEditState extends State<Product_Edit> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController costController = TextEditingController();

  // late String imgURL;
  FocusNode focusNode = FocusNode();

  String Title = "Tạo mới ghi chú";

  // File _imageFile = File('');
  // Uint8List nd = Uint8List(0);
  File? _imageFile1;

  bool a = false;

  Future<void> _getImage(bool camera) async {
    final imagePicker = ImagePicker();
    if (camera == false) {
      try {
        final pickedFile =
            await imagePicker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _imageFile1 = File(pickedFile.path);
          });
        }
      } on Exception catch (e) {
        print(e);
      }
    } else {
      try {
        final pickedFile =
            await imagePicker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          setState(() {
            _imageFile1 = File(pickedFile.path);
          });
        }
      } on Exception catch (e) {
        print(e);
      }
    }

    print('line 51' + _imageFile1.toString());
  }

  addNote(File? d) async {
    String t = titleController.text;
    int c = int.parse(costController.text);
    String ndung;
    String value = contentController.text;

    if (value != null && value.isNotEmpty) {
      ndung = value;
    } else {
      ndung = " ";
    }
    Provider.of<ProductProvider>(context, listen: false).addPD(t, ndung, c, d);
    Navigator.pop(context);

    print("line 51: $titleController");
  }

  updatePD() async {
    widget.note!.Ten = titleController.text;
    widget.note!.MoTa = contentController.text;
    widget.note!.Gia = int.parse(costController.text);
    widget.note!.Img = await getImageBytes(_imageFile1);

    Provider.of<ProductProvider>(context, listen: false).updatePD(widget.note!);
    Navigator.pop(context);
  }

  checkUD() async {
    File? image2;

    titleController.text = widget.note!.Ten!;
    contentController.text = widget.note!.MoTa!;
    costController.text = widget.note!.Gia.toString();

    if (widget.note!.Img != Uint8List(0) && widget.note!.Img != null ) {

      image2 = await getImageFile(widget.note!.Img);
      if(await image2.exists()){
        setState(() {
          _imageFile1 = image2;
        });
      }

    }

    Title = "Chỉnh sửa sản phẩm";
    print("Line 112 Product_Edit page :" + _imageFile1.toString());
  }

  @override
  void initState() {
    super.initState();
    // _initializeCamera();

    if (widget.isUpdate) {
      checkUD();
    }
    print('line 89  PD_EDit page' + _imageFile1.toString());
  }

  @override
  Widget build(BuildContext context) {
    // NoteProvider notesProvider = Provider.of<NoteProvider>(context);

    final List<Note>? tl = NoteProvider().notes;

    bool isUpdating = widget.isUpdate;

    print(Title + "0" + isUpdating.toString());
    print("line 62 " + tl.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(Title,
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () {
              if (widget.isUpdate) {
                updatePD();
                int? a = widget.note?.id;
              } else {
                addNote(_imageFile1);
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Container(
                      child:
                          // _imageFile.toString() == 'File: '''
                          _imageFile1 == null
                              ? Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Add rounded corners
                                  ),
                                  width: 300,
                                  height: 200,
                                  child:  Center(
                                    // Wrap the Column with a Center widget
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center, // Center align the children vertically
                                      children: [
                                        Icon(Icons.image),
                                        Text('Không tìm thấy hình ảnh.')
                                      ],
                                    ),
                                  ),
                                )
                              : Image.file(
                                  _imageFile1!,
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      // Expanded(flex: 1, child: Text(" ")),
                      Expanded(
                        flex: 1,
                        child: Text(""),
                      ),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {
                            _getImage(true);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueAccent,
                            minimumSize:
                                Size(200, 50), // Set minimum width and height
                          ),
                          // Text color
                          child: const Text('Camera'),
                        ),
                      ),
                      Expanded(flex: 1, child: Text(" ")),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {
                            _getImage(false);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueAccent,
                            minimumSize:
                                Size(200, 50), // Set minimum width and height
                          ), // Text color
                          child: const Text('Thư viện'),
                        ),
                      ),
                      Expanded(flex: 1, child: Text(" ")),
                    ],
                  ),
                )
              ],
            ),
            Container(
                margin: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          child: const Text("Tên: ",
                              textAlign:
                                  TextAlign.center, // Center-align the text

                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold
                                  // ),
                                  ))),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: TextFormField(
                          controller: titleController,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          // decoration: const InputDecoration(
                          //   // hintText: "Tên sản phẩm",
                          // ),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          child: const Text("Giá: ",
                              textAlign:
                                  TextAlign.center, // Center-align the text

                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold
                                  // ),
                                  ))),
                    ),
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        controller: costController,
                        // focusNode: focusNode,
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),

                        // decoration: const InputDecoration(
                        //     hintText: "Giá", border: InputBorder.none),
                      ),
                    ),
                  ],
                )),
            Container(
                height: 200,
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius:
                      BorderRadius.circular(10.0), // Add rounded corners

                  // Add border
                ),
                child: TextFormField(
                  controller: contentController,
                  // focusNode: focusNode,
                  maxLines: null,

                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),

                  decoration: const InputDecoration(
                      hintText: "Mô tả", border: InputBorder.none),
                ))
          ]),
    );
  }
}
