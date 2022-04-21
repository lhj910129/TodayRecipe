import 'package:flutter/material.dart';

class KitchenBody extends StatelessWidget {
  const KitchenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //냉장고와 재료들이 표시된다.

    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Container();
      },
      itemCount: 5,
    );
  }
}
