import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_app/Model/userModel.dart';

class DbHelper{
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database? _db;

  Future<Database?> createDatabase() async{
    if(_db != null){
      return _db;
    }
    String path = join(await getDatabasesPath(),'bank.db');
    _db = await openDatabase(path,version: 5,onCreate: (Database db , int v ){
      db.execute('CREATE TABLE users(id INTEGER PRIMARY KEY , firstName TEXT , lastName TEXT , email TEXT , address TEXT , phoneNum TEXT , gender TEXT , imagePath TEXT , userMapLat REAL , userMapLong REAL)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error When Creating Table ${error.toString()}');
      });
    });
    return _db;
  }

  Future<int?> createUser(UserModel userModel) async{
    Database? db = await createDatabase();
   return await db!.insert('users', userModel.toMap());
    print("user added %%%%%%%%%%%%%%%%%%%%%%");
  }

  Future<List?> getAllUsers() async{
    Database? db = await createDatabase();
    return  db!.query('users');
  }


  Future<List<UserModel>> dogs() async {
    final db = await createDatabase();
    final List<Map<String, dynamic>> maps = await db!.query('users');
    return List.generate(maps.length, (i) {
      return UserModel(maps[i]);
    });
  }

 Future<int?> deleteUser(int userId) async{
    Database? db = await createDatabase();
    return await db!.delete('users',where:'id = ?',whereArgs: [userId]);
  }



  Future<int?> updateUser(UserModel userModel) async{
    Database? db = await createDatabase();
    return await db!.update('users',userModel.toMap(),where:'id = ?',whereArgs: [userModel.id]);
  }
}
// void _showToast(BuildContext context) {
//   final scaffold = ScaffoldMessenger.of(context);
//   scaffold.showSnackBar(
//     SnackBar(
//       content: const Text('User Added Sucessfully!'),
//       action: SnackBarAction(label: "OK", onPressed: scaffold.hideCurrentSnackBar),
//     ),
//   );
// }