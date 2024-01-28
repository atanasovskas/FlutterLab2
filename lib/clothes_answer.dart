import 'package:flutter/material.dart';

class ClothesAnswer extends StatelessWidget {
  String answer;
  final VoidCallback tapped;

  ClothesAnswer(this.tapped, this.answer);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: ElevatedButton(onPressed: tapped, child: Text(
          style: TextStyle(
            color: Colors.red,
          ), answer),
          style: ElevatedButton.styleFrom(
              primary: Colors.green
          )),
    );
  }
}
