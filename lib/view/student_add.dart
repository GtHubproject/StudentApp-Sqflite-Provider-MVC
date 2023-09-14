
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controllers/provider.dart';

import '../main.dart';
import '../models/student_class.dart';

class AddStudentScreen extends StatefulWidget {

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  XFile? selectedImage; // Added field to store selected image

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MyAppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (selectedImage != null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(File(selectedImage!.path)),
                  ),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Pick an Image'),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Student Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an age';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }

                    //return null;
                    final RegExp phoneRegex = RegExp(r'^\d{10}$'); // Regex for a 10-digit phone number

                    if (!phoneRegex.hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null; // Return null if the input is valid.
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final newName = nameController.text.trim();
                      final newAge = int.parse(ageController.text.trim());
                      final newPhoneNumber = phoneNumberController.text.trim();
                      final newEmail = emailController.text.trim();

                      if (newName.isNotEmpty) {
                        final student = Student(
                          name: newName,
                          age: newAge,
                          phoneNumber: newPhoneNumber,
                          email: newEmail,
                          imagePath: selectedImage?.path,
                        );
                        await appState.insertStudent(student);
                        print('Saved');
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = pickedImage;
    });
  }
}
