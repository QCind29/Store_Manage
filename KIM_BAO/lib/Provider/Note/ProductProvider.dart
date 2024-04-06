import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../Model/Product/Product.dart';
import '../../Service/Product_Service.dart';
import '../../Util.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _pd = [];
  List<Product> get pd => _pd;
  bool isLoading = true;

  ProductProvider() {
    getAllPD();
  }

  getAllPD() async {
    try {
      final newPD = await Product_Service.getAllPD();
      _pd = newPD;
      isLoading= false;
      notifyListeners();
    } catch (e) {
      print("Error, $e");
      return -1;
    }
  }

  addPD(String name, String des, int price, File? imagePath) async {
    try {
      Uint8List img = await getImageBytes(imagePath);
      final newPD = Product(Ten: name, Gia: price, Img: img, MoTa: des);
      _pd.add(newPD);
      Product_Service.createPD1(name, price, des, img);
      notifyListeners();
    } catch (e) {
      print("Error: $e");
      return -1;

    }
  }

  List<Product> getFilteredProduct(String searchQuery) {
    return pd!
        .where((element) =>
    element.Ten!.toLowerCase().contains(searchQuery.toLowerCase()) ||
        element.MoTa!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  updatePD(Product note1) {
    if (pd.isNotEmpty) {
      int indexofNote =
      pd.indexOf(pd.firstWhere((element) => element.id == note1.id));
      if (indexofNote != -1) {
        pd[indexofNote] = note1;
        Product_Service.updatePD(note1.id!, note1.Ten, note1.MoTa, note1.Gia, note1.Img);
        notifyListeners();
      } else {
        print('Note not found in the list.');
      }
    } else {
      print('Notes list is empty.');
    }
  }
  deletePD(Product note) {
    if (pd.isNotEmpty) {
      int indexofNote =
      pd!.indexOf(pd!.firstWhere((element) => element.id == note.id));
      if (indexofNote != -1) {
        pd![indexofNote] = note;

        Product_Service.deletePD(note.id!);
        notifyListeners();
      } else {
        print('Product not found in the list.');
      }
    } else {
      print('Product list is empty.');
    }
  }

}
