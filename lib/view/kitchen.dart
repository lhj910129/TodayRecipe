import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todayrecipe/model/ingredient.dart';

import '../widget/widget_OpenFilterDialog.dart';

class Kitchen extends StatefulWidget {
  const Kitchen({Key? key}) : super(key: key);

  @override
  State<Kitchen> createState() => _KitchenState();
}

class _KitchenState extends State<Kitchen> {
  final Stream<QuerySnapshot>? streamData =
      FirebaseFirestore.instance.collection('ingredient').snapshots();

  bool selMode = false; //재료 선택모드 구별용도
  List<String> selChips = []; //선택한 칩 담는용

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator(); //데이터가 없을때 프로그래스 바
        }
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
    List<Ingredient> igdt =
        snapshot.map((e) => Ingredient.fromSnapShot(e)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '냉장고',
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).canvasColor,
        foregroundColor: Theme.of(context).primaryColor,
        actions: appBarActions(selMode).toList(),
      ),
      body: Wrap(
        children: MakeChips(context, snapshot).toList(),
        spacing: 0,
      ),
      floatingActionButton: Visibility(
        visible: !selMode,
        child: OpenFilterDialog(myIgdt: igdt),
      ),
    );
  }

  //취소삭제 or 선택
  List<Widget> appBarActions(bool selmode) {
    List<Widget> list = [];
    if (!selmode) {
      list.add(
        TextButton(
          //선택버튼
          child: Text(
            '선택',
            style: TextStyle(color: Colors.deepOrangeAccent),
          ),
          onPressed: () {
            setState(() {
              selMode = true;
            });
            print(selMode);
          },
        ),
      );
    } else {
      list.add(
        TextButton(
          //삭제버튼
          child: Text(
            '삭제',
            style: TextStyle(color: Colors.deepOrangeAccent),
          ),
          onPressed: () {
            if (selChips.isNotEmpty) {
              print('선택한 재료 :' + selChips.toString());

              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('재료 삭제'),
                  content: const Text('선택하신 재료를 삭제하시겠습니까?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('취소'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');

                        setState(() {
                          // if (selChips.isNotEmpty) {
                          //   for (int i = 0;
                          //       i < selChips.length;
                          //       i++) {
                          //     igdt[igdt.indexWhere((element) =>
                          //             element.name.toString() ==
                          //             selChips[i].toString())]
                          //         .reference!
                          //         .delete();
                          //     print(
                          //         selChips[i].toString() + ' 삭제 완료');
                          //   }
                          // }
                        });
                      },
                      child: const Text('삭제'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      );

      list.add(
        TextButton(
          //취소버튼
          child: Text(
            '취소',
            style: TextStyle(color: Colors.deepOrangeAccent),
          ),
          onPressed: () {
            setState(() {
              selMode = false;
              selChips = [];
            });
            print(selMode);
          },
        ),
      );
    }

    return list;
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
