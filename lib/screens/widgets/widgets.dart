import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:student_zone_app/screens/add_details_screen/add_details.dart';


Container bottomSheet(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        border: Border.all(width: 5.0, color: Colors.cyan),
      ),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Choose Profile Photo',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                    
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.image_search),
                  label: const Text('Gallery')),
              ElevatedButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                    
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'))
            ],
          ),
        ],
      ));
}

void takePhoto(ImageSource src) async {
  final pickedFile = await ImagePicker().pickImage(source: src);
   
  imageFileNotifier.value = pickedFile;
  // changeImage=false;
}
 ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      BuildContext context, String title, Color color) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor:color,
        margin: const EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        content:  Text(title),
        duration: const Duration(seconds: 3)));
  }