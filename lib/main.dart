import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todayrecipe/view/bookMark.dart';
import 'package:todayrecipe/view/kitchen.dart';
import 'package:todayrecipe/view/myPage.dart';
import 'package:todayrecipe/view/recipe.dart';
import 'package:todayrecipe/widget/widget_bottomBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '오늘레시피',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          //fontFamily: 'Cafe24Ssurround'
        ),
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              body: TabBarView(
                children: <Widget>[Kitchen(), Recipe(), BookMark()],
                physics: NeverScrollableScrollPhysics(),
              ),
              bottomNavigationBar: BottomBar(),
            )));
  }
}
