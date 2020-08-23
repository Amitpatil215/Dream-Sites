import 'package:sqflite/sqflite.dart' as usingSql;
import 'package:path/path.dart' as usignPath;

class DBHelper {
  // creating or opening databse and returning it
  static Future<usingSql.Database> dataBase() async {
    //path for our database
    final dbPath = await usingSql.getDatabasesPath();
    //opening database if exist else create new one
    //join method will combine db path with our database called places.db
    return usingSql.openDatabase(
      usignPath.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        // if we dont have database already it will create and that after we can exicute some code
        return db.execute(
          // here we can exicute sql querries
          // we creating new table in database
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,loc_lat Real,loc_lng Real,address TEXT)',
        );
      },
      //used for overriding the existing data base
      // we using one database only so it will be 1 all the time
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    //getting database
    final db = await DBHelper.dataBase();
    //inserting data into the table
    db.insert(
      table,
      data,
      // if we trying to add data to existing id
      // then it will override
      conflictAlgorithm: usingSql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    //getting database
    final db = await DBHelper.dataBase();
    //getting data from table using query method
    // we get map
    return db.query(table);
  }
}
