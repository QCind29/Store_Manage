import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import 'package:provider/provider.dart';

import '../../Model/Note/Note.dart';
import '../../Model/Product/Product.dart';
import '../../Provider/Note/NoteProvider.dart';
import '../../Provider/Note/ProductProvider.dart';
import '../../Util.dart';
import 'Product_Edit.dart';

class Product_Page extends StatefulWidget {
  const Product_Page({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product_Page> {
  List<Product>? lPD;
  String searchKey = "";

  void refresh() {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.getAllPD();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider pdProvider = Provider.of<ProductProvider>(context);
    final List<Product>? ListProduct = pdProvider.pd;
    final List<Product>? SListPD = pdProvider.getFilteredProduct(searchKey);

    // String dateNote = formattedDate(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sản phẩm",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        //   actions: [IconButton(onPressed: () {notesProvider.getAll();},
        //   icon: Icon(Icons.check),
        // )]
      ),
      body: (pdProvider.isLoading == false)
          ? SafeArea(
              child: (pdProvider.pd!.length > 0)
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
                            decoration: InputDecoration(hintText: "Tìm kiếm"),
                          ),
                        ),
                        (pdProvider.getFilteredProduct(searchKey).length > 0)
                            ? Expanded(child: ListPDUI(SListPD))
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
                  builder: (context) => const Product_Edit(
                        isUpdate: false,
                        note: null,
                      )));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
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

  Widget ListPDUI(List<Product>? a) {
    print(a);
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: a?.length,
      itemBuilder: (context, index) {
        Product currentNote = a![index];

        return GestureDetector(
          onTap: () {
            print('line 127 Product_Page' + a[index].Img.toString());
            Navigator.push(
                context,
                CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => Product_Edit(
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
            child: Row(
              children: [
                Expanded(

                    flex: 1,
                    child: a![index].Img.isNotEmpty ?

                    Image.memory(a![index].Img) : Icon(Icons.image_not_supported_outlined) ),


                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                            menhgia(a[index].Gia).toString() + " đ",
                            maxLines: 2,
                            style:
                                TextStyle(fontSize: 20, color: Colors.black54),
                          ),
                        ),
                        Container(
                          // alignment: Alignment.bottomRight,
                          child: Text(
                            a[index].MoTa,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAlertDialog(BuildContext context, Product pd) {
    ProductProvider notesProvider =
        Provider.of<ProductProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Are you want to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                notesProvider.deletePD(pd);
                refresh();
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
