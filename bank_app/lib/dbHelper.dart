import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './model/customer.dart';

class DBHelper {
  static Database _db;
  static var adminId;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }
 
  initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'bankCustomer.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
 
  _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE customerTable (id INTEGER PRIMARY KEY, name TEXT, balance REAL)');
        Customer cust = new Customer(name : 'Saloni Swagata', balance: 10000000.00);
        adminId = await db.insert('customerTable', cust.toMap());
  }
 
  Future<Customer> insertCustomer(Customer customer) async {
    var dbClient = await db;
    customer.id = await dbClient.insert('customerTable', customer.toMap());
    return customer;
  }
 
  Future<List<Customer>> getCustomer() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('customerTable', columns: ['id', 'name','balance']);
    List<Customer> customer = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        customer.add(Customer.fromMap(maps[i]));
      }
    }
    return customer;
  }
 
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'customerTable',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
 
  Future<int> update(Customer customer) async {
    var dbClient = await db;
    return await dbClient.update(
      'customerTable',
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }
 
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}