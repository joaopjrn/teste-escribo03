import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'sw.db'),
    onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE `favoritos` (
          `_id` VARCHAR(50) NOT NULL,
          `tipo` VARCHAR(255) NOT NULL,
          PRIMARY KEY (`_id`)
        );
        CREATE TABLE `avatar` (
          `topType` INT NOT NULL,
          `accessoriesType` INT NOT NULL,
          `hairColor` INT NOT NULL,
          `facialHairType` INT NOT NULL,
          `facialHairColor` INT NOT NULL,
          `clotheType` INT NOT NULL,
          `eyeType` INT NOT NULL,
          `eyebrowType` INT NOT NULL,
          `mouthType` INT NOT NULL,
          `skinColor` INT NOT NULL,
          `clotheColor` INT NOT NULL,
          `style` INT NOT NULL,
          `graphicType` INT NOT NULL
        );
      ''');
      }, version: 1);
  }

  static Future<int> insert(String tabela, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    return db.insert(tabela, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<int> delete(String tabela, String id) async {
    final db = await DBHelper.database();
    return db.delete(
      tabela,
      where: '_id = ?',
      whereArgs: [id]
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String tabela) async {
    final db = await DBHelper.database();
    return db.query(tabela);
  }

  static Future<bool> findFav(String tabela, String id) async {
    final db = await DBHelper.database();
    final q = await db.query(
      tabela, 
      where: '_id = ?',
      whereArgs: [id]);

      return q.isNotEmpty;
  }

  static Future<int> toggleFav(bool isFav, Map<String, dynamic> item) async {
    if(isFav){
      return DBHelper.delete('favoritos', item['_id'].toString());
    }else{
      return DBHelper.insert('favoritos', item);
    }
  }

}