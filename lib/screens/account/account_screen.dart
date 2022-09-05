import 'dart:io';

import 'package:flutter/material.dart';

import 'package:student_zone_app/database/dbfunction/db_functions.dart';
import 'package:student_zone_app/database/model/student_model.dart';
import 'package:student_zone_app/screens/account/widgets/widgets.dart';
import 'package:student_zone_app/screens/add_details_screen/add_details.dart';
import 'package:student_zone_app/screens/student_details/student_details.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       imageFileNotifier.value = null;
    });
    
    getAllStudents();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Student List"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearch());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext context, List<StudentModel> studentList,
              Widget? _) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  final student = studentList[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Card(
                        elevation: 50,
                        shadowColor: Colors.cyan,
                        child: Ink(
                          color: Colors.black,
                          child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StudentDetails(
                                        data: student,
                                        index: index,
                                      ),
                                    ));
                              },
                              leading: CircleAvatar(
                                radius: 40,
                                backgroundImage: FileImage(File(student.image)),
                              ),
                              title: Text(
                                student.name.toUpperCase().toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                student.age.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showAlertDialog(context, index);
                                  // deleteStudent(index);
                                },
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                              )),
                        )),
                  );
                },
                itemCount: studentList.length);
          }),
    );
  }
}
