import 'package:sqflite/sqflite.dart' as usingSql;
import 'package:path/path.dart' as usignPath;

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    //path for our database
    final dbPath = await usingSql.getDatabasesPath();
    //opening database if exist else create new one
    //join method will combine db path with our database called places.db
    final sqlDb = await usingSql.openDatabase(
      usignPath.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        // if we dont have database already it will create and that after we can exicute some code
        return db.execute(
          // here we can exicute sql querries
          // we creating new table in database
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT)',
        );
      },
      //used for overriding the existing data base
      // we using one database only so it will be 1 all the time
      version: 1,
    );

    //inserting data into the table
    sqlDb.insert(
      table,
      data,
      // if we trying to add data to existing id
      // then it will override
      conflictAlgorithm: usingSql.ConflictAlgorithm.replace,
    );
  }
}
