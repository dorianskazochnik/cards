import 'package:flutter/material.dart';
import 'package:cards/core/presentation/page/consts.dart';

class Word extends StatelessWidget {
  final String text;
  var isSelected = false;
  Word({required this.text});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        isSelected != isSelected;
      },
      child: Text(text),
    );
  }
}