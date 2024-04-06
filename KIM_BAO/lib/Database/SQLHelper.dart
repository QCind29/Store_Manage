import 'package:flutter/cupertino.dart';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""Create table Product(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Ten TEXT,
    Gia INTEGER,
    MoTa TEXT,
    Img BLOB
    
    )""");
    await database.execute("""Create table Note(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Ten TEXT,
    NoiDung TEXT,
    Ngay TEXT
   
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'PHBL2.db',
      version: 3,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }



//   // Create a DanhMuc in DanhMuc table
//   static Future<int> createPD(
//       String ten, int gia, String des, String? img) async {
//     final db = await SQLHelper.db();
//     final data = {'Ten': ten, 'Gia': gia, 'Mota': des, 'Img': img};
//     final id = await db.insert('Product', data,
//         conflictAlgorithm: ConflictAlgorithm.replace);
//     return id;
//   }
//
//   // Create a DanhMuc in DanhMuc table
//   static Future<int> createN(String ten, String nd) async {
//     DateTime date = DateTime.now();
//     String ngay = date.toString();
//     final db = await SQLHelper.db();
//     final data = {'Ten': ten, 'NoiDung': nd, 'Ngay': ngay};
//     final id = await db.insert('Note', data,
//         conflictAlgorithm: ConflictAlgorithm.replace);
//     return id;
//   }
//
// // Return all DanhMuc in DanhMuc table
//   static Future<List<Product>> getAllPD() async {
//     final db = await SQLHelper.db();
//     final data = db.query('Product', orderBy: "id");
//
//     return data.then((listOfMaps) {
//       return listOfMaps.map((map) => Product.fromMap(map)).toList();
//     });
//   }
//
// // Return all DanhMuc in DanhMuc table
//   static Future<List<Note>> getAllN() async {
//     final db = await SQLHelper.db();
//     final data = db.query('Note', orderBy: "id");
//
//     return data.then((listOfMaps) {
//       return listOfMaps.map((map) => Note.fromMap(map)).toList();
//     });
//   }
//
// // Update a DanhMuc in DanhMuc table
//   static Future<int> updateN(int id, String tt, String nd) async {
//     final db = await SQLHelper.db();
//     final data = {'Ten': tt, 'NoiDung': nd};
//     final result =
//         await db.update('Note', data, where: "id=?", whereArgs: [id]);
//     return result;
//   }
//
//
//
//   // Delete a Note in Note table
//   static Future<void> deleteN(int id) async{
//     final db = await SQLHelper.db();
//     try{
//       await db.delete('Note',where: "id=?",whereArgs: [id]);
//     }catch(err){
//       debugPrint("Đã có lỗi xảy ra, vui lòng thử lại: $err");
//     }
//   }
// // Delete a Product in Product table
//   static Future<void> deletePD(int id) async{
//     final db = await SQLHelper.db();
//     try{
//       await db.delete('Product',where: "id=?",whereArgs: [id]);
//     }catch(err){
//       debugPrint("Đã có lỗi xảy ra, vui lòng thử lại: $err");
//     }
//   }

//   // Create a CauHinh in CauHinh table
//   static Future<int> createCH( String url, String username, String password,
//       String acaccount, String acpass, String pattern, String serial) async {
//     final db = await SQLHelper.db();
//     final data = {'Url': url, 'Username': username, 'Password': password, 'Acaccount': acaccount,
//       'Acpass': acpass, 'Pattern': pattern, 'Serial': serial};
//     final id = await db.insert('CauHinh', data,
//         conflictAlgorithm: ConflictAlgorithm.replace);
//     return id;
//   }

// // Return all DanhMuc in DanhMuc table
//   static Future<List<Map<String, dynamic>>> getAllDM() async {
//     final db = await SQLHelper.db();
//     return db.query('DanhMuc', orderBy: "id");
//   }
//   // Return all CauHinh in CauHinh table
//   static Future<List<Map<String, dynamic>>> getAllCH() async {
//     final db = await SQLHelper.db();
//     return db.query('CauHinh', orderBy: "id");
//   }

// // Return a DanhMuc in DanhMuc table by id
//   static Future<Map<String, Object?>?> getDM(int id) async {
//     final db = await SQLHelper.db();
//     final res = await db.query('DanhMuc', where: "id=?", whereArgs: [id]);
//     if (res.isNotEmpty) return res.first;
//     return null;
//   }
//   // Return a CauHinh in CauHinh table by id
//   static Future<Map<String, Object?>?> getCH(int id) async {
//     final db = await SQLHelper.db();
//     final res = await db.query('CauHinh', where: "id=?", whereArgs: [id]);
//     if (res.isNotEmpty) return res.first;
//     return null;
//   }

// // Update a DanhMuc in DanhMuc table
//   static Future<int> updateDM(int id, int mg, String nd) async {
//     final db = await SQLHelper.db();
//     final data = {'MenhGia': mg, 'NoiDung': nd};
//     final result =
//         await db.update('DanhMuc', data, where: "id=?", whereArgs: [id]);
//     return result;
//   }
//   // Update a CauHinh in CauHinh talbe
//   static Future<int> updateCH(int id, String url, String username, String password,
//       String acaccount, String acpass, String pattern, String serial) async {
//     final db = await SQLHelper.db();
//     final data = {'Url': url, 'Username': username, 'Password': password, 'Acaccount': acaccount,
//     'Acpass': acpass, 'Pattern': pattern, 'Serial': serial};
//     final result =
//     await db.update('CauHinh', data, where: "id=?", whereArgs: [id]);
//     return result;
//   }

//   // Delete a DanhMuc in DanhMuc table
//   static Future<void> deleteDM(int id) async{
//     final db = await SQLHelper.db();
//     try{
//       await db.delete('DanhMuc',where: "id=?",whereArgs: [id]);
//     }catch(err){
//       debugPrint("Đã có lỗi xảy ra, vui lòng thử lại: $err");
//     }
//   }
//   // Delete a CauHinh in CauHinh table
//   static Future<void> deleteCH(int id) async{
//     final db = await SQLHelper.db();
//     try{
//       await db.delete('CauHinh',where: "id=?",whereArgs: [id]);
//     }catch(err){
//       debugPrint("Đã có lỗi xảy ra, vui lòng thử lại: $err");
//     }
//   }

  // static List<Note> convertToList(Future< List<Map<String, Object?>>> maps) {
  //   return maps.((map) => Note.fromMap(map)).toList();
  // }
}
