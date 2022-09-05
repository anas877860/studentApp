import 'package:flutter/material.dart';
import 'package:student_zone_app/screens/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(context);
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/images.png",
          height: 600,
        ),
      ),
    );
  }

  log(context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
