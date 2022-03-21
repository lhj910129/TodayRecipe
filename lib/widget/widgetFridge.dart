import 'package:flutter/material.dart';
import 'package:todayrecipe/model/ingredient.dart';

//냉장고 만들기
class WidgetFridge extends StatefulWidget {
  final List<Ingredient> igdt;
  const WidgetFridge({required this.igdt});

  @override
  State<WidgetFridge> createState() => _WidgetFridgeState();
}

class _WidgetFridgeState extends State<WidgetFridge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        //재료목록
        getIgdt()
      ,
    );
  }



  //재료
  Widget? getIgdt(){
    List<Widget> chips = [];
    
    if(widget.igdt != null && widget.igdt.length > 0){
      

    }







    return Wrap(
      children: [],
    );
  }

}
