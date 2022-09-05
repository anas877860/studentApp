import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:student_zone_app/database/model/student_model.dart';
import 'package:student_zone_app/screens/add_details_screen/add_details.dart';
import 'package:student_zone_app/screens/update_student_screen.dart';

class StudentDetails extends StatelessWidget {
  final StudentModel data;
  final int index;
  const StudentDetails({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      imageFileNotifier.value = null;
    });

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Student Details'),
        actions: [
          IconButton(
              onPressed: () {
                editStudent(context, index);
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        shadowColor: Colors.cyan,
        elevation: 200,
        color: Colors.black,
        child: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.025,
                ),
                CircleAvatar(
                  backgroundImage: FileImage(File(data.image)),
                  radius: size.width * 0.3,
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                display('Name', data.name.toUpperCase()),
                SizedBox(
                  height: size.height * 0.025,
                ),
                dividerStyle(),
                SizedBox(
                  height: size.height * 0.025,
                ),
                display('Age', data.age.toUpperCase()),
                SizedBox(
                  height: size.height * 0.025,
                ),
                dividerStyle(),
                SizedBox(
                  height: size.height * 0.025,
                ),
                display('Batch', data.batch.toUpperCase()),
                SizedBox(
                  height: size.height * 0.025,
                ),
                dividerStyle(),
                SizedBox(
                  height: size.height * 0.025,
                ),
                display('Course', data.course.toUpperCase()),
                SizedBox(
                  height: size.height * 0.025,
                ),
                dividerStyle(),
                SizedBox(
                  height: size.height * 0.025,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider dividerStyle() => const Divider(
        color: Colors.blueGrey,
        thickness: 5,
        indent: 30,
        endIndent: 30,
      );

  Widget display(field, data) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            field,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          Flexible(
            child: Text(
              data,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          )
        ],
      );
}
