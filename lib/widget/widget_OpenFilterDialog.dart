import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todayrecipe/model/ingredient.dart';

class OpenFilterDialog extends StatefulWidget {
  OpenFilterDialog({this.myIgdt});
  final List<Ingredient>? myIgdt;

  @override
  State<OpenFilterDialog> createState() => _OpenFilterDialogState();
}

class _OpenFilterDialogState extends State<OpenFilterDialog> {
  @override
  void initState() {
    super.initState();
  }

  List<Ingredient> selIgdt = []; //선택한 재료 담는 리스트

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot>? streamData =
        FirebaseFirestore.instance.collection('all_ingredient')
        //.where('name', isNotEqualTo: widget.myIgdt)
        .snapshots();


    return StreamBuilder<QuerySnapshot>(
        stream: streamData,
        builder: (context, snapshot) {
          // if (!snapshot.hasData)
          //   return LinearProgressIndicator(); //데이터가 없을때 프로그래스 바
          if (snapshot.hasError) return Text('snapShot Error'); //에러났을때
          if (snapshot.connectionState == ConnectionState.waiting) {
            //기다리는중일때
            return Text("Loading");
          }
          return FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.deepOrangeAccent,
            onPressed: () {
              print('내 냉장고속 재료 :' + widget.myIgdt.toString());
              print('전체 재료 :' + snapshot.data!.docs.map((e) => Ingredient.fromSnapShot(e)).toString());
              
              openFilterDialog(context, snapshot.data!.docs);
            },
          );
        });
  }

  void openFilterDialog(
      BuildContext context, List<DocumentSnapshot> snapshot) async {
    List<Ingredient> allIgdt = snapshot.map((e) => Ingredient.fromSnapShot(e)).toList();
    






    

    selIgdt.clear();

    await FilterListDialog.display<Ingredient>(
      context,
      listData: allIgdt,
      selectedListData: selIgdt,
      choiceChipLabel: (e) => e!.name.toString(),
      validateSelectedItem: (e, val) => e!.contains(val),
      onItemSearch: (e, query) {
        return e.name.toString().toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        
        setState(() async {
          selIgdt = List.from(list!);
          print(selIgdt.toString());

          // if(selIgdt.length > 0){
          //   for(int i = 0; i < selIgdt.length; i++){
            
          //     //선택한 재료 insert한다
          //     widget.myIgdt!.insert(selIgdt.length + i, selIgdt[i]);
          //   }
          // }

          //await widget.myIgdt!.se

          

          print(widget.myIgdt.toString());
          //바깥에 있는 내 재료 목ㅗ을 초화야함


        });
        Navigator.pop(context); //뒤로가기
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
      controlButtons: [],
      themeData: FilterListThemeData(context,
          headerTheme: HeaderThemeData(
              headerTextStyle:
                  TextStyle(color: Colors.deepOrangeAccent, fontSize: 17),
              searchFieldHintText: '검색',
              searchFieldTextStyle: TextStyle(
                fontSize: 16,
              )),
          wrapCrossAxisAlignment: WrapCrossAlignment.center,
          controlButtonBarTheme: ControlButtonBarThemeData(
              padding: EdgeInsets.all(5),
              controlButtonTheme: ControlButtonThemeData(
                  primaryButtonBackgroundColor: Colors.white,
                  primaryButtonTextStyle:
                      TextStyle(color: Colors.deepOrangeAccent)))),
      choiceChipBuilder: (context, igdt, isSelected) {
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Chip(
            label: Text(igdt.name),
            labelStyle: isSelected!
                ? TextStyle(color: Colors.white)
                : TextStyle(color: Colors.black),
            avatar: Icon(
              Icons.egg,
              size: 20,
              color: isSelected? Colors.white : Colors.deepOrangeAccent,
            ),
            shape:
                StadiumBorder(side: BorderSide(color: Colors.deepOrangeAccent)),
            backgroundColor:
                isSelected? Colors.deepOrangeAccent : Colors.white,
          ),
        );
      },
    );
  }

  Future InsertIgdt(Ingredient igdt) async {


  }


}
