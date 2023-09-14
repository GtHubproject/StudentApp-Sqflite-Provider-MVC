


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_mvc_sqflite_provider/view/list_student.dart';

import 'controllers/provider.dart';

final emailRegex = RegExp(
  r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MyAppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      title: 'Student List',
      home: StudentListScreen(),
    );
  }
}



