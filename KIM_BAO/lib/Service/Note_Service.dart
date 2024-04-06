import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../Database/SQLHelper.dart';
import '../Model/Note/Note.dart';

class Note_Service {
  // Create a DanhMuc in DanhMuc table
  static Future<int> createN(String ten, String nd) async {
    DateTime date = DateTime.now();
    String ngay = date.toString();
    final db = await SQLHelper.db();
    final data = {'Ten': ten, 'NoiDung': nd, 'Ngay': ngay};
    final id = await db.insert('Note', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Note>> getAllN() async {
    final db = await SQLHelper.db();
    final data = db.query('Note', orderBy: "id");

    return data.then((listOfMaps) {
      return listOfMaps.map((map) => Note.fromMap(map)).toList();
    });
  } // Update a DanhMuc in DanhMuc table

  static Future<int> updateN(int id, String tt, String nd) async {
    final db = await SQLHelper.db();
    final data = {'Ten': tt, 'NoiDung': nd};
    final result =
        await db.update('Note', data, where: "id=?", whereArgs: [id]);
    return result;
  }

  // Delete a Note in Note table
  static Future<void> deleteN(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('Note', where: "id=?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Đã có lỗi xảy ra, vui lòng thử lại: $err");
    }
  }
}
