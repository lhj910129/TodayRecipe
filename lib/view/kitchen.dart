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
  Stream<QuerySnapshot>? streamData =
      FirebaseFirestore.instance.collection('ingredient').snapshots();

  bool floatShow = true; //floating버튼 표시용도
  bool selMode = false; //재료 선택모드 구별용도
  List<String> selChips = []; //선택한 칩 담는용

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamData,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return LinearProgressIndicator(); //데이터가 없을때 프로그래스 바
        if (snapshot.hasError) return Text('snapShot Error'); //에러났을때
        if (snapshot.connectionState == ConnectionState.waiting) {
          //기다리는중일때
          return Text("Loading");
        }

        return _buildBody(context, snapshot.data!.docs)!;
      },
    );
  }

  Widget? _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Scaffold(
      appBar: AppBar(
          title: Text('냉장고'),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepOrangeAccent,
          actions: selMode
              ? [
                  TextButton(
                    child: Text(
                      '삭제',
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    ),
                    onPressed: () {
                      if (selChips.isNotEmpty) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('재료 삭제'),
                            content: const Text('선택하신 재료를 삭제하시겠습니까?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('취소'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                  /* 선택한 칩 리스트 가지고 가서 업데이트 하기 */



                                  
                                },
                                child: const Text('삭제'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  TextButton(
                    child: Text(
                      '취소',
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    ),
                    onPressed: () {
                      setState(() {
                        selMode = false;
                        floatShow = true;
                        selChips = [];
                      });
                      print(selMode);
                    },
                  ),
                ]
              : [
                  TextButton(
                    child: Text(
                      '선택',
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    ),
                    onPressed: () {
                      setState(() {
                        selMode = true;
                        floatShow = false;
                      });
                      /*
                        - AppBar의 Floating Button 숨기기
                      
                       */
                      print(selMode);
                    },
                  ),
                ]),
      body: Wrap(
        children: MakeChips(context, snapshot).toList(),
        spacing: 0,
      ),
      floatingActionButton: Visibility(
        visible: floatShow,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () {},
        ),
      ),
    );
  }

  //필터칩 만들기
  Iterable<Widget> MakeChips(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Ingredient> igdt =
        snapshot.map((e) => Ingredient.fromSnapShot(e)).toList();

    return igdt.map((e) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: FilterChip(
              label: Text(
                e.name.toString(),
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
              shape: StadiumBorder(
                  side: BorderSide(color: Colors.deepOrangeAccent)),
              selected: selChips.contains(e.name),
              onSelected: (bool value) {
                setState(() {
                  if (value && selMode) {
                    selChips.add(e.name.toString());
                  } else {
                    selChips.removeWhere((String name) {
                      return name == e.name.toString();
                    });
                  }
                });
              }));
    });
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
          return user.name
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
        },
      ),
    );
  }
}
