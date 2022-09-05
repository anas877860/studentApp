import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_zone_app/database/dbfunction/db_functions.dart';
import 'package:student_zone_app/database/model/student_model.dart';
import 'package:student_zone_app/screens/add_details_screen/add_details.dart';

import 'package:student_zone_app/screens/student_details/student_details.dart';
import 'package:student_zone_app/screens/widgets/widgets.dart';

final updateStudentName = TextEditingController();
final updateStudentAge = TextEditingController();
final updateStudentBatch = TextEditingController();
final updateStudentCourse = TextEditingController();


editStudent(context, index) {
  updateStudentName.text = studentListNotifier.value[index].name;
  updateStudentAge.text = studentListNotifier.value[index].age;
  updateStudentBatch.text = studentListNotifier.value[index].batch;
  updateStudentCourse.text = studentListNotifier.value[index].course;

  return showDialog(
      context: context,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          elevation: 50,
          backgroundColor: Colors.cyan,
          title: const Text('Update Student Details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        elevation: 50,
                        context: context,
                        builder: (context) {
                          return bottomSheet(context);
                        });
                  },
                  child: ValueListenableBuilder(
                      valueListenable: imageFileNotifier,
                      builder: (BuildContext context, XFile? image, Widget? _) {
                        return CircleAvatar(
                            radius: size.width * .25,
                            backgroundImage: image == null
                                ? FileImage(File(
                                    studentListNotifier.value[index].image))
                                : FileImage(File(
                                    image.path,
                                  )));
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: updateStudentName,
                  style: const TextStyle(color: Colors.white),
                 
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            width: 3, color: Colors.black.withOpacity(0.5)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(width: 3, color: Colors.black),
                      ),
                      hintText: 'Student Name',
                      hintStyle: const TextStyle(color: Colors.blueGrey)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: updateStudentAge,
                  style: const TextStyle(color: Colors.white),
                 
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            width: 3, color: Colors.black.withOpacity(0.5)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(width: 3, color: Colors.black),
                      ),
                      hintText: 'Student Age',
                      hintStyle: const TextStyle(color: Colors.blueGrey)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: updateStudentBatch,
                  style: const TextStyle(color: Colors.white),
                  
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            width: 3, color: Colors.black.withOpacity(0.5)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(width: 3, color: Colors.black),
                      ),
                      hintText: 'Student Batch',
                      hintStyle: const TextStyle(color: Colors.blueGrey)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: updateStudentCourse,
                  style: const TextStyle(color: Colors.white),
             
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            width: 3, color: Colors.black.withOpacity(0.5)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(width: 3, color: Colors.black),
                      ),
                      hintText: 'Student Course',
                      hintStyle: const TextStyle(color: Colors.blueGrey)),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      onUpdateButtonClicked(context, index);
                    },
                    icon: const Icon(
                      Icons.done_all,
                      color: Colors.cyan,
                    ),
                    label: const Text(
                      'Update',
                      style: TextStyle(color: Colors.cyan),
                    ))
              ],
            ),
          ),
        );
      });
}

onUpdateButtonClicked(context, index) async {
  
  final image = imageFileNotifier.value == null
      ? studentListNotifier.value[index].image
      : imageFileNotifier.value!.path;

  final name = updateStudentName.text.trim();
  final age = updateStudentAge.text.trim();
  final batch = updateStudentBatch.text.trim();
  final course = updateStudentCourse.text.trim();
  if (name.isEmpty ||
      age.isEmpty ||
      batch.isEmpty ||
      course.isEmpty ||
      image.isEmpty) {
    snackBar(context, "All field Required", Colors.red.withOpacity(0.2));
   
    return;
  } else {
    final student = StudentModel(
        name: name, age: age, batch: batch, course: course, image: image);
    await updateStudent(index, student);
    Navigator.pop(context);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => StudentDetails(data: student, index: index)));
    snackBar(
        context, "Updated field Successfuly", Colors.green.withOpacity(0.2));
   
  }
}
