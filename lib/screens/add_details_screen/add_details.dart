import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_zone_app/database/dbfunction/db_functions.dart';
import 'package:student_zone_app/database/model/student_model.dart';
import 'package:student_zone_app/screens/account/account_screen.dart';
import 'package:student_zone_app/screens/add_details_screen/widgets/widgets.dart';

import 'package:student_zone_app/screens/widgets/widgets.dart';

ValueNotifier<XFile?> imageFileNotifier = ValueNotifier(imageFile);
final picker = ImagePicker();
XFile? imageFile;

class AddDetails extends StatelessWidget {
  AddDetails({Key? key}) : super(key: key);
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _batchController = TextEditingController();
  final _courseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Add Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        elevation: 50,
                        context: context,
                        builder: (context) => bottomSheet(context));
                  },
                  child: ValueListenableBuilder(
                      valueListenable: imageFileNotifier,
                      builder: (BuildContext context, XFile? image, Widget? _) {
                        return CircleAvatar(
                          backgroundImage: image != null
                              ? FileImage(File(image.path)) as ImageProvider
                              : const AssetImage('assets/images/Nophoto.jpg'),
                          radius: size.width * 0.3,
                        );
                      }),
                ),
              ),
              displayTextField(false, _nameController, 'Stuent Name'),
              const SizedBox(
                height: 20,
              ),
              displayTextField(true, _ageController, 'Student Age'),
              const SizedBox(
                height: 20,
              ),
              displayTextField(false, _batchController, 'Student Batch'),
              const SizedBox(
                height: 20,
              ),
              displayTextField(false, _courseController, 'Student Course'),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  submit(context);
                },
                icon: const Icon(Icons.check_circle),
                label: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  submit(context) {
    final _image = imageFileNotifier.value!.path.toString();
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _batch = _batchController.text.trim();
    final _course = _courseController.text.trim();
    if (_name.isEmpty ||
        _age.isEmpty ||
        _batch.isEmpty ||
        _course.isEmpty ||
        _image.isEmpty) {
      snackBar(context, 'All Field Required', Colors.red.withOpacity(0.2));
      return;
    } else {
      final student = StudentModel(
          name: _name,
          age: _age,
          batch: _batch,
          course: _course,
          image: _image);
      addStudent(student);
      snackBar(
          context, 'Submitted Successfully', Colors.green.withOpacity(0.3));

      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   backgroundColor: Colors.green,
      //   margin: EdgeInsets.all(20),
      //   behavior: SnackBarBehavior.floating,
      //   content: Text("Submitted Succesfully"),
      //   duration: Duration(seconds: 2),
      // ));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AccountScreen()));
    }
  }
}
