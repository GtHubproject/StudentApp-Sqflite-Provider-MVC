import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Student {
  int? id;
   final String name;
   final int age;
   final String phoneNumber;
   final String email;
  String? imagePath; // Added image path field

  Student({
    this.id,
    required this.name,
    required this.age,
    required this.phoneNumber,
    required this.email,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'phoneNumber': phoneNumber,
      'email': email,
      'imagePath': imagePath,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      imagePath: map['imagePath'],
    );
  }
}


