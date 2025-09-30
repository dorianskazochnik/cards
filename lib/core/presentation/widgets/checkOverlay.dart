import 'package:cards/core/domain/userChoices.dart';
import 'package:flutter/material.dart';
import 'package:cards/core/presentation/page/consts.dart';


class CheckOverlay extends StatelessWidget {
  final double width, height;
  final List<String> results;
  final String correct;
  CheckOverlay({required this.width, required this.height, required this.results, required this.correct});

  late int selected;
  late bool res;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            color: Colors.black.withValues(alpha: 0.5),
          ),
          Center(
            child: Container(
              width: width - 32,
              height: 300,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        selected = 0;
                        res = outputResult();
                        Navigator.of(context).pop(res);
                      },
                      child: Text(
                        results[0],
                        style: TextStyle(
                          color: black,
                          fontSize: sizetext,
                          fontFamily: "Halvar",
                        ),
                      )
                  ),
                  TextButton(
                      onPressed: () {
                        selected = 1;
                        res = outputResult();
                        Navigator.of(context).pop(res);
                      },
                      child: Text(
                        results[1],
                        style: TextStyle(
                          color: black,
                          fontSize: sizetext,
                          fontFamily: "Halvar",
                        ),
                      )
                  ),
                  TextButton(
                      onPressed: () {
                        selected = 2;
                        res = outputResult();
                        Navigator.of(context).pop(res);
                      },
                      child: Text(
                        results[2],
                        style: TextStyle(
                          color: black,
                          fontSize: sizetext,
                          fontFamily: "Halvar",
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool outputResult() {
    return isResultCorrect(results[selected], correct);
  }
}