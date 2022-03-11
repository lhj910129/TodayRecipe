import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        height: 90,
        child: TabBar(
          labelColor: Colors.red[600],
          unselectedLabelColor: Colors.black26,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            
            Tab(
              icon: Icon(
                Icons.kitchen,
                size: 25,
              ),
              child: Text(
                '냉장고',
                style: TextStyle(fontSize: 12),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.restaurant_outlined,
                size: 25,
              ),
              child: Text(
                '레시피',
                style: TextStyle(fontSize: 12),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.bookmarks_outlined,
                size: 25,
              ),
              child: Text(
                '즐겨찾기',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
