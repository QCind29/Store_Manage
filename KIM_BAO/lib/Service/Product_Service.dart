import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../Database/SQLHelper.dart';
import '../Model/Product/Product.dart';

class Product_Service {
  static Future<int> createPD(String ten, int gia, String des, Uint8List img) async {
    final db = await SQLHelper.db();
    if (img != Uint8List(0) && img != null && img.isNotEmpty){
    try {
      final data = {'Ten': ten, 'Gia': gia, 'MoTa': des, 'Img': img};
      final id = await db.insert('Product', data,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return id;
    } on Exception catch (e) {
      print("Error: $e");
      return -1;
    }
    } else {
      try {
        final data = {'Ten': ten, 'Gia': gia, 'MoTa': des};
        final id = await db.insert('Product', data,
            conflictAlgorithm: ConflictAlgorithm.replace);
        print("line 27 PD_service added data:  " + data.toString());

        return id;
      } on Exception catch (e) {
        print("Error: $e");
        return -1;
      }
    }
  }

  // Return all DanhMuc in DanhMuc table
  static Future<List<Product>> getAllPD() async {
    final db = await SQLHelper.db();

    try {
      final data = db.query('Product', orderBy: "id");

      return data.then((listOfMaps) {
        return listOfMaps.map((map) => Product.fromMap(map)).toList();
      });
    } on Exception catch (e) {
      print("Error: $e");
    return <Product>[];
    }
  }

// Update a DanhMuc in DanhMuc table
  static Future<int> updatePD(
      int id, String name, String des, int cost, Uint8List img) async {
    final db = await SQLHelper.db();

    try {
      final data = {'Ten': name, 'MoTa': des, 'Gia': cost, 'Img': img};
      final result =
          await db.update('Product', data, where: "id=?", whereArgs: [id]);
      return result;
    } on Exception catch (e) {
      print("Error: $e");
      return -1;
    }
  }

  // Delete a Product in Product table
  static Future<void> deletePD(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('Product', where: "id=?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Đã có lỗi xảy ra, vui lòng thử lại: $err");
    }
  }

  static Future<int> createPD1(String ten, int gia, String des, Uint8List img) async {
    final db = await SQLHelper.db();

      try {
        final data = {'Ten': ten, 'Gia': gia, 'MoTa': des, 'Img': img};
        final id = await db.insert('Product', data,
            conflictAlgorithm: ConflictAlgorithm.replace);
        return id;
      } on Exception catch (e) {
        print("Error: $e");
        return -1;
      }
    }

  }


