import 'package:flutter/material.dart';
import 'package:cards/core/presentation/page/consts.dart';

class KeyWordText extends StatefulWidget {
  final String text;
  final String keywordsstr;
  KeyWordText({required this.text, required this.keywordsstr});

  @override
  KeyWordTextState createState() => KeyWordTextState();
}

class KeyWordTextState extends State<KeyWordText> {
  Set<String> hoveredKeywords = {};

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> textSpans = [];
    List<String> keywords = widget.keywordsstr.split(',').toList();
    for (String word in widget.text.split(' ')) {
      bool hovered = hoveredKeywords.contains(word);
      textSpans.add(
        TextSpan(
          text: '$word ',
          style: TextStyle(
            color: black,
            fontSize: sizetext,
            fontFamily: "Gazprombank-Sans",
          )
        )
      );
      if (keywords.contains(' $word') || keywords.contains(' $word]') || keywords.contains('[$word')) {
        textSpans.last = TextSpan(
          text: '$word ',
          onEnter: (_) {
            setState(() {
              hoveredKeywords.add(word);
            });
          },
          onExit: (_) {
            setState(() {
              hoveredKeywords.remove(word);
            });
          },
          style: TextStyle(
            color: (hovered) ? fialka : black,
            fontSize: sizetext,
            fontFamily: "Gazprombank-Sans",
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }
}
