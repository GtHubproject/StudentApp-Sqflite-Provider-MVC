import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studentapp_mvc_sqflite_provider/controllers/sqflite_database.dart';
import '../models/student_class.dart';

class MyAppState extends ChangeNotifier {
  final dbHelper = DatabaseHelper();
  final List<Student> students = [];

  MyAppState() {
    initializeDatabase();
    _refreshStudentList();
  }

  Future<void> initializeDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'students.db');

    dbHelper.db = await openDatabase(
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
    await dbHelper.insertStudent(student);
    _refreshStudentList();
  }

  Future<void> _refreshStudentList() async {
    final studentsData = await dbHelper.getAllStudents();
    students.clear();
    students.addAll(studentsData);
    notifyListeners();
  }

  Future<void> updateStudent(Student student) async {
    await dbHelper.updateStudent(student);
    _refreshStudentList();
  }

  Future<void> deleteStudent(int id) async {
    await dbHelper.deleteStudent(id);
    _refreshStudentList();
  }
}