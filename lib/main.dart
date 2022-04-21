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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '오늘레시피',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          //accentColor: Colors.deepOrangeAccent,
          canvasColor: Colors.white,
          fontFamily: 'GmarketSans',
        ),
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              body: TabBarView(
                children: [
                  Kitchen(),
                  Recipe(),
                  BookMark(),
                ],
                physics: NeverScrollableScrollPhysics(),
              ),
              bottomNavigationBar: BottomBar(),
            )));
  }
}
