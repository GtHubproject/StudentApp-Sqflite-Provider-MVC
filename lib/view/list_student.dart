
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_mvc_sqflite_provider/view/student_add.dart';
import '../controllers/provider.dart';
import 'student_update.dart';

class StudentListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MyAppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
      ),
      body: ListView.builder(
        itemCount: appState.students.length,
        itemBuilder: (context, index) {
          final student = appState.students[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: student.imagePath != null
                  ? FileImage(File(student.imagePath!))
                  : null,
              child: student.imagePath == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            title: Text(student.name,style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Age: ${student.age}',style: TextStyle(fontSize: 15,color: Colors.black),),
                Text('Phone: ${student.phoneNumber}',style: TextStyle(fontSize: 15,color: Colors.black)),
                Text('Email: ${student.email}',style: TextStyle(fontSize: 15,color: Colors.black)),
                if (student.imagePath != null)
                  Image.file(File(student.imagePath!)),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditStudentScreen(student: student),
                  ),
                );
              },
            ),
            onLongPress: ()  {
               appState.deleteStudent(student.id!);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStudentScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}