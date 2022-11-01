import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_flutter_demo/models/product.dart';

class DbHelper {
  Database? _db;

  Future<Database?> get db async {
    _db = await initializeDb();
    return _db;
  }

  Future<Database?> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "e_trade2.db");
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
         "Create table products(id INTEGER PRIMARY KEY,name text,description text, unitPrice decimal)");
  }

  Future<List<Product>> getProducts() async{
    Database? db = await this.db;

    var results = await db?.query("products");
    return List.generate(results!.length, (i){
          return Product.fromObject(results[i]);
            });
  }

  Future<int?> insert(Product product) async{
    Database? db = await this.db;
    var results = await db!.insert("products", product.toMap());
  }

  Future<int?> delete(int id) async{
    Database? db = await this.db;
    var results = await db!.delete("products", where: "id=?", whereArgs: [id]);
    return results;
  }

  Future<int?> update(Product product) async{
    Database? db = await this.db;
    var results = await db!.update("products", product.toMap(), where: "id = ?",whereArgs: [product.id]);
    return results;
  }

}

