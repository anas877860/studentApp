import 'package:flutter/material.dart';
import 'package:student_zone_app/screens/add_details_screen/add_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Add Student"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Click to Add Student',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddDetails()));
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Student"))
        ],
      ),
    );
  }
}
