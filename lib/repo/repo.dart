import 'package:injectable/injectable.dart';
import 'package:sqflite_exmple/db/database.dart';
import 'package:sqflite_exmple/models/student.dart';

abstract class Repo {
  Future<List<Student>> getStudents();
  Future<Student> postStudent(Student student);
  Future<int> deleteStudent(int id);
}

@LazySingleton(as: Repo)
class RepoImpl implements Repo {
  @override
  Future<List<Student>> getStudents() async =>
      await DBProvider.db.getStudents();

  @override
  Future<Student> postStudent(Student student) async =>
      await DBProvider.db.insertStudent(student);

  @override
  Future<int> deleteStudent(int id) async =>
      await DBProvider.db.deleteStudent(id);
}
