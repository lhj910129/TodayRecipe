import 'package:flutter/material.dart';
import 'package:todayrecipe/widget/bottomBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '오늘레시피',
        theme:
            ThemeData(brightness: Brightness.light, primaryColor: Colors.white),
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
                bottomNavigationBar: BottomBar(),
                )));
  }
}
