import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todayrecipe/model/ingredient.dart';

class Kitchen extends StatefulWidget {
  const Kitchen({Key? key}) : super(key: key);

  @override
  State<Kitchen> createState() => _KitchenState();
}

class _KitchenState extends State<Kitchen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot>? streamData;

  @override
  void InitState() {
    super.initState();

    streamData = firestore.collection('ingredient').snapshots();
  }

  //데이터 가져오기
  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ingredient').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildBody(context, snapshot.data!.docs)!;
      },
    );
  }

  Widget? _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Ingredient> ingredient =
        snapshot.map((e) => Ingredient.fromSnapShot(e)).toList();

    return Scaffold(
      appBar: KetchenAppBar(),
      body: Wrap(children: getIngredients(context, ingredient)), //Fridges(),
      //body: FilterPage(ingredient: ingredient),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          /*
              - 추가버튼을 숨기는 함수 필요
              - 재료가 아예 없을때는 아무 반응 없음
              - 
             */
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}

class KetchenAppBar extends StatefulWidget with PreferredSizeWidget {
  const KetchenAppBar({Key? key}) : super(key: key);

  @override
  State<KetchenAppBar> createState() => _KetchenAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _KetchenAppBarState extends State<KetchenAppBar> {
  bool selMode = false; //재료 선택모드 구별용도

  @override
  void InitState() {
    super.initState();

    bool selMode = false;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text('냉장고'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepOrangeAccent,
        actions: selMode
            ? [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      '삭제',
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    )),
                TextButton(
                    onPressed: () {
                      print(selMode);

                      setState(() {
                        selMode = !selMode;
                      });
                    },
                    child: Text(
                      '취소',
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    )),
              ]
            : [
                TextButton(
                    onPressed: () {
                      print(selMode);

                      setState(() {
                        

                        
                        selMode = !selMode;
                      });
                    },
                    child: Text(
                      '선택',
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    )),
              ]);
  }
}

//냉장고
class getFridges extends StatelessWidget {
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
                style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 16),
              ),
              padding: EdgeInsets.all(5)),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Wrap(
              spacing: 5.0,
              runSpacing: 3.0,
              //children: makeIngredients(),
            ),
          ),
        ],
      ),
    );
  }
}

//재료 필터칩 개수만큼 만들기
List<Widget> getIngredients(
    BuildContext context, List<Ingredient>? ingredient) {
  List<Widget> results = [];

  //재료가 null이거나 없을 때
  if (ingredient == null || ingredient.length < 1) {
    results.add(Text('냉장고가 비었어요.'));
  } else //뭐라도 하나 있을때
  {
    for (var i = 0; i < (ingredient.length); i++) {
      results.add(FilterChip(
        label: Text(
          ingredient[i].name,
          style: TextStyle(color: Colors.black87),
        ),
        avatar: Icon(
          Icons.egg,
          size: 20,
          color: Colors.deepOrangeAccent,
        ),
        backgroundColor: Colors.transparent,
        selectedColor: Colors.deepOrangeAccent,
        checkmarkColor: Colors.white,
        shape: StadiumBorder(side: BorderSide(color: Colors.deepOrangeAccent)),
        onSelected: (bool value) {
          print(ingredient[i].name.toString());
        },
        pressElevation: null,
      ));
    }
  }

  return results;
}











class FilterPage extends StatelessWidget {
  late final List<Ingredient>? ingredient;
  FilterPage({this.ingredient});

  //late final List<Ingredient>? selectedIgnt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FilterListWidget<Ingredient>(
        listData: ingredient,
        selectedListData: ingredient,

        // onApplyButtonClick: (list) {
        //   // do something with list ..
        // },
        choiceChipLabel: (item) {
          /// Used to display text on chip
          return item!.name;
        },
        validateSelectedItem: (list, val) {
          ///  identify if item is selected or not
          return list!.contains(val);
        },
        onItemSearch: (user, query) {
          /// When search query change in search bar then this method will be called
          ///
          /// Check if items contains query
          return user.name.toLowerCase().contains(query.toLowerCase());
        },
      ),
    );
  }
}
