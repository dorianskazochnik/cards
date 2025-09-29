import 'package:flutter/material.dart';
import 'package:cards/core/presentation/page/consts.dart';

class KeyWordText extends StatefulWidget {
  final List<String> text;
  final List<String> keywordsstr;
  final double width, height;
  KeyWordText({required this.text, required this.keywordsstr, required this.width, required this.height});

  @override
  KeyWordTextState createState() => KeyWordTextState();
}

class KeyWordTextState extends State<KeyWordText> {
  Set<String> selectedKeywords = {};

  Set<String> getSelectedKeywords() {
    return selectedKeywords;
  }

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> textSpans = [];
    List<String> keywords = widget.keywordsstr;
    for (String word in widget.text) {
      String kword = word.split('.').join().split('?').join().split(',').join();
      bool selected = selectedKeywords.contains(kword);
      bool keyword = (keywords.contains(kword));
      textSpans.add(
        WidgetSpan(
          child: Text(
            '$word ',
            style: TextStyle(
              color: black,
              fontSize: sizetext,
              fontFamily: "Gazprombank-Sans",
            ),
          ),
        )
      );
      if (keyword) {
        textSpans.last = WidgetSpan(
          child: GestureDetector(
            onTap: () {
              if (selected) {
                setState(() {
                  selectedKeywords.remove(kword);
                });
              } else if (selectedKeywords.length < 3){
                setState(() {
                  selectedKeywords.add(kword);
                });
              }
            },
            child: Text(
              '$word ',
              style: TextStyle(
                color: (selected) ? fialka : black,
                fontSize: sizetext,
                fontFamily: (selected) ? "Halvar" : "Gazprombank-Sans",
              ),
            ),
          ),
        );
      }
    }
    return Container(
      width: widget.width,
      height: widget.height - 32,
      padding: EdgeInsetsGeometry.all(32.0),
      child: RichText(
        text: TextSpan(
          children: textSpans,
        ),
      ),
    );
  }
}
