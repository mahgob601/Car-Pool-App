import 'package:car_pool1/Globals/global_var.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class LocalDatabaseClass {
  Database? mydb;
  //used in profile
  Future<Database?> mydbcheck() async {
    if (mydb == null) {
      mydb = await initiatingDatabase();
      return mydb;
    } else
      return mydb;
  }

  int Version = 1;
  Future<Database?> initiatingDatabase() async {
    String destinationPath = await getDatabasesPath();
    String Path = join(destinationPath, "USERPROJECTDB");
    Database mydatabase = await openDatabase(
      Path,
      version: Version,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE IF NOT EXISTS users (
            id TEXT PRIMARY KEY,
            name TEXT,
            email TEXT,
            phone TEXT
          )
        ''');
      },
    );
    return mydatabase;
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database? temp = await mydbcheck();
    var response = await temp!.rawQuery('SELECT * FROM users');
    return response;
  }

  //used in profile
  Future<void> printTableContents() async {
    // Print the contents of the users table
    List<Map<String, dynamic>> drivers = await getUsers();

    drivers.forEach((user) {
      print('from local Database users ID: ${user['id']}, Name: ${user['name']}, Email: ${user['email']}, Phone: ${user['phone']}');
    });
  }

  //used in profile
  Future<List<Map<String, dynamic>>> getSpecificUser(String uid) async {
    Database? temp = await mydbcheck();
    var response = await temp!.rawQuery('''
      SELECT * FROM users WHERE id = ?
    ''', [uid]);
    return response;
  }

  Future<void> InsertOrUpdateUser(String uid, String username,String mobile) async {
    Database? temp = await mydbcheck();
    if(uid!='TESTUSER'){
      var response = await temp!.rawInsert('''
      INSERT OR REPLACE INTO users (id, name, phone)
      VALUES (?, ?, ?)
    ''', [userID, username, mobile]);
      // Print table contents after updating
      await printTableContents();
    }
    else{
      var response = await temp!.rawInsert('''
      INSERT OR REPLACE INTO users (id, name, phone)
      VALUES (?, ?, ?)
    ''', ["TESTDRIVER", username, mobile]);
      // Print table contents after updating
      await printTableContents();
    }
  }

}