
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controllers/provider.dart';

import '../main.dart';
import '../models/student_class.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;

  EditStudentScreen({required this.student});

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  XFile? selectedImage;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.student.name;
    ageController.text = widget.student.age.toString();
    phoneNumberController.text = widget.student.phoneNumber;
    emailController.text = widget.student.email;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MyAppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
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
                    return null;
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
                    // if (_formKey.currentState!.validate()) {
                    //
                    //   widget.student.name = nameController.text.trim();
                    //   widget.student.age = int.parse(ageController.text.trim());
                    //   widget.student.phoneNumber = phoneNumberController.text.trim();
                    //   widget.student.email = emailController.text.trim();
                    //   widget.student.imagePath = selectedImage?.path;
                    //
                    //   await appState.updateStudent(widget.student);
                    //   Navigator.pop(context);
                    // }
                    if (_formKey.currentState!.validate()) {
                      final updatedStudent = Student(
                        id: widget.student.id, // Make sure to set the student's ID
                        name: nameController.text.trim(),
                        age: int.parse(ageController.text.trim()),
                        phoneNumber: phoneNumberController.text.trim(),
                        email: emailController.text.trim(),
                        imagePath: selectedImage?.path,
                      );

                      await appState.updateStudent(updatedStudent);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Update'),
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