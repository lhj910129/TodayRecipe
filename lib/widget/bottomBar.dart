import 'package:flutter/material.dart';

import '../model/common.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        height: 80,
        child: TabBar(
          labelColor: Colors.deepOrangeAccent,
          unselectedLabelColor: Colors.black26,
          indicatorColor: Colors.transparent,
          tabs: const <Widget>[
            Tab(
              icon: Icon(
                Icons.kitchen,
                size: 20,
              ),
              child: Text(
                '냉장고',
                style: TextStyle(fontSize: 12),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.restaurant_outlined,
                size: 20,
              ),
              child: Text(
                '레시피',
                style: TextStyle(fontSize: 12),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.bookmarks_outlined,
                size: 20,
              ),
              child: Text(
                '즐겨찾기',
                style: TextStyle(fontSize: 12),
              ),
            ),
            // Tab(
            //   icon: Icon(
            //     Icons.person,
            //     size: 20,
            //   ),
            //   child: Text(
            //     '마이페이지',
            //     style: TextStyle(fontSize: 12),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class KitchenBar extends StatelessWidget {
  const KitchenBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        height: 80,
        child: TabBar(
          labelColor: Colors.deepOrangeAccent,
          unselectedLabelColor: Colors.black26,
          indicatorColor: Colors.transparent,
          tabs: const <Widget>[
            Tab(
              icon: Icon(
                Icons.kitchen,
                size: 20,
              ),
              child: Text(
                '냉장고',
                style: TextStyle(fontSize: 12),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.restaurant_outlined,
                size: 20,
              ),
              child: Text(
                '레시피',
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}