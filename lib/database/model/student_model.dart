import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String image;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String batch;
  @HiveField(4)
  final String course;
  StudentModel({
    required this.image,
    required this.name,
    required this.age,
    required this.batch,
    required this.course,
  });
}
