import 'package:flutter/material.dart';
import 'package:student_zone_app/screens/account/account_screen.dart';
import 'package:student_zone_app/screens/home/home_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  List pages = const [HomeScreen(), AccountScreen()];
  ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currentIndexNotifier,
        builder: (BuildContext context, int newCurrentIndex, Widget? child) {
          return Scaffold(
            body: pages[newCurrentIndex],
            bottomNavigationBar: BottomNavigationBar(
                iconSize: 40,
                backgroundColor: Colors.cyan,
                selectedItemColor: Colors.black,
                currentIndex: newCurrentIndex,
                onTap: (newIndex) {
                  currentIndexNotifier.value = newIndex;
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_box), label: 'Account')
                ]),
          );
        });
  }
}
