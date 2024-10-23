// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteService {
  static final SQLiteService _instance = SQLiteService._internal();
  late Database _db;

  factory SQLiteService() {
    return _instance;
  }

  SQLiteService._internal();
  Future<SQLiteService> init() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'emprestapro.db');

      _db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await createTables(db);
      });

      log('Database initialized');
      return this;
    } catch (e) {
      log('SQLiteService - init - Error: $e');
      throw ('SQLiteService - init - Error: $e');
    }
  }

  Future<void> insert({
    required String table,
    required Map<String, dynamic> params,
  }) async {
    try {
      await _db.insert(table, params);
    } catch (e) {
      log('SQLiteService - insert - Error: $e');
    }
  }

  Future<void> update({
    required String table,
    required String uid,
    required Map<String, dynamic> params,
  }) async {
    try {
      await _db.update(table, params, where: 'uid = ?', whereArgs: [uid]);
    } catch (e) {
      log('SQLiteService - update - Error: $e');
    }
  }

  Future<Map<String, dynamic>> get({
    required String table,
    required String uid,
  }) async {
    try {
      final result = await _db.query(table, where: 'uid = ?', whereArgs: [uid]);
      log('SQLiteService - get - result: $result');
      return result.isNotEmpty ? result.first : {};
    } catch (e) {
      throw ('SQLiteService - get - Error: $e');
    }
  }

  Future<void> delete({
    required String table,
    required String uid,
  }) async {
    try {
      await _db.delete(table, where: 'uid = ?', whereArgs: [uid]);
      log('SQLiteService - delete - result: deleted');
    } catch (e) {
      throw ('SQLiteService - delete - Error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getByField({
    required String table,
    required String fieldName,
    required String value,
  }) async {
    try {
      final result =
          await _db.query(table, where: '$fieldName = ?', whereArgs: [value]);
      log('SQLiteService - getByField - result: $result');
      return result;
    } catch (e) {
      log('SQLiteService - getByField - Error: $e');
      throw ('SQLiteService - getByField - Error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> deleteByField({
    required String table,
    required String fieldName,
    required String value,
  }) async {
    try {
      final result =
          await _db.query(table, where: '$fieldName = ?', whereArgs: [value]);

      for (var row in result) {
        await _db.delete(table, where: '$fieldName = ?', whereArgs: [value]);
      }

      log('SQLiteService - deleteByField - result: $result');
      return result;
    } catch (e) {
      log('SQLiteService - deleteByField - Error: $e');
      throw ('SQLiteService - deleteByField - Error: $e');
    }
  }

  Future<void> createTables(Database db) async {
    log('CREATED TABLE users');

    await db.execute('''
          CREATE TABLE users (
            uid TEXT PRIMARY KEY,
            displayName TEXT,
            email TEXT,
            phoneNumber TEXT,
            photoUrl TEXT,
            creationTime TEXT,
            updateTime TEXT,
            lastSignInTime TEXT,
            userType TEXT,
            active INTEGER DEFAULT 1,
            emailVerified INTEGER
          );
        ''');

    log('CREATED TABLE transactions');

    await db.execute('''
          CREATE TABLE transactions (
            uid TEXT PRIMARY KEY,
            consumerId TEXT,
            creditorId TEXT,
            loanId TEXT,
            amount REAL,
            transactionTime TEXT,
            creationTime TEXT,
            updateTime TEXT
          );
        ''');

    log('CREATED TABLE loans');

    await db.execute('''
          CREATE TABLE loans (
            uid TEXT PRIMARY KEY,
            consumerId TEXT,
            creditorId TEXT,
            amount REAL,
            fees REAL,
            dueDate TEXT,
            creationTime TEXT,
            updateTime TEXT,
            concluded INTEGER
          );
        ''');

    log('CREATED TABLE creditors');

    await db.execute('''
          CREATE TABLE creditors (
            uid TEXT PRIMARY KEY,
            userId TEXT,
            name TEXT,
            pix TEXT,
            phone TEXT,
            imageUrl TEXT,
            email TEXT,
            message TEXT,
            creationTime TEXT,
            updateTime TEXT,
            loanIds TEXT,
            active INTEGER
          );
        ''');

    log('CREATED TABLE consumers');

    await db.execute('''
          CREATE TABLE consumers (
            uid TEXT PRIMARY KEY,
            creditorId TEXT,
            name TEXT,
            pix TEXT,
            phone TEXT,
            imageUrl TEXT,
            email TEXT,
            creationTime TEXT,
            updateTime TEXT,
            active INTEGER,
            country TEXT,
            state TEXT,
            city TEXT,
            street TEXT,
            number TEXT,
            zipCode TEXT
          );
        ''');
  }
}
