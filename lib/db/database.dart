import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_exmple/models/student.dart';

@singleton
class DBProvider {
  static final DBProvider db = DBProvider();
  Database? _database;
  String studentTable = 'Students';
  String columndId = 'id';
  String columnName = 'name';
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}Student db';
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $studentTable($columndId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT)');
  }

  Future<List<Student>> getStudents() async {
    Database db = await database;
    final List<Map<String, dynamic>> studentsMapList =
        await db.query(studentTable);
    final List<Student> studentList = [];
    for (var element in studentsMapList) {
      studentList.add(Student.fromMap(element));
    }
    return studentList;
  }

  Future<Student> insertStudent(Student student) async {
    Database db = await database;
    student.id = await db.insert(studentTable, student.toMap());
    return student;
  }

  Future<int> updateStudent(Student student) async {
    Database db = await database;
    return await db.update(
      studentTable,
      student.toMap(),
      where: '$columndId = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    Database db = await database;
    return await db.delete(
      studentTable,
      where: '$columndId = ?',
      whereArgs: [id],
    );
  }
}
