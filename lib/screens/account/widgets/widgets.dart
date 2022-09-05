import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_zone_app/database/dbfunction/db_functions.dart';
import 'package:student_zone_app/screens/student_details.dart';

showAlertDialog(context, index) {
  final alert = AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
    ),
    elevation: 50,
    backgroundColor: Colors.blueGrey,
    title: const Text(
      'Alert Dialog',
      style: TextStyle(color: Colors.white),
    ),
    content: const Text(
      'Do you want to Delete?',
      style: TextStyle(color: Colors.white),
    ),
    actions: [
      ElevatedButton(
          onPressed: () {
            deleteStudent(index);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              margin: EdgeInsets.all(20),
              behavior: SnackBarBehavior.floating,
              content: Text("Deleted Succesfully"),
              duration: Duration(seconds: 2),
            ));
            Navigator.pop(context);
          },
          child: const Text('Ok')),
      ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'))
    ],
  );
  showDialog(context: context, builder: (context) => alert);
}

class MySearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listItems = query.isEmpty
        ? studentListNotifier.value
        : studentListNotifier.value
            .where((element) => element.name
                .toLowerCase()
                .startsWith(query.toLowerCase().toString()))
            .toList();

    return Container(
      color: Colors.cyan,
      child: listItems.isEmpty
          ? const Center(child: Text("No Data Found!"))
          : ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      child: Ink(
                        color: Colors.black,
                        child: ListTile(
                          leading: getimage(listItems[index]),
                          title: Text(
                            listItems[index].name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "Age : ${(listItems[index].age.toString())}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => StudentDetails(
                                  index: index,
                                  data: listItems[index],
                                  // studentListNotifier.value[index
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  getimage(data) {
    if (data.image == null) {
      return const CircleAvatar(
        backgroundImage: AssetImage('assets/images/avatar.png'),
      );
    } else {
      return CircleAvatar(
        backgroundImage: FileImage(File(data.image)),
      );
    }
  }
}
