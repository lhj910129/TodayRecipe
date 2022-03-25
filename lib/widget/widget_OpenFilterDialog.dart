import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:todayrecipe/model/ingredient.dart';

class OpenFilterDialog extends StatefulWidget {
  const OpenFilterDialog({Key? key}) : super(key: key);

  @override
  State<OpenFilterDialog> createState() => _OpenFilterDialogState();
}

class _OpenFilterDialogState extends State<OpenFilterDialog> {
  final Stream<QuerySnapshot>? streamData =
      FirebaseFirestore.instance.collection('all_ingredient').snapshots();

  List<Ingredient> selIgdt = [];

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
          return FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.deepOrangeAccent,
            onPressed: () {
              print('전체 재료 목록 선택팝업 가져오기');
              openFilterDialog(context, snapshot.data!.docs);
            },
          );
        });
  }

  void openFilterDialog(
      BuildContext context, List<DocumentSnapshot> snapshot) async {
    List<Ingredient> igdt =
        snapshot.map((e) => Ingredient.fromSnapShot(e)).toList();

    selIgdt.clear();

    await FilterListDialog.display<Ingredient>(
      context,
      listData: igdt,
      selectedListData: selIgdt,
      choiceChipLabel: (e) => e!.name.toString(),
      validateSelectedItem: (e, val) => e!.contains(val),
      onItemSearch: (e, query) {
        return e.name.toString().toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        Navigator.pop(context);
        setState(() {
          selIgdt = List.from(list!);
          print(selIgdt.toString());
        });
      },
      applyButtonText: '추가',
      allButtonText: '전체',
      resetButtonText: '초기화',
      selectedItemsText: '개의 재료가 선택되었어요.',
      headlineText: '재료 추가',
      headerCloseIcon: Icon(
        Icons.close,
        color: Colors.deepOrangeAccent,
      ),
      backgroundColor: Colors.blue,
      controlButtons: [],
      choiceChipBuilder: (context, igdt, isSelected) {
        return
            // FilterChip(
            //   label: Text(
            //     igdt.name,
            //     style: TextStyle(color: Colors.black87),
            //   ),
            //   avatar: Icon(
            //     Icons.egg,
            //     size: 20,
            //     color: Colors.deepOrangeAccent,
            //   ),
            //   shape: StadiumBorder(side: BorderSide(color: Colors.deepOrangeAccent)),
            //   backgroundColor: Colors.transparent,
            //   selectedColor: Colors.deepOrangeAccent,
            //   checkmarkColor: Colors.white,
            //   selected: isSelected!,
            //   onSelected: (bool value) {
            //     setState(() {
            //       print(selIgdt.contains(igdt));

            //       if (value) {
            //         selIgdt.add(igdt);
            //       } else {
            //         selIgdt.removeWhere((Ingredient _igdt) {
            //           return _igdt == igdt;
            //         });
            //       }
            //     });

            //     print(selIgdt.toString());
            //   },
            // );

            ChoiceChip(
              label: Text(igdt.name,),
              labelStyle: isSelected!? TextStyle(color: Colors.white) :TextStyle(color: Colors.black),
              shadowColor: Colors.transparent,
              selected: isSelected!,
              shape: StadiumBorder(side: BorderSide(color: Colors.deepOrangeAccent)),
              avatar: Icon(
                Icons.egg,
                size: 20,
                color: isSelected!?Colors.white: Colors.deepOrangeAccent,
              ),

              disabledColor: Colors.white,
              backgroundColor: Colors.white,
              selectedColor: Colors.deepOrangeAccent,
              // onSelected: (bool select){
              //   print('선택함');

              // }
              
            );



      },
    );
  }
}
