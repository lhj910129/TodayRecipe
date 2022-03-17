import 'dart:ui';

import 'package:flutter/material.dart';

class Kitchen extends StatefulWidget {
  const Kitchen({Key? key}) : super(key: key);

  @override
  State<Kitchen> createState() => _KitchenState();
}

class _KitchenState extends State<Kitchen> {

  Fridges frg = Fridges();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('냉장고'),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.orange[700],
          actions: <Widget>[
            TextButton(
                
                onPressed: () {
                  /*
                  1. 텍스트가 취소 일때
                    - 텍스트가 선택으로 바뀐다.
                    - 모든 칩들에 체크박스가 생긴다.
                    - 하단바가 삭제, 이동 버튼을 표시하는 Bar로 바뀐다.
                  2. 텍스트가 선택 일때
                    - 텍스트가 취소로 바뀐다.
                    - 모든 칩들의 체크박스가 사라진다.
                    - 하단바가 디폴트 하단바로 바뀐다.
                  */




                },
                child: Text(
                  '선택',
                  style: TextStyle(color: Colors.orange[600]),
                )),
            // TextButton(
            //     onPressed: () {},
            //     child: Text(
            //       '삭제',
            //       style: TextStyle(color: Colors.orange[600]),
            //     )),
            // TextButton(
            //     onPressed: () {},
            //     child: Text(
            //       '이동',
            //       style: TextStyle(color: Colors.orange[600]),
            //     )),
          ],
        ),
        body: frg,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.orange[600],
          onPressed: () {},
        ));
  }
}

//냉장고
class Fridges extends StatelessWidget {
  const Fridges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(child: Text('냉장고가 없어요.'),);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
              child: Text(
                '냉동실',
                style: TextStyle(color: Colors.orange[600], fontSize: 16),
              ),
              padding: EdgeInsets.all(5)),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Wrap(
              spacing: 5.0,
              runSpacing: 3.0,
              children: [Ingredients()],
            ),
          ),
        ],
      ),
    );
  }
}




//재료
class Ingredients extends StatefulWidget {
  const Ingredients({Key? key}) : super(key: key);

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
        // avatar: Icon(Icons.inventory_2, size: 17,),
        label: Text(
          '청경채',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.transparent,
        shape: StadiumBorder(side: BorderSide(color: Colors.orange)),
        selected: true,
        selectedColor: Colors.orange,
        checkmarkColor: Colors.white,
        onSelected: (bool value) {
          print('select');
        });
  }
}
