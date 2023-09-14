import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/student_class.dart';

class DatabaseHelper {
  late Database db;

  Future<void> initializeDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'students.db');

    db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, phoneNumber TEXT, email TEXT, imagePath TEXT)
          ''',
        );
      },
    );
  }

  Future<void> insertStudent(Student student) async {
    await db.insert('students', student.toMap());
  }

  Future<List<Student>> getAllStudents() async {
    final List<Map<String, dynamic>> maps = await db.query('students');
    return List.generate(maps.length, (i) {
      return Student.fromMap(maps[i]);
    });
  }

  Future<void> updateStudent(Student student) async {
    await db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<void> deleteStudent(int id) async {
    await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}