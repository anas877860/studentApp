import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_zone_app/database/model/student_model.dart';
import 'package:student_zone_app/screens/add_details_screen/add_details.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  // final id =
  await studentDB.add(value);

  // value.id = id;
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int index) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  final keys = studentDB.keys;
  final savedKey = keys.elementAt(index);
  studentDB.delete(savedKey);
  getAllStudents();
}

Future<void> updateStudent(int index, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  final keys = studentDB.keys;
  final savedKey = keys.elementAt(index);
  studentDB.put(savedKey, value);

  await getAllStudents();
}
